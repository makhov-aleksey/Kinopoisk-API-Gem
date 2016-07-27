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

    private

    def json
      uri = URI(@url)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end

    def gallery
      @json['gallery']
    end

  end
end