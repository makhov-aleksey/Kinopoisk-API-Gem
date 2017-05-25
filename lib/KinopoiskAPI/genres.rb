module KinopoiskAPI
  class Genres < Agent
    attr_accessor :url

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

    private

    def genres
      @json['genreData']
    end

  end
end
