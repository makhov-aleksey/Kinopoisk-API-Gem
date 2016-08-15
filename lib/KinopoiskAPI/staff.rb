module KinopoiskAPI
  class Staff
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_name][:method]}?#{METHODS[:get_name][:id]}=#{id}"
      @json = json
    end

    def all
      correctly = {}
      unless creators.nil?
        creators.each do |items|
          new_items = []
          items.each do |item|
            new_item = {
                id: item['id'],
                url: "#{DOMAINS[:kinopoisk][:main]}/name/#{item['id']}",
                full_name: {
                    ru: item['nameRU'],
                    en: item['nameEN']
                },
                poster: "#{DOMAINS[:kinopoisk][:poster][:name]}_#{item['id']}.jpg",
                profession: item['professionText']
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

    def profession(name)
      all[name]
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

    def creators
      if @json.present?
        @json['creators'].present? ? @json['creators'] : nil
      else
        nil
      end
    end

  end
end