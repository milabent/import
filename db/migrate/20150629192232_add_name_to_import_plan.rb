class AddNameToImportPlan < ActiveRecord::Migration
  def change
    add_column :import_plans, :name, :string, null: false, default: 'Unknown'
    change_column_default :import_plans, :name, nil
  end
end
