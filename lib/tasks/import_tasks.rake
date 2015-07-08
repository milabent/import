namespace :import do
  desc 'Import changes from all import plans'
  task changes: :environment do |task|
    ImportJob.perform_later('all')
  end
end

namespace :import do
  desc 'Import all resources from all import plans'
  task all: :environment do |task|
    ImportJob.perform_later('all', import_all: true)
  end
end
