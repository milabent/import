class AddTypeToPlans < ActiveRecord::Migration
  def change
    add_column :import_plans, :type, :string, null: false, default: 'Import::HTTPPlan'
    change_column_null(:import_plans, :url, true)
  end
end
