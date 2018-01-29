require 'smarter_csv'
namespace :load do
  desc 'Load superheros'
  SEEDS_DIR = File.join(Rails.root, "lib", "seeds")
  @key_mapping = {id: :identity, appearances: :num_appearances }
  @options = { key_mapping: @key_mapping, remove_empty_values: false }
  @columns = [:page_id, :name, :urlslug, :identity, :align, :eye, :hair, :sex, :gsm, :alive, :num_appearances, :first_appearance, :year, :universe]
  @universes = { marvel: 1, dc: 2 }
  task :superheros do
    puts "\n<======= Loading Marvel Superheros ========>"
    @marvel_superheros = fetch_superheros(:marvel)
    puts "Number of Marvel Superheros: #{@marvel_superheros.size}"
    import(@columns, @marvel_superheros)

    puts "\n\n<======= Loading DC Superheros ========>"
    @dc_superheros = fetch_superheros(:dc)
    puts "Number of DC Superheros: #{@dc_superheros.size}"
    import(@columns, @dc_superheros)

    Superhero.find_each(&:save)
  end
end

def fetch_superheros(universe)
  superheros = SmarterCSV.process("#{SEEDS_DIR}/#{universe}-wikia-data.csv", @options)
  superheros.each do |superhero|
      superhero[:universe] = @universes[universe]
  end
end

def import(columns, records)
  begin
    Superhero.import(columns, records)
  rescue StandardError => e
    puts e
  end
end
