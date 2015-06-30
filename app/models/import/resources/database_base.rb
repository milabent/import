require 'active_resource'

class Import::Resources::DatabaseBase < ActiveRecord::Base
  include Import::Resources::Base
  self.abstract_class = true

  def self.for_import_plan(plan)
    self.table_name = plan.database_table
    self
  end
end
