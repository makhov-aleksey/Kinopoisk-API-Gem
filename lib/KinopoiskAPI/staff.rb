module KinopoiskAPI
  class Staff
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_name][:method]}?#{METHODS[:get_name][:id]}=#{id}"
      @json = json
    end

    # def get_json
    #   @json
    # end

    def all
      correctly = {}
      creators.each do |items|
        new_items = []
        items.each do |item|
          new_item = {
              id: item['id'],
              url: "#{DOMAINS[:kinopoisk][:main]}/name/#{item['id']}",
              full_name: item['nameRU'],
              original_full_name: item['nameEN'],
              poster: "#{DOMAINS[:kinopoisk][:poster][:name]}_#{item['id']}.jpg",
              profession: item['professionText']
          }
          new_items.push(new_item)
        end
        items.each do |item|
          correctly[item['professionKey']] = new_items
        end
      end
      correctly
    end

    def profession(name)
      all[name]
    end

    private

    def json
      uri = URI(@url)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end

    def creators
      @json['creators']
    end

  end
end