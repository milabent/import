class AddFieldsForDatabaseBase < ActiveRecord::Migration
  def change
    add_column :import_plans, :database_connection, :string
    add_column :import_plans, :database_table, :string
  end
end
