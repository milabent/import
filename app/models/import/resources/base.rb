module Import::Resources::Base
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def import(&block)
      define_method(:_create_data_from_import, &block)
    end

    def after_import(&block)
      self.class.send(:define_method, :_after_import, &block)
    end

    def after_import_all(&block)
      self.class.send(:define_method, :_after_import_all, &block)
    end

    def after_import_changes(&block)
      self.class.send(:define_method, :_after_import_changes, &block)
    end
  end
end
