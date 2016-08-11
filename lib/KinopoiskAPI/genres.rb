module KinopoiskAPI
  class Genres
    attr_accessor :url, :json

    def initialize
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_genres][:method]}"
      @json = json
    end

    def all
      correctly = []
      genres.each do |item|
        new_item = {
            id: item['genreID'],
            name: item['genreName']
        }
        correctly.push(new_item)
      end
      correctly
    end

    def status
      json.nil? ? false : true
    end

    private

    def json
      uri = URI(@url)
      response = Net::HTTP.get(uri)
      if KinopoiskAPI::valid_json?(response)
        JSON.parse(response)
      else
        nil
      end
    end

    def genres
      @json['genreData']
    end

  end
end