if defined?(ActiveAdmin)
  ActiveAdmin.register ::Import::DatabasePlan do
    menu priority: 97, parent: 'Import', label: -> { ::Import::DatabasePlan.model_name.human(count: 2) }
    permit_params :url, :resource_type, :interval

    index do
      selectable_column
      id_column
      column :name
      column :database_connection
      column :created_at
      actions
    end

    member_action :import_all, method: :put do
      ImportJob.perform_later(resource, import_all: true)
      redirect_to resource_path, notice: t('admin.import_plans.started_import')
    end

    member_action :continue_import, method: :put do
      ImportJob.perform_later(resource)
      redirect_to resource_path, notice: t('admin.import_plans.started_import')
    end

    action_item :view, only: :show do
      link_to t('admin.import_plans.continue_import'), continue_import_admin_import_database_plan_path(import_database_plan), method: :put, data: { confirm: t('admin.import_plans.are_you_sure') }
    end
    action_item :view, only: :show do
      link_to t('admin.import_plans.import_all'), import_all_admin_import_database_plan_path(import_database_plan), method: :put, data: { confirm: t('admin.import_plans.are_you_sure') }
    end
  end
end