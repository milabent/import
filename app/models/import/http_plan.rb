class Import::HTTPPlan < Import::Plan
  validates :url, presence: true
end
