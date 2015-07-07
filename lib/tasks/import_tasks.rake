namespace :import do
  desc 'Import changes from all import plans'
  task changes: :environment do |task|
    ImportJob.perform_later('all')
  end
end
