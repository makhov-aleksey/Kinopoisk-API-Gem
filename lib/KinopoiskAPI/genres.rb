module KinopoiskAPI
  class Genres
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_similar][:method]}?#{METHODS[:get_similar][:id]}=#{id}"
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

    def json
      uri = URI(@url)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end

    def genres
      @json['genreData']
    end

  end
end