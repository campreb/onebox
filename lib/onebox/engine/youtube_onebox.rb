module Onebox
  module Engine
    class YoutubeOnebox
      include Engine
      include Oembed

      matches_regexp /^https?:\/\/(?:www\.)?(?:youtube\.com|youtu\.be)\/.+$/

      def url
        "https://www.youtube.com/oembed?url=#{CGI.escape(@url)}&format=json"
      end
    end
  end
end
