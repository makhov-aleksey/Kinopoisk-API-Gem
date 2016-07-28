module KinopoiskAPI
  class GlobalSearch
    attr_accessor :keyword, :url, :json

    def initialize(keyword)
      @keyword = keyword
      @url = "#{DOMAINS[:api]}/#{METHODS[:search_global][:method]}?#{METHODS[:search_global][:keyword]}=#{keyword}"
      @json = json
    end

    def keyword
      @json['keyword']
    end

    def number_of_films
      @json['searchFilmsCountResult']
    end

    def number_of_names
      @json['searchPeoplesCountResult']
    end

    def exactly
      rating_array = json_exactly['rating'].delete(' ').split('(')
      {
          title: json_exactly['nameRU'],
          original_title: json_exactly['nameEN'],
          info: json_exactly['description'],
          duration: json_exactly['filmLength'],
          year: json_exactly['year'],
          countries: json_exactly['country'],
          genres: json_exactly['genre'],
          rating: rating_array.first,
          number_of_rated: rating_array.last.delete(')'),
          poster: "#{DOMAINS[:kinopoisk][:poster][:film]}_#{json_exactly['id']}.jpg"
      }
    end

    def maybe
      correctly = []
      json_films.each do |film|
        rating_array = film['rating'].delete(' ').split('(')
        new_item = {
            title: film['nameRU'],
            original_title: film['nameEN'],
            info: film['description'],
            duration: film['filmLength'],
            year: film['year'],
            countries: film['country'],
            genres: film['genre'],
            rating: rating_array.first,
            number_of_rated: rating_array.last.delete(')'),
            poster: "#{DOMAINS[:kinopoisk][:poster][:film]}_#{film['id']}.jpg"
        }
        correctly.push(new_item)
      end
      correctly
    end

    def names
      correctly = []
      json_names.each do |name|
        new_item = {
            full_name: name['nameRU'],
            original_full_name: name['nameEN'],
            info: name['description'],
            duration: name['filmLength'],
            poster: "#{DOMAINS[:kinopoisk][:poster][:name]}_#{name['id']}.jpg"
        }
        correctly.push(new_item)
      end
      correctly
    end

    private

    def json
      uri = URI(URI.encode(@url))
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end

    def json_exactly
      @json['youmean']
    end

    def json_films
      @json['searchFilms']
    end

    def json_names
      @json['searchPeople']
    end

  end
end