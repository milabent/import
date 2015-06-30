class ImportJob < ActiveJob::Base
  prepend Import::JobLogger

  queue_as :default

  def perform(plan_or_all, import_all: false)
    if plan_or_all == :all
      for plan in Import::Plan
        perform_plan(plan, import_all: import_all)
      end
    elsif plan_or_all.is_a?(Import::Plan)
      perform_plan(plan_or_all, import_all: import_all)
    end
  end

  def perform_plan(plan, import_all: false)
    @plan = plan
    @url = plan.url
    @resource_class = plan.resource_class
    @import_all = import_all

    collection = resource_collection
    around_collection(collection) do
      collection.each do |resource|
        around_resource(resource) do
          resource._create_data_from_import(@plan)
        end
      end
    end
  end

  protected

  def import_all?
    @import_all
  end

  def around_collection(collection)
    yield
  end

  def around_resource(resource)
    yield
  end

  def resource_collection
    begin
      @resource_class.for_import_plan(@plan).all
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
    time && !import_all? ? time.utc.iso8601 : ''
  end
end
