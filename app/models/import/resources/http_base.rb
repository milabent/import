require 'active_resource'

class Import::Resources::HTTPBase < ActiveResource::Base
  include Import::Resources::Base

  self.site = ""
  
  def self.for_import_plan(plan)
    self.site = plan.url
    @import_url = plan.url
    self
  end

  def self.collection_path(prefix_options = {}, query_options = nil)
    @import_url
  end
end
