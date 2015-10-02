class Import::Plan < ActiveRecord::Base
  has_many :logs
  validates :name, :resource_type, presence: true
  validate :valid_resource_type

  def resource_class
    begin
      resource_type.constantize
    rescue NameError => e
      nil
    end
  end

  def last_success_at
    logs.where(reason: :success).last.try(:created_at)
  end

  def last_error_at
    logs.where(reason: :error).last.try(:created_at)
  end

  def build_copy
    copy = self.class.new(attributes.except('id', 'created_at', 'updated_at'))
    copy.name += ' (copy)'
    copy
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
