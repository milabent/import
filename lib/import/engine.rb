module Import
  class Engine < ::Rails::Engine
    initializer :import_engine do
      if defined?(ActiveAdmin)
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/models/**/"]
        #ActiveAdmin.application.load_paths += Dir["#{config.root}/app/models/concerns/**/"]
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/admin/import/**/"]
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/jobs/**/"]
      end
    end
  end
end
