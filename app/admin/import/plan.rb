if defined?(ActiveAdmin)
  ActiveAdmin.register ::Import::Plan do
    menu priority: 98, parent: 'Import', label: -> { ::Import::Plan.model_name.human(count: 2) }
    permit_params :url, :resource_type, :interval, :api_access_token

    filter :name

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
      heading_inputs = [:name, :resource_type, :url, :api_access_token, :database_connection, :database_table]
      f.inputs *heading_inputs
      f.inputs except: (heading_inputs + [:interval])
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

    member_action :copy, method: :post do
      copy = resource.build_copy
      copy.save!
      redirect_to({ action: :edit, id: copy.id }, notice: t('admin.import_plans.copied_plan'))
    end

    action_item :copy, only: :show do
      link_to t('admin.import_plans.copy'), url_for(action: :copy), method: :post, data: { confirm: t('admin.import_plans.are_you_sure') }
    end
    action_item :import_changes, only: :show do
      link_to t('admin.import_plans.import_changes'), url_for(action: :import_changes), method: :put, data: { confirm: t('admin.import_plans.are_you_sure') }
    end
    action_item :import_all, only: :show do
      link_to t('admin.import_plans.import_all'), url_for(action: :import_all), method: :put, data: { confirm: t('admin.import_plans.are_you_sure') }
    end
  end
end