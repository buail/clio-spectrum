namespace :locations do
  desc 'loads location database from yaml file'
  task :load => :environment do
    puts_and_log("Starting rake task to load Locations from location.yml", :info)
    debugger
    records_loaded = Location.clear_and_load_fixtures!.count
    puts_and_log("#{records_loaded} records loaded.")
  end
end

