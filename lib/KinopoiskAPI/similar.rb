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
          rating_array = item['rating'].delete(' ').split('(')
          new_item = {
              title: {
                  ru: item['nameRU'],
                  en: item['nameEN']
              },
              year: item['year'],
              rating: rating_array.first,
              number_of_rated: rating_array.last.delete(')'),
              poster: "#{DOMAINS[:kinopoisk][:poster][:film]}_#{item['id']}.jpg",
              duration: item['filmLength'],
              countries: item['country'],
              genres: item['genre']
          }
          correctly.push(new_item)
        end
      end
      correctly
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

    def items
      @json['items']
    end

  end
end