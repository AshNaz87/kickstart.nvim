local function gh(repo) return 'https://github.com/' .. repo end

local java_filetypes = { 'java' }

local function has_module(name) return (pcall(require, name)) end

-- Utility to extend or override a table.
local function extend_or_override(config, custom, ...)
  if type(custom) == 'function' then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend('force', config, custom)
  end
  return config
end

-- which-key.nvim, mason.nvim and blink.cmp are already installed by init.lua.
vim.pack.add { gh 'mfussenegger/nvim-jdtls' }

local opts ---@type table|nil
local function get_opts()
  if opts then return opts end

  local cmd = { vim.fn.exepath 'jdtls', '--java-executable', vim.trim(vim.fn.system 'jenv which java') }
  if has_module 'mason' then
    local lombok_jar = vim.fn.expand '$MASON/share/jdtls/lombok.jar'
    table.insert(cmd, string.format('--jvm-arg=-javaagent:%s', lombok_jar))
  end

  opts = {
    root_dir = function(path)
      return vim.fs.root(path, {
        'mvnw', 'gradlew', 'settings.gradle', 'settings.gradle.kts', -- multi-module
        'pom.xml', 'build.xml', 'build.gradle', 'build.gradle.kts', -- single-module
        '.git',
      })
    end,

    project_name = function(root_dir) return root_dir and vim.fs.basename(root_dir) end,

    jdtls_config_dir = function(project_name) return vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name .. '/config' end,
    jdtls_workspace_dir = function(project_name) return vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name .. '/workspace' end,

    cmd = cmd,
    full_cmd = function(o)
      local fname = vim.api.nvim_buf_get_name(0)
      local root_dir = o.root_dir(fname)
      local project_name = o.project_name(root_dir)
      local full_cmd = vim.deepcopy(o.cmd)
      if project_name then
        vim.list_extend(full_cmd, { '-configuration', o.jdtls_config_dir(project_name), '-data', o.jdtls_workspace_dir(project_name) })
      end
      return full_cmd
    end,

    -- These depend on nvim-dap, but can additionally be disabled by setting false here.
    dap = { hotcodereplace = 'auto', config_overrides = {} },
    dap_main = {},
    test = true,
    settings = {
      java = {
        inlayHints = {
          parameterNames = { enabled = 'all' },
        },
      },
    },
  }

  return opts
end

local function attach_jdtls()
  local o = get_opts()

  local bundles = {} ---@type string[]
  if has_module 'mason' then
    local mason_registry = require 'mason-registry'
    if o.dap and has_module 'dap' and mason_registry.is_installed 'java-debug-adapter' then
      bundles = vim.fn.glob('$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*jar', false, true)
      if o.test and mason_registry.is_installed 'java-test' then
        vim.list_extend(bundles, vim.fn.glob('$MASON/share/java-test/*.jar', false, true))
      end
    end
  end

  local fname = vim.api.nvim_buf_get_name(0)
  local config = extend_or_override({
    cmd = o.full_cmd(o),
    root_dir = o.root_dir(fname),
    init_options = { bundles = bundles },
    settings = o.settings,
    -- enable CMP capabilities
    capabilities = has_module('blink.cmp') and require('blink.cmp').get_lsp_capabilities()
      or has_module('cmp_nvim_lsp') and require('cmp_nvim_lsp').default_capabilities()
      or nil,
  }, o.jdtls)

  -- Existing server will be reused if the root_dir matches.
  require('jdtls').start_or_attach(config)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = java_filetypes,
  callback = attach_jdtls,
})

-- Setup keymap and dap after the lsp is fully attached.
-- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not (client and client.name == 'jdtls') then return end

    local o = get_opts()
    local wk = require 'which-key'
    wk.add {
      {
        mode = 'n',
        buffer = args.buf,
        { '<leader>cx', group = 'extract' },
        { '<leader>cxv', require('jdtls').extract_variable_all, desc = 'Extract Variable' },
        { '<leader>cxc', require('jdtls').extract_constant, desc = 'Extract Constant' },
        { '<leader>cgs', require('jdtls').super_implementation, desc = 'Goto Super' },
        { '<leader>cgS', require('jdtls.tests').goto_subjects, desc = 'Goto Subjects' },
        { '<leader>co', require('jdtls').organize_imports, desc = 'Organize Imports' },
      },
    }
    wk.add {
      {
        mode = 'x',
        buffer = args.buf,
        { '<leader>cx', group = 'extract' },
        { '<leader>cxm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], desc = 'Extract Method' },
        { '<leader>cxv', [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]], desc = 'Extract Variable' },
        { '<leader>cxc', [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]], desc = 'Extract Constant' },
      },
    }

    if has_module 'mason' then
      local mason_registry = require 'mason-registry'
      if o.dap and has_module 'dap' and mason_registry.is_installed 'java-debug-adapter' then
        require('jdtls').setup_dap(o.dap)
        if o.dap_main then require('jdtls.dap').setup_dap_main_class_configs(o.dap_main) end

        if o.test and mason_registry.is_installed 'java-test' then
          wk.add {
            {
              mode = 'n',
              buffer = args.buf,
              { '<leader>t', group = 'test' },
              {
                '<leader>tt',
                function() require('jdtls.dap').test_class { config_overrides = type(o.test) ~= 'boolean' and o.test.config_overrides or nil } end,
                desc = 'Run All Test',
              },
              {
                '<leader>tr',
                function() require('jdtls.dap').test_nearest_method { config_overrides = type(o.test) ~= 'boolean' and o.test.config_overrides or nil } end,
                desc = 'Run Nearest Test',
              },
              { '<leader>tT', require('jdtls.dap').pick_test, desc = 'Run Test' },
            },
          }
        end
      end
    end
  end,
})
