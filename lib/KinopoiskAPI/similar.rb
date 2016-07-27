module KinopoiskAPI
  class Similar
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_similar][:method]}?#{METHODS[:get_similar][:id]}=#{id}"
      @json = json
    end

    def all
      correctly = []
      json['items'].each do |items|
        items.each do |item|
          new_item = {
              title: item['nameRU'],
              original_title: item['nameEN'],
              year: item['year'],
              rating: item['rating'],
              poster: "#{DOMAINS[:kinopoisk][:poster][:gallery]}/#{item['posterURL']}",
              duration: item['filmLength'],
              countries: item['country'],
              genres: item['genre']
          }
          correctly.push(new_item)
        end
      end
      correctly
    end

    private

    def json
      uri = URI(@url)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end

    def items
      @json['items']
    end

  end
end