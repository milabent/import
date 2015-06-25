class CreateImportPlans < ActiveRecord::Migration
  def change
    create_table :import_plans do |t|
      t.string :url, null: false
      t.string :resource_type, null: false
      t.string :interval

      t.timestamps null: false
    end
  end
end
