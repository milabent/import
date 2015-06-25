class Import::Command
  def self.import_all
    Import::Plan.all.each do |plan|
      import(plan)
    end
  end

  def self.import(plan)
    new(plan).execute
  end

  def initialize(plan)
    @url = plan.url
    @resource_class = plan.resource_class
  end

  def execute
    @resource_class.with_import_url(@url).all.each do |resource|
      if resource.valid?
        resource._create_data_from_import
      end
    end
  end
end
