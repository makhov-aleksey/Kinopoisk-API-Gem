require 'net/http'
require 'KinopoiskAPI/film'
require 'KinopoiskAPI/staff'
require 'KinopoiskAPI/version'

module KinopoiskAPI
  DOMAINS = {
      api: 'http://api.kinopoisk.cf',
      kinopoisk: {
          main: 'https://www.kinopoisk.ru',
          poster: {
              film: 'https://st.kp.yandex.net/images/film_iphone/iphone360',
              name: 'https://st.kp.yandex.net/images/actor_iphone/iphone360'
          }
      }
  }

  METHODS = {
      get_film: {
          method: 'getFilm',
          id: 'filmID',
          parameter: 'aaaaaa'
      },
      get_gallery: {
          method: 'getGallery',
          id: 'filmID',
          parameter: 'aaaaaa'
      },
      get_similar: {
          method: 'getSimilar',
          id: 'filmID',
          parameter: 'aaaaaa'
      },
      get_name: {
          method: 'getStaff',
          id: 'filmID',
          parameter: 'aaaaaa'
      },
      get_genres: {
          method: 'getGenres'
      },
      get_top_genre: {
          method: 'getTopGenre'
      },
      get_reviews: {
          method: 'getReviews',
          id: 'filmID',
          parameter: 'aaaaaa'
      },
      get_review_detail: {
          method: 'getReviewDetail',
          id: 'reviewID',
          parameter: 'aaaaaa'
      },
      get_people_detail: {
          method: 'getPeopleDetail'
      },
      get_today_films: {
          method: 'getTodayFilms'
      },
      get_cinemas: {
          method: 'getCinemas'
      },
      get_cinema_detail: {
          method: 'getCinemaDetail',
          id: 'cinemaID',
          parameter: 'aaaaaa'
      },
      get_seance: {
          method: 'getSeance',
          id: 'filmID',
          parameter: 'aaaaaa'
      },
      get_dates_for_detail_cinema: {
          method: 'getDatesForDetailCinema',
          id: 'filmID',
          parameter: 'aaaaaa'
      },
      get_soon_films: {
          method: 'getSoonFilms'
      },
      get_soon_dvd: {
          method: 'getSoonDVD'
      },
      get_dates_for_soon_films: {
          method: 'getDatesForSoonFilms'
      },
      get_dates_for_soon_dvd: {
          method: 'getDatesForSoonDVD'
      },
      get_top: {
          method: 'getTop'
      },
      get_best_films: {
          method: 'getBestFilms'
      },
      search_global: {
          method: 'searchGlobal',
          keyword: 'keyword'
      },
      search_films: {
          method: 'searchFilms',
          keyword: 'keyword'
      },
      search_people: {
          method: 'searchPeople',
          keyword: 'keyword'
      },
      search_cinemas: {
          method: 'searchCinemas',
          keyword: 'keyword'
      },
      news: {
          method: 'getNews'
      },
      get_news_detail: {
          method: 'getNewsDetail'
      }
  }

  def self.api_access(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request_head(uri.path)

    if response.code == '200'
      true
    else
      false
    end
  end

end
