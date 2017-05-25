module KinopoiskAPI
  class TodayFilms < Agent
    attr_accessor :url

    def initialize
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_today_films][:method]}"
      @json = json
    end

    def all
      films.map do |film|
        {
          id: film['id'],
          title: {
            :en => film['nameEN'],
            :ru => film['nameRU']
          },
          :premiere => {
            :ru => film['premiereRU']
          },
          poster: "#{DOMAINS[:kinopoisk][:poster][:film]}_#{film['id']}.jpg",
          year: film['year'],
          rating: film['rating'],
          rating_vote_count: film['ratingVoteCount'],
          duration: film['filmLength'],
          countries: s2a(film['country']),
          genres: s2a(film['genre']),
          video: film['videoURL'],
          is_imax: film['isIMAX'],
          is_3d: film['is3D']
        }
      end
    end

    private

      def films
        @json['filmsData']
      end

  end
end
