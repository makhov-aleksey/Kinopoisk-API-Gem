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

    def url
      @json['webURL']
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

    def kinopoisk
      {
          rating: @json['ratingData']['rating'],
          quantity: @json['ratingData']['ratingVoteCount'].delete(' '),

          good_reviews_in_percentage: @json['ratingData']['ratingGoodReview'],
          number_of_good_reviews: @json['ratingData']['ratingGoodReviewVoteCount'],

          waiting_in_percentage: @json['ratingData']['ratingAwait'],
          number_of_waiting: @json['ratingData']['ratingAwaitCount'].delete(' '),
      }
    end

    def imdb
      {
          rating: @json['ratingData']['ratingIMDb'],
          quantity: @json['ratingData']['ratingIMDbVoteCount'].delete(' ')
      }
    end

    def number_of_reviews
      @json['reviewsCount']
    end

    def duration
      @json['filmLength']
    end

    def countries
      @json['country']
    end

    def genres
      @json['genre']
    end

    def video
      @json['videoURL']
    end

    def minimal_age
      @json['ratingAgeLimits']
    end

  end
end