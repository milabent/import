class Import::Command
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
    @successes = 0
  end

  def execute
    resource_collection.each do |resource|
      if resource.valid?
        begin
          @successes += 1 if resource._create_data_from_import
        rescue => e
          Import::Log.create_error(@plan, e.to_s, resource.to_json)
        end
      else
        Import::Log.create_error(@plan, 'Invalid resource', resource.to_json)
      end
    end
    create_result_log
  end

  private

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

  def create_result_log
    if @successes > 0
      Import::Log.create_success(@plan, "Imported #{@successes} resources")
    else
      Import::Log.create_notice(@plan, "Imported #{@successes} resources")
    end
  end
end
