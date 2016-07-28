module KinopoiskAPI
  class Reviews
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_reviews][:method]}?#{METHODS[:get_reviews][:id]}=#{id}"
      @json = json
    end

    def number_of_pages
      @json['pagesCount']
    end

    def current_page
      @json['page']
    end

    def number_of_reviews
      @json['reviewAllCount']
    end

    def number_of_good_reviews
      @json['reviewPositiveCount']
    end

    def number_of_good_reviews_in_percent
      @json['reviewAllPositiveRatio']
    end

    def number_of_bad_reviews
      @json['reviewNegativeCount']
    end

    def number_of_neutral_reviews
      @json['reviewNeutralCount']
    end

    def reviews
      correctly = []
      json_reviews.each do |item|
        new_item = {
            id: item['reviewID'],
            type: item['reviewType'],
            data: item['reviewData'],
            author: {
                name: item['reviewAutor'],
                avatar: "#{DOMAINS[:kinopoisk][:poster][:gallery]}/#{item['reviewAutorImageURL']}"
            },
            title: item['reviewTitle'],
            description: item['reviewDescription']
        }
        correctly.push(new_item)
      end
      correctly
    end

    private

    def json
      uri = URI(@url)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end

    def json_reviews
      @json['reviews']
    end

  end
end