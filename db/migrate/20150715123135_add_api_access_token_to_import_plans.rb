class AddApiAccessTokenToImportPlans < ActiveRecord::Migration
  def change
    add_column :import_plans, :api_access_token, :string
  end
end
