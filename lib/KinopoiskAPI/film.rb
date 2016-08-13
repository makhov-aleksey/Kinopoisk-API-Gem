module KinopoiskAPI
  class Film
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_film][:method]}?#{METHODS[:get_film][:id]}=#{id}"
      @json = json
    end

    def all
      {
          id: @id,
          url: url,
          title: title,
          slogan: slogan,
          description: description,
          poster: poster,
          year: year,
          kinopoisk: kinopoisk,
          imdb: imdb,
          number_of_reviews: number_of_reviews,
          duration: duration,
          countries: countries,
          genres: genres,
          video: video,
          is_sequel_or_prequel: is_sequel_or_prequel,
          is_similar_films: is_similar_films,
          is_imax: is_imax,
          is_3d: is_3d,
          rating_mpaa: rating_mpaa,
          minimal_age: minimal_age,
          names: all_names
      }
    end

    def url
      @json['webURL'].present? ? @json['webURL'] : nil
    end

    def title
      {
          ru: @json['nameRU'].present? ? @json['nameRU'] : nil,
          en: @json['nameEN'].present? ? @json['nameEN'] : nil
      }
    end

    def slogan
      @json['slogan'].present? ? @json['slogan'] : nil
    end

    def description
      @json['description'].present? ? @json['description'] : nil
    end

    def poster
      "#{DOMAINS[:kinopoisk][:poster][:film]}_#{@id}.jpg"
    end

    def year
      @json['year'].present? ? @json['year'] : nil
    end

    def kinopoisk
      local_data = @json['ratingData']

      if !local_data.nil?
        rating = @json['ratingData']['rating'].nil? ? nil : @json['ratingData']['rating']
        quantity = @json['ratingData']['ratingVoteCount'].nil? ? nil : @json['ratingData']['ratingVoteCount'].to_s.delete(' ').to_i

        good_reviews_in_percentage = @json['ratingData']['ratingGoodReview'].nil? ? nil : @json['ratingData']['ratingGoodReview']
        number_of_good_reviews = @json['ratingData']['ratingGoodReviewVoteCount'].nil? ? nil : @json['ratingData']['ratingGoodReviewVoteCount'].to_s.delete(' ').to_i

        waiting_in_percentage = @json['ratingData']['ratingAwait'].nil? ? nil : @json['ratingData']['ratingAwait']
        number_of_waiting = @json['ratingData']['ratingAwaitCount'].nil? ? nil : @json['ratingData']['ratingAwaitCount'].to_s.delete(' ').to_i

        film_critics_in_percentage = @json['ratingData']['ratingFilmCritics'].nil? ? nil : @json['ratingData']['ratingFilmCritics']
        film_critics = @json['ratingData']['ratingFilmCriticsVoteCount'].nil? ? nil : @json['ratingData']['ratingFilmCriticsVoteCount'].to_s.delete(' ').to_i

        rf_critics_in_percentage = @json['ratingData']['ratingRFCritics'].nil? ? nil : @json['ratingData']['ratingRFCritics']
        rf_critics = @json['ratingData']['ratingRFCriticsVoteCount'].nil? ? nil : @json['ratingData']['ratingRFCriticsVoteCount'].to_s.delete(' ').to_i
      else
        rating = 0.0
        quantity = 0

        good_reviews_in_percentage = '0%'
        number_of_good_reviews = 0

        waiting_in_percentage = '0%'
        number_of_waiting = 0

        film_critics_in_percentage = '0%'
        film_critics = 0

        rf_critics_in_percentage = '0%'
        rf_critics = 0
      end

      {
          rating: rating,
          quantity: quantity,

          good_reviews_in_percentage: good_reviews_in_percentage,
          number_of_good_reviews: number_of_good_reviews,

          waiting_in_percentage: waiting_in_percentage,
          number_of_waiting: number_of_waiting,

          film_critics_in_percentage: film_critics_in_percentage,
          film_critics: film_critics,

          rf_critics_in_percentage: rf_critics_in_percentage,
          rf_critics: rf_critics
      }
    end

    def imdb
      local_data = @json['ratingData']

      if !local_data.nil?
        rating = @json['ratingData']['ratingIMDb'].nil? ? 0.0 : @json['ratingData']['ratingIMDb']
        quantity = @json['ratingData']['ratingIMDbVoteCount'].nil? ? 0 : @json['ratingData']['ratingIMDbVoteCount'].to_s.delete(' ').to_i
      else
        rating = 0.0
        quantity = 0
      end

      {
          id: @json['imdbID'],
          rating: rating,
          quantity: quantity
      }
    end

    def number_of_reviews
      @json['reviewsCount'].present? ? @json['year'] : nil
    end

    def duration
      @json['filmLength'].present? ? @json['filmLength'] : 0
    end

    def countries
      @json['country'].present? ? @json['country'].split(',').map { |country| country.strip } : nil
    end

    def genres
      @json['genre'].present? ?  @json['genre'].split(',').map { |genre| genre.strip } : nil
    end

    def video
      @json['videoURL'].present? ? @json['videoURL'] : nil
    end

    def is_sequel_or_prequel
      @json['isHasSequelsAndPrequelsFilms'].present? ? @json['isHasSequelsAndPrequelsFilms'] : false
    end

    def is_similar_films
      @json['isHasSimilarFilms'].present? ? @json['isHasSimilarFilms'] : false
    end

    def is_imax
      @json['isIMAX'].present? ? @json['isIMAX'] : false
    end

    def is_3d
      @json['is3D'].present? ? @json['is3D'] : false
    end

    def rating_mpaa
      @json['ratingMPAA'].present? ? @json['ratingMPAA'] : nil
    end

    def minimal_age
      @json['ratingAgeLimits'].present? ? @json['ratingAgeLimits'] : 0
    end

    def names
      correctly = {}
      if creators.any?
        creators.each do |items|
          new_items = []
          items.each do |item|
            new_item = {
                id: item['id'],
                url: "#{DOMAINS[:kinopoisk][:main]}/name/#{item['id']}",
                full_name: {
                    ru: item['nameRU'].present? ? item['nameRU'] : nil,
                    en: item['nameEN'].present? ? item['nameEN'] : nil
                },
                description: item['description'].present? ? item['description'] : nil,
                poster: "#{DOMAINS[:kinopoisk][:poster][:name]}_#{item['id']}.jpg",
                profession: item['professionText'].present? ? item['professionText'] : nil
            }
            new_items.push(new_item)
          end
          items.each do |item|
            correctly[item['professionKey']] = new_items
          end
        end
      end
      correctly
    end

    def name_profession(name)
      names[name].nil? ? nil : names[name]
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

    def creators
      @json['creators'].nil? ? nil : @json['creators']
    end

  end
end