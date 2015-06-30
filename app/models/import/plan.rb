class Import::Plan < ActiveRecord::Base
  validates :name, :resource_type, presence: true
  validate :valid_resource_type

  def resource_class
    begin
      resource_type.constantize
    rescue NameError => e
      nil
    end
  end

  private

  def valid_resource_type
    if resource_class.nil?
      errors.add(:resource_type, :unknown_type)
    elsif !(resource_class < Import::Resources::Base)
      errors.add(:resource_type, :invalid_type)
    end
  end
end
