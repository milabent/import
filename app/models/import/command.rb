class Import::Command
  prepend Import::Commands::Logger

  def self.continue_import(options = {})
    Import::Plan.all.each do |plan|
      new(plan, import_all: false).execute
    end
  end

  def self.import_all(options = {})
    Import::Plan.all.each do |plan|
      new(plan, import_all: true).execute
    end
  end

  def initialize(plan, import_all: false)
    @plan = plan
    @url = plan.url
    @resource_class = plan.resource_class
    @import_all = import_all
  end

  def execute
    resource_collection.each do |resource|
      around_resource_import(resource) do
        resource._create_data_from_import(@plan)
      end
    end
  end

  protected

  def around_resource_import(resource)
    yield
  end

  def resource_collection
    begin
      @resource_class.with_import_url(url).all
    rescue => e
      Import::Log.create_error(@plan, e.to_s)
      []
    end
  end

  def url
    (@url || '').gsub('###LAST_SUCCESS###', last_success)
  end

  def last_success
    time = Import::Log.last_success(@plan).try(:created_at)
    time && !@import_all ? time.utc.iso8601 : ''
  end
end
