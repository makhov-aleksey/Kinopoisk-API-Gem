module KinopoiskAPI
  class Agent

    def status
      @json[:resultCode].nil? ? true : false
    end

    def data
      @json
    end

    def data2
      @json2
    end

    ####
    ####
    ####

    private

      def json(url=nil)
        if url.nil?
          uri       = URI(@url)
        else
          uri       = URI(url)
        end

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
          j = JSON.parse(response.body)
          if j['resultCode'] == 0
            j['data']
          else
            j
          end
        else
          {:resultCode => -1, :message=> "Error method require", :data => { :code => response.code, :body => response.body} }
        end
      end

      def json2
        if @json2.nil?
          @json2 = json(@url2)
        end
      end


      def s2a(str)
        if str.nil?
          []
        else
          str.split(',').map { |i| i.strip }
        end
      end

      def int_data(data, name, none=0, type=Integer)
        s = dn(data, name)

        if s.nil?
          none
        else
          r = s
          if r.class == String
            r = s.gsub(/[\ \%\$]/i, '')
          end

          if type == Integer
            r.to_i == 0 ? none : r.to_i
          elsif type == Float
            r.to_f == 0 ? none : r.to_f
          else
            r
          end
        end
      end

      def time_data(data, name)
        s = dn(data, name)
        if !s.nil?
          if s.size == 10
            Date.parse(s)
          else
            year = s.scan(/\d{4}/)[0]
            if !year.nil?
              Date.parse("01.01.#{year}") #only year???
            end
          end
        end
      end

      def arr_data(data, name)
        s = dn(data, name)
        if s.nil?
          []
        else
          s.split(',').map { |genre| genre.strip }
        end
      end

      def str_data(data, name)
        s = dn(data, name)

        if s.class == String
          s
        elsif s.class == NilClass
          nil
        else
          s.to_s
        end
      end

      def bool_data(data, name)
        s = dn(data, name)

        if s.class == String
          s = s.to_i
        end

        if s.class == TrueClass || s.class == FalseClass
          s
        else
          s.present? && s == 1 ? true : false
        end
      end

      def min_data(data, name)
        s = dn(data, name)
        s.present? ? Time.parse(s).seconds_since_midnight.to_i / 60 : 0
      end

      def url_data(data, name, id, poster_name)
        s = dn(data, name)
        s.nil? ? nil : "#{DOMAINS[:kinopoisk][:poster][poster_name]}_#{id}.jpg"
      end





      def dn(data, name)
        if data.nil?
          r = @json[name]
        elsif data == String
          r = name
        else
          if @json[data].nil?
            r = nil
          else
            r = @json[data][name]
          end
        end
        r
      end




  end
end
