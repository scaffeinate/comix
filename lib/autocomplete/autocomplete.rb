require 'redis'
class Autocomplete

  def initialize
    @redis = Redis.new
  end

  def add(dataset)
    dataset.each do |data|
      for i in 0..data.length-1
        str = data[0..i]
        @redis.zadd('autocomplete', 0 , str)
      end
      @redis.zadd('autocomplete', 0, "#{data}%")
    end
  end

  def fetch_results(hash)
    query = hash[:query]
    num_results = hash[:num_results].to_i
    results = Array.new
    grab = 42
    start = @redis.zrank('autocomplete', query)
    if start
      while(results.length != num_results)
        range = @redis.zrange('autocomplete', start, start+grab-1)
        start += grab
        break unless range || !range.empty?
        range.each do |r|
          min_len = [query.length, r.length].min
          if query[0..min_len-1] != r[0..min_len-1]
            num_results = results.length
            break
          end
          if r[-1] == "%" && results.length != num_results
            results.push(r[0..-2])
          end
        end
      end
    end
    return results
  end
end
