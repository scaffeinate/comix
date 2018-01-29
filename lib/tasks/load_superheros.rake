require 'smarter_csv'
require 'mediawiki-gateway'
namespace :load do
  desc 'Load superheros'
  SEEDS_DIR = File.join(Rails.root, "lib", "seeds")
  @key_mapping = {id: :identity, appearances: :num_appearances }
  @options = { key_mapping: @key_mapping, remove_empty_values: false }
  @superhero_columns = [:page_id, :name, :urlslug, :identity, :align, :eye, :hair, :sex, :gsm, :alive, :num_appearances, :first_appearance, :year, :universe]
  @image_columns = [:url, :description, :superhero_id]
  @universes = { marvel: 1, dc: 2 }
  task :superheros => :environment do
    @marvel_superheros = fetch_superheros(:marvel)
    import_records(Superhero, @superhero_columns, @marvel_superheros)

    @dc_superheros = fetch_superheros(:dc)
    import_records(Superhero, @superhero_columns, @dc_superheros)
  end
  
  task :images => :environment do
    @universes = Superhero.left_joins(:images).where("images.id IS NULL").group_by(&:universe)
    @successful_fetches = 0
    @failed_fetches = 0
    @universes.each do |u, v|
      puts "\n<======= Processing #{u} universe ========>"
      @superheros = v
      @media = MediaWiki::Gateway.new("http://#{u}.wikia.com/api.php")
      @superheros.each do |superhero|
        puts "\n<======= Fetching Images for #{superhero.name} ========>"
        images_arr = fetch_image_urls(@media, superhero)
        if !images_arr.nil? && !images_arr.empty?
          puts "\n<======= Importing #{images_arr.length} images ========>"
          import_records(Image, @image_columns, images_arr)
          @successful_fetches += 1
          puts "\n<======= Imported #{images_arr.length} images for #{superhero.name} ========>"
        else
          @failed_fetches += 1
          puts "\n<======= Failed to Fetch images for #{superhero.name} ========>"
        end
        break
      end
      break
    end
    puts "\n<======= Number of successful fetches = #{@successful_fetches} ========>"
    puts "\n<======= Number of failed fetches = #{@failed_fetches} ========>"
  end
end

def fetch_superheros(universe)
  puts "\n<======= Fetching #{universe.to_s.camelize} Superheros ========>"
  superheros = SmarterCSV.process("#{SEEDS_DIR}/#{universe}-wikia-data.csv", @options)
  superheros.each do |superhero|
      superhero[:universe] = @universes[universe]
  end
  puts "Number of #{universe.to_s.camelize} Superheros: #{superheros.size}"
  return superheros
end

def import_records(clazz, columns, records)
  return unless columns && records
  begin
    clazz.import(columns, records)
  rescue StandardError => e
    puts "Exception occurred while importing records for #{clazz} => #{e.message}"
  end
end

def fetch_image_urls(media, superhero)
  images = (media.images(superhero.page_id.to_i) || Array.new)
  res = Array.new
  images.each do |image|
    file_name = strip_file_type(image)
    image_info = fetch_image_info(media, file_name) if file_name
    image_info[:superhero_id] = superhero.id
    res.push(image_info) if image_info
  end
  return res
end

def strip_file_type(file)
  begin
    file.starts_with?("File") ? file[5..file.length-1] : file[6..file.length-1]
  rescue StandardError => e
    puts "Exception occurred while trying to strip_file_type for #{file} => #{e.message}"
  end
end

def fetch_image_info(media, name)
  begin
    image_info = media.image_info(name, 'iiprop' => ['url'])
    url = image_info ? image_info["url"] : nil
    descriptionurl = image_info ? image_info["descriptionurl"] : nil
    return { url: url, description: descriptionurl } if url
  rescue StandardError => e
    puts "Exception occurred while fetching image_info for #{name} => #{e.message}"
  end
  return nil
end