module Onebox
  module Engine
    module Oembed
      include JSON

      def to_html
        case data["type"]
        when "video", "rich"
          data["html"]
        when "photo"
          data["web_page"] ||= data["url"]
          Onebox::View.new("photo", data).to_html
        end
      end

      private

      def data
        raw.clone
      end
    end
  end
end
