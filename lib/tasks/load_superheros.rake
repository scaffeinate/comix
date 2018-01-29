require 'smarter_csv'
namespace :load do
    desc 'Load superheros'
    SEEDS_DIR = File.join(Rails.root, "lib", "seeds")
    @key_mapping = {id: :identity, appearances: :num_appearances }
    @options = { key_mapping: @key_mapping, remove_empty_values: false }
    @columns = [:page_id, :name, :urlslug, :identity, :align, :eye, :hair, :sex, :gsm, :alive, :num_appearances, :first_appearance, :year, :universe]
    MCU, DCU = 1, 2
    task :superheros do
        puts "\n<======= Loading Marvel Superheros ========>"
        @marvel_superheros = SmarterCSV.process("#{SEEDS_DIR}/marvel-wikia-data.csv", @options)
        puts "Number of Marvel Superheros: #{@marvel_superheros.size}"
        @marvel_superheros.each do |superhero|
            superhero[:universe] = MCU
        end
        Superhero.import(@columns, @marvel_superheros)

        puts "\n\n<======= Loading DC Superheros ========>"
        @dc_superheros = SmarterCSV::process("#{SEEDS_DIR}/dc-wikia-data.csv", @options)
        puts "Number of DC Superheros: #{@dc_superheros.size}"

        @dc_superheros.each do |superhero|
            superhero[:universe] = DCU
        end
        Superhero.import(@columns, @dc_superheros)
    end
end
