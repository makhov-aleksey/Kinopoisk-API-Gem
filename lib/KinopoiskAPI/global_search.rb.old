module KinopoiskAPI
  class GlobalSearch < Agent
    attr_accessor :keyword, :url

    def initialize(keyword)
      @keyword = URI.encode(keyword)
      @url = "#{DOMAINS[:api]}/#{METHODS[:search_global][:method]}?#{METHODS[:search_global][:keyword]}=#{@keyword}"
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
      {
          id: json_exactly['id'],
          title: {
              ru: json_exactly['nameRU'],
              en: json_exactly['nameEN']
          },
          info: json_exactly['description'],
          duration: json_exactly['filmLength'],
          year: json_exactly['year'],
          countries: json_exactly['country'].split(',').map { |country| country.strip },
          genres: json_exactly['genre'].split(',').map { |genre| genre.strip },
          rating: json_exactly['rating'],
          poster: "#{DOMAINS[:kinopoisk][:poster][:film]}_#{json_exactly['id']}.jpg"
      }
    end

    def maybe
      correctly = []
      json_films.each do |film|
        new_item = {
            id: json_exactly['id'],
            title: {
                ru: json_exactly['nameRU'],
                en: json_exactly['nameEN']
            },
            info: film['description'],
            duration: film['filmLength'],
            year: film['year'],
            countries: film['country'].split(',').map { |country| country.strip },
            genres: film['genre'].split(',').map { |genre| genre.strip },
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

    private

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
