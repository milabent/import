if defined?(ActiveAdmin)
  ActiveAdmin.register ::Import::Log do
    menu priority: 99, parent: 'Import', label: -> { ::Import::Log.model_name.human(count: 2) }
    permit_params :url, :resource_type, :interval

    index do
      selectable_column
      id_column
      column :reason
      column :plan
      column :created_at
      actions
    end
  end
end