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
          minimal_age: minimal_age
      }
    end

    def url
      @json['webURL']
    end

    def title
      {
          ru: @json['nameRU'],
          en: @json['nameEN']
      }
    end

    def slogan
      @json['slogan']
    end

    def description
      @json['description']
    end

    def poster
      "#{DOMAINS[:kinopoisk][:poster][:film]}_#{@id}.jpg"
    end

    def year
      @json['year']
    end

    def kinopoisk
      rating = @json['ratingData']['rating'].nil? ? nil : @json['ratingData']['rating']
      quantity = @json['ratingData']['ratingVoteCount'].nil? ? nil : @json['ratingData']['ratingVoteCount'].to_s.delete(' ').to_i

      good_reviews_in_percentage = @json['ratingData']['ratingGoodReview'].nil? ? nil : @json['ratingData']['ratingGoodReview']
      number_of_good_reviews = @json['ratingData']['ratingGoodReviewVoteCount'].nil? ? nil : @json['ratingData']['ratingGoodReviewVoteCount'].to_s.delete(' ').to_i

      waiting_in_percentage = @json['ratingData']['ratingAwait'].nil? ? nil : @json['ratingData']['ratingAwait']
      number_of_waiting = @json['ratingData']['ratingAwaitCount'].nil? ? nil : @json['ratingData']['ratingAwaitCount'].to_s.delete(' ').to_i

      {
          rating: rating,
          quantity: quantity,

          good_reviews_in_percentage: good_reviews_in_percentage,
          number_of_good_reviews: number_of_good_reviews,

          waiting_in_percentage: waiting_in_percentage,
          number_of_waiting: number_of_waiting
      }
    end

    def imdb
      rating = @json['ratingData']['ratingIMDb'].nil? ? nil : @json['ratingData']['ratingIMDb']
      quantity = @json['ratingData']['ratingIMDbVoteCount'].nil? ? nil : @json['ratingData']['ratingIMDbVoteCount'].to_s.delete(' ').to_i

      {
          id: @json['imdbID'],
          rating: rating,
          quantity: quantity
      }
    end

    def number_of_reviews
      @json['reviewsCount']
    end

    def duration
      @json['filmLength']
    end

    def countries
      @json['country'].split(',').map { |country| country.strip }
    end

    def genres
      @json['genre'].split(',').map { |genre| genre.strip }
    end

    def video
      @json['videoURL']
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
      @json['ratingMPAA']
    end

    def minimal_age
      @json['ratingAgeLimits']
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

  end
end