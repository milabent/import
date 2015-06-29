if defined?(ActiveAdmin)
  ActiveAdmin.register ::Import::Plan do
    menu priority: 98, parent: 'Import', label: -> { ::Import::Plan.model_name.human(count: 2) }
    permit_params :url, :resource_type, :interval

    index do
      selectable_column
      id_column
      column :url
      column :created_at
      actions
    end

    member_action :import_all, method: :put do
      imports = Import::Command.new(resource, import_all: true).execute
      redirect_to resource_path, notice: t('.n_resources_imported', count: imports)
    end

    member_action :continue_import, method: :put do
      imports = Import::Command.new(resource, import_all: false).execute
      redirect_to resource_path, notice: t('.n_resources_imported', count: imports)
    end

    action_item :view, only: :show do
      link_to t('.continue_import'), continue_import_admin_import_plan_path(import_plan), method: :put, data: { confirm: t('.are_you_sure') }
    end
    action_item :view, only: :show do
      link_to t('.import_all'), import_all_admin_import_plan_path(import_plan), method: :put, data: { confirm: t('.are_you_sure') }
    end
  end
end