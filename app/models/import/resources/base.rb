module Import::Resources::Base
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def import(&block)
      define_method(:_create_data_from_import, &block)
    end
  end
end
