module KinopoiskAPI
  class Staff
    attr_accessor :id, :url, :json

    def initialize(id)
      @id = id
      @url = "#{DOMAINS[:api]}/#{METHODS[:get_name][:method]}?#{METHODS[:get_name][:id]}=#{id}"
      @json = json
    end

    def get_json
      @json
    end

    def all
      {

      }
    end

    def creators
      @json['creators']
    end

    def test

      hash = {}

      @json['creators'].each do |creators|
        creators.each do |items|
          items.each do |item|
            item.id
            break
          end
        end
      end

    end

    # def url
    #   @json['webURL']
    # end

    private

    def json
      uri = URI(@url)
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end

  end
end