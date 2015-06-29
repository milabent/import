module Import::Commands::Logger
  extend ActiveSupport::Concern

  def initialize(plan, import_all: false)
    super
    @successes = 0
  end

  def execute
    super
    create_result_log
    @successes
  end

  def around_resource_import(resource, &block)
    if resource.valid?
      begin
        @successes += 1 if super
      rescue => e
        Import::Log.create_error(@plan, e.to_s, resource.to_json)
      end
    else
      Import::Log.create_error(@plan, 'Invalid resource', resource.to_json)
    end
  end

  private

  def create_result_log
    if @successes > 0
      Import::Log.create_success(@plan, "Imported #{@successes} resources")
    else
      Import::Log.create_notice(@plan, "Imported #{@successes} resources")
    end
  end
end
