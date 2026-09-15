-- Additive: installs extra Mason tools via mason-registry directly, instead
-- of re-declaring init.lua's mason-tool-installer ensure_installed list
-- (whose setup() call is the single source of truth for LSP-driven installs).
local extra_tools = {
  'delve',
  'gofumpt',
  'goimports',
  'gomodifytags',
  'impl',
  'java-debug-adapter',
  'java-test',
  'prettierd',
}

local registry_ok, registry = pcall(require, 'mason-registry')
if not registry_ok then return end

local function ensure_installed()
  for _, name in ipairs(extra_tools) do
    if registry.has_package(name) then
      local pkg = registry.get_package(name)
      if not pkg:is_installed() then pkg:install() end
    end
  end
end

registry.refresh(ensure_installed)
