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

    def correctly
      correctly = {}
      creators.each do |items|
        items.each do |item|
          correctly[item['professionKey']] = items
        end
      end
      correctly
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

    def creators
      @json['creators']
    end

  end
end