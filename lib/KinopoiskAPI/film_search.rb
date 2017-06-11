module KinopoiskAPI
  class FilmSearch < Agent
    attr_accessor :keyword, :url

    def initialize(keyword)
      @keyword = URI.encode(keyword)
      @page = 1
      gen_url
      @json = json
      @page_count = @json['pagesCount']
    end

    def films_count
      @json['searchFilmsCountResult']
    end

    def page_count
      @page_count
    end

    def current_page
      @current_page
    end

    def view
      @json['searchFilms'].map do |film|
        film_hash(film)
      end
    end

    def next_page
      if @page < @page_count
        @page += 1
        gen_url
        @json = json
        true
      else
        false
      end
    end

    private

      def gen_url
        @url = [
          "#{DOMAINS[:api]}/#{METHODS[:search_film][:method]}",
          "?#{METHODS[:search_film][:keyword]}=#{@keyword}",
          "&#{METHODS[:search_film][:page]}=#{@page}"
        ].join('')
      end

  end
end
