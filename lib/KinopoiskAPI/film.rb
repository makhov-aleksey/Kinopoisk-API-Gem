module KinopoiskAPI
  class Film
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAIN_API}/#{METHODS[:get_film][:method]}?#{METHODS[:get_film][:id]}=#{id}"
      @json = json
    end

    def json
      uri = URI(@url)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end

    def title
      @json['nameRU']
    end

    def original_title
      @json['nameEN']
    end

    def slogan
      @json['slogan']
    end

    def description
      @json['description']
    end

    def year
      @json['year']
    end

    def kinopoisk_rating
      @json['ratingData']['rating']
    end

    def imdb_rating
      @json['ratingData']['ratingIMDb']
    end

  end
end