class Import::Log < ActiveRecord::Base
  belongs_to :plan

  def self.create_error(plan, notes, resource_data = nil)
    create(reason: :error, plan: plan, notes: notes, resource_data: resource_data)
  end

  def self.create_success(plan, notes)
    create(reason: :success, plan: plan, notes: notes)
  end

  def self.create_notice(plan, notes, resource_data = nil)
    create(reason: :notice, plan: plan, notes: notes, resource_data: resource_data)
  end

  def self.last_success(plan)
    where(reason: :success, plan: plan).order(:created_at).last
  end
end
