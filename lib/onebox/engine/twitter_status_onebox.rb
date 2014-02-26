module Onebox
  module Engine
    class TwitterStatusOnebox
      include Engine
      include Oembed

      matches do
        http
        maybe("www.")
        domain("twitter")
        tld("com")
        anything
        has("/status/")
      end

      def url
        "https://api.twitter.com/1/statuses/oembed.json?id=#{match[:id]}"
      end

      private

      def match
        @match ||= @url.match(%r{twitter\.com/.+?/status/(?<id>\d+)})
      end
    end
  end
end
