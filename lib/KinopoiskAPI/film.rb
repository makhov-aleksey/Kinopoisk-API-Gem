module KinopoiskAPI
  class Film < Agent
    attr_accessor :id, :url

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
      if @json.present?
        local_data = @json['ratingData']

        if !local_data.nil?
          rating = local_data['rating'].nil? ? nil : local_data['rating']
          quantity = local_data['ratingVoteCount'].nil? ? nil : local_data['ratingVoteCount'].to_s.delete(' ').to_i

          good_reviews_in_percentage = local_data['ratingGoodReview'].nil? ? nil : local_data['ratingGoodReview']
          number_of_good_reviews = local_data['ratingGoodReviewVoteCount'].nil? ? nil : local_data['ratingGoodReviewVoteCount'].to_s.delete(' ').to_i

          waiting_in_percentage = local_data['ratingAwait'].nil? ? nil : local_data['ratingAwait']
          number_of_waiting = local_data['ratingAwaitCount'].nil? ? nil : local_data['ratingAwaitCount'].to_s.delete(' ').to_i

          film_critics_in_percentage = local_data['ratingFilmCritics'].nil? ? nil : local_data['ratingFilmCritics']
          film_critics = local_data['ratingFilmCriticsVoteCount'].nil? ? nil : local_data['ratingFilmCriticsVoteCount'].to_s.delete(' ').to_i

          rf_critics_in_percentage = local_data['ratingRFCritics'].nil? ? nil : local_data['ratingRFCritics']
          rf_critics = local_data['ratingRFCriticsVoteCount'].nil? ? nil : local_data['ratingRFCriticsVoteCount'].to_s.delete(' ').to_i
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
      else
        nil
      end
    end

    def imdb
      if @json.present?
        local_data = @json['ratingData']

        if !local_data.nil?
          rating = local_data['ratingIMDb'].nil? ? 0.0 : local_data['ratingIMDb']
          quantity = local_data['ratingIMDbVoteCount'].nil? ? 0 : local_data['ratingIMDbVoteCount'].to_s.delete(' ').to_i
        else
          rating = 0.0
          quantity = 0
        end

        {
            id: @json['imdbID'],
            rating: rating,
            quantity: quantity
        }
      else
        nil
      end
    end

    def number_of_reviews
      @json['reviewsCount'].present? ? @json['year'] : nil
    end

    def duration
      @json['filmLength'].present? ? @json['filmLength'] : 0
    end

    def countries
      if @json.present?
        @json['country'].present? ? @json['country'].split(',').map { |country| country.strip } : nil
      else
        nil
      end
    end

    def genres
      if @json.present?
        @json['genre'].present? ?  @json['genre'].split(',').map { |genre| genre.strip } : nil
      else
        nil
      end
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

    def all_names
      correctly = {}
      unless creators.nil?
        creators.each do |items|
          new_items = []
          items.each do |item|
            poster = item['posterURL'].present? ? "#{DOMAINS[:kinopoisk][:poster][:name]}_#{item['id']}.jpg" : nil
            new_item = {
                id: item['id'],
                url: "#{DOMAINS[:kinopoisk][:main]}/name/#{item['id']}",
                full_name: {
                    ru: item['nameRU'].present? ? item['nameRU'] : nil,
                    en: item['nameEN'].present? ? item['nameEN'] : nil
                },
                description: item['description'].present? ? item['description'] : nil,
                poster: poster,
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

    def premiere
      local_data = @json['rentData']

      if !local_data.nil?
        ru = local_data['premiereRU'].nil? ? nil : Date.parse(local_data['premiereRU'])
        world = local_data['premiereWorld'].nil? ? nil : Date.parse(local_data['premiereWorld'])
        world_country = local_data['premiereWorldCountry'].nil? ? nil : local_data['premiereWorldCountry']
      else
        ru = nil
        world = nil
        world_country = nil
      end

      {
          ru: ru,
          world: world,
          world_country: world_country
      }
    end

    private

      def creators
        if @json.present?
          @json['creators'].present? ? @json['creators'] : nil
        else
          nil
        end
      end

  end
end
