class Import::DatabasePlan < Import::Plan
  validates :database_table, presence: true
end
