RailsAdmin.config do |config|
  # REQUIRED:
  # Include the import action
  #     # See https://github.com/sferik/rails_admin/wiki/Actions
  config.actions do
    all
    import
  end
 
  # Optional:
  # Configure global RailsAdminImport options
  config.configure_with(:import) do |config|
    config.logging = true
  end
end
