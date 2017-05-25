module KinopoiskAPI
  class Agent

    def status
      @json['resultCode'].nil? ? true : false
    end

    def raw
      @json
    end

    ####
    ####
    ####

    private

      def json
        uri       = URI(@url)
        uuid      = Digest::MD5.hexdigest("--#{rand(10000)}--#{Time.now}--")
        query     = URI.decode_www_form(String(uri.query)) << ["uuid", uuid]
        uri.query = URI.encode_www_form(query)

        path = uri.to_s.gsub("#{DOMAINS[:api]}/","") + DOMAINS[:salt]
        key  = Digest::MD5.hexdigest(path)

        query     = URI.decode_www_form(String(uri.query)) << ["key", key]
        uri.query = URI.encode_www_form(query)

        puts "[GET] -> " + uri.to_s

        http         = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response     = http.get(uri.request_uri, DOMAINS[:headers])

        if KinopoiskAPI::valid_json?(response.body)
          json = JSON.parse(response.body)
          if json['resultCode'] == 0
            json['data']
          else
            json
          end
        else
          {'resultCode'=> -1, "message"=> "Error method require", :data => { 'code'=> response.code, 'body'=> response.body} }
        end
      end


      def s2a(str)
        if str.nil?
          []
        else
          str.split(',').map { |i| i.strip }
        end
      end

  end
end
