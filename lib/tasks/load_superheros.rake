require 'smarter_csv'
namespace :load do
  desc 'Load superheros'
  SEEDS_DIR = File.join(Rails.root, "lib", "seeds")
  @key_mapping = {id: :identity, appearances: :num_appearances }
  @options = { key_mapping: @key_mapping, remove_empty_values: false }
  @columns = [:page_id, :name, :urlslug, :identity, :align, :eye, :hair, :sex, :gsm, :alive, :num_appearances, :first_appearance, :year, :universe]
  @universes = { marvel: 1, dc: 2 }
  task :superheros do
    @marvel_superheros = fetch_superheros(:marvel)
    import(@columns, @marvel_superheros)

    @dc_superheros = fetch_superheros(:dc)
    import(@columns, @dc_superheros)
  end
end

def fetch_superheros(universe)
  puts "\n<======= Loading #{universe.to_s.camelize} Superheros ========>"
  superheros = SmarterCSV.process("#{SEEDS_DIR}/#{universe}-wikia-data.csv", @options)
  superheros.each do |superhero|
      superhero[:universe] = @universes[universe]
  end
  puts "Number of #{universe.to_s.camelize} Superheros: #{superheros.size}"
end

def import(columns, records)
  begin
    Superhero.import(columns, records)
  rescue StandardError => e
    puts e
  end
end
