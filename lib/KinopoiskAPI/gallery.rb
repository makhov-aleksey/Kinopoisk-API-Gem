module KinopoiskAPI
  class Gallery
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_gallery][:method]}?#{METHODS[:get_gallery][:id]}=#{id}"
      @json = json
    end

    def all
      correctly = {}
      gallery.each do |items|
        new_items = []
        items.last.each do |item|
          new_item = {
              image: "#{DOMAINS[:kinopoisk][:poster][:gallery]}/#{item['image']}",
              preview: "#{DOMAINS[:kinopoisk][:poster][:gallery]}/#{item['preview']}"
          }
          new_items.push(new_item)
        end
        correctly[items.first] = new_items
      end
      correctly
    end

    def section(name)
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

    def gallery
      @json['gallery']
    end

  end
end