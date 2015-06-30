require 'active_resource'

class Import::Resources::HTTPBase < ActiveResource::Base
  include Import::Resources::Base

  self.site = ""
  
  def self.with_import_url(import_url)
    self.site = import_url
    @import_url = import_url
    self
  end

  def self.collection_path(prefix_options = {}, query_options = nil)
    @import_url
  end
end
