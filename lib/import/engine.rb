module Import
  class Engine < ::Rails::Engine
    initializer :import_engine do
      if defined?(ActiveAdmin)
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/models/**/"]
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/admin/import/**/"]
      end
    end
  end
end
