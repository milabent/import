class CreateImportLogs < ActiveRecord::Migration
  def change
    create_table :import_logs do |t|
      t.string :reason
      t.references :plan, index: true
      t.text :resource_data
      t.text :notes

      t.timestamps null: false
    end
  end
end
