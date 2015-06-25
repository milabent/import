require 'active_resource'

class Import::Resources::Base < ActiveResource::Base
  self.site = ""

  def self.import(&block)
    define_method(:_create_data_from_import, &block)
  end
  
  def self.with_import_url(import_url)
    self.site = import_url
    @import_url = import_url
    self
  end

  def self.collection_path(prefix_options = {}, query_options = nil)
    @import_url
  end
end
