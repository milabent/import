class AddApiCredentialsToImportPlans < ActiveRecord::Migration
  def change
    add_column :import_plans, :api_user, :string
    add_column :import_plans, :api_password, :string
  end
end
