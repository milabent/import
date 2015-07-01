require 'active_resource'

class Import::Resources::HTTPBase < ActiveResource::Base
  include Import::Resources::Base

  self.site = ""
  
  def self.for_import_plan(plan, last_success: nil)
    @last_success = last_success
    @import_url = url(plan)
    self.site = @import_url
    self
  end

  private

  def self.url(plan)
    (plan.url || '').gsub('###LAST_SUCCESS###', (@last_success || ''))
  end

  def self.collection_path(prefix_options = {}, query_options = nil)
    @import_url
  end
end
