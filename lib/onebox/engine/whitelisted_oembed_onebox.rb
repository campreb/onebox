module Onebox
  module Engine
    class WhitelistedOembedOnebox
      include Engine
      include Oembed

      def self.whitelist
        endpoints.keys.dup
      end

      def self.endpoints
        {
          "vimeo.com" => "http://vimeo.com/api/oembed.json?url={url}",
          "youtube.com" => "https://www.youtube.com/oembed?format=json&url={url}",
          "youtu.be" => "https://www.youtube.com/oembed?format=json&url={url}",
          "soundcloud.com" => "https://soundcloud.com/oembed?format=json&url={url}",
          "flickr.com" => "http://www.flickr.com/services/oembed?format=json&maxwidth=720&url={url}"
        }
      end

      def self.host_matches(uri, list)
        !!list.find {|h| %r((^|\.)#{Regexp.escape(h)}$).match(uri.host) }
      end

      def self.===(other)
        if other.kind_of?(URI)
          return WhitelistedOembedOnebox.host_matches(other, WhitelistedOembedOnebox.whitelist)
        else
          super
        end
      end

      def host
        uri = URI.parse(@url)
        WhitelistedOembedOnebox.whitelist.find {|h| %r((^|\.)#{Regexp.escape(h)}$).match(uri.host) }
      end

      def endpoint
        WhitelistedOembedOnebox.endpoints[host]
      end

      def url
        endpoint.dup.gsub("{url}", CGI.escape(@url))
      end
    end
  end
end
