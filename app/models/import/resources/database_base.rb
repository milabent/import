require 'active_resource'

class Import::Resources::DatabaseBase < ActiveRecord::Base
  include Import::Resources::Base
  self.abstract_class = true

  def self.for_import_plan(plan, last_success: nil)
    @last_success = last_success
    self.table_name = plan.database_table
    self
  end

  def self.all(*args)
    @last_success.nil? ? super : super.where(["updated_at >= ?", @last_success.utc])
  end
end
