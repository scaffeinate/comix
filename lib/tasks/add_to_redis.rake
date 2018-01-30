require File.join(Rails.root, "lib", "autocomplete") + '/autocomplete.rb'
namespace :redis do
  task add: :environment do
    @superheros = Superhero.pluck(:name)
    Autocomplete.new.add(@superheros)
  end
end
