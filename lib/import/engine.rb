module Import
  class Engine < ::Rails::Engine
    initializer :import_engine do
      if defined?(ActiveAdmin)
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/admin/**/"]
      end
    end
  end
end
