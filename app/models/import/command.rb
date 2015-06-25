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
    @plan = plan
    @url = plan.url
    @resource_class = plan.resource_class
  end

  def execute
    successes = 0
    resource_collection.each do |resource|
      if resource.valid?
        begin
          successes += 1 if resource._create_data_from_import
        rescue => e
          Import::Log.create_error(@plan, e.to_s, resource.to_json)
        end
      else
        Import::Log.create_error(@plan, 'Invalid resource', resource.to_json)
      end
    end
    if successes > 0
      Import::Log.create_success(@plan, "Imported #{successes} resources")
    end
  end

  def resource_collection
    begin
      @resource_class.with_import_url(@url).all
    rescue => e
      Import::Log.create_error(@plan, e.to_s)
      []
    end
  end
end
