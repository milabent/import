if defined?(ActiveAdmin)
  ActiveAdmin.register ::Import::Plan do
    menu priority: 98, parent: 'Import', label: -> { ::Import::Plan.model_name.human(count: 2) }
    permit_params :url, :resource_type, :interval

    index do
      selectable_column
      id_column
      column :name
      column :resource_type
      column :last_success_at
      column :last_error_at
      actions
    end

    form do |f|
      f.inputs :name, :resource_type, :url, :database_connection, :database_table
      f.inputs except: [:name, :resource_type, :url, :database_connection, :database_table, :interval]
      f.actions
    end

    member_action :import_all, method: :put do
      ImportJob.perform_later(resource, import_all: true)
      redirect_to resource_path, notice: t('admin.import_plans.started_import')
    end

    member_action :import_changes, method: :put do
      ImportJob.perform_later(resource)
      redirect_to resource_path, notice: t('admin.import_plans.started_import')
    end

    action_item :view, only: :show do
      link_to t('admin.import_plans.import_changes'), import_changes_admin_import_plan_path(import_plan), method: :put, data: { confirm: t('admin.import_plans.are_you_sure') }
    end
    action_item :view, only: :show do
      link_to t('admin.import_plans.import_all'), import_all_admin_import_plan_path(import_plan), method: :put, data: { confirm: t('admin.import_plans.are_you_sure') }
    end
  end
end