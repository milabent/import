class RemoveTypeFromImportPlans < ActiveRecord::Migration
  def change
    remove_column :import_plans, :type, :string, null: false, default: 'Import::HTTPPlan'
  end
end
