if defined?(ActiveAdmin)
  ActiveAdmin.register ::Import::Plan do
    menu priority: 99
    permit_params :url, :resource_type, :interval

    index do
      selectable_column
      id_column
      column :url
      column :created_at
      actions
    end
  end
end