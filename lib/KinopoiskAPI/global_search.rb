module KinopoiskAPI
  class GlobalSearch
    attr_accessor :keyword, :url, :json

    def initialize(keyword)
      @keyword = keyword
      @url = "#{DOMAINS[:api]}/#{METHODS[:search_global][:method]}?#{METHODS[:search_global][:keyword]}=#{keyword}"
      @json = json
    end

    def all
      {
          keyword: keyword,
          quantity: {
              films: number_of_films,
              names: number_of_names
          },
          exactly: exactly,
          maybe: maybe,
          names: names
      }
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
          title: {
              ru: json_exactly['nameRU'],
              en: json_exactly['nameEN']
          },
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
            title: {
                ru: json_exactly['nameRU'],
                en: json_exactly['nameEN']
            },
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
            full_name: {
                ru: name['nameRU'],
                en: name['nameEN']
            },
            info: name['description'],
            poster: "#{DOMAINS[:kinopoisk][:poster][:name]}_#{name['id']}.jpg"
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
      uri = URI(URI.encode(@url))
      response = Net::HTTP.get(uri)
      if KinopoiskAPI::valid_json?(response)
        JSON.parse(response)
      else
        nil
      end
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