require 'spec_helper'

describe Onebox::Engine::WhitelistedOembedOnebox do
  shared_examples_for "iframe embed" do
    it{ should_not be_empty }
    specify{ Nokogiri::XML(subject).children.first.name.should eq("iframe") }
  end

  shared_context "preview html" do
    subject{ Onebox.preview(link).to_s }
  end

  context 'vimeo' do
    let(:video_id){ 7100569 }
    let(:link){ "http://vimeo.com/#{video_id}" }

    before do
      fake("http://vimeo.com/api/oembed.json?url=#{CGI.escape(link)}", response("oembed/vimeo"))
    end

    specify{ Onebox.has_matcher?(link).should be_true }

    context "#to_s" do
      include_context "preview html"
      it{ should include("//player.vimeo.com/video/#{video_id}") }
      it_behaves_like "iframe embed"
    end
  end

  context "youtube" do
    let(:link){ "https://www.youtube.com/watch?v=#{video_id}" }
    let(:video_id){ "21Lk4YiASMo" }
    before do
      fake("https://www.youtube.com/oembed?format=json&url=#{CGI.escape(link)}", response("oembed/youtube"))
    end

    specify{ Onebox.has_matcher?(link).should be_true }

    context "#to_s" do
      include_context "preview html"
      it{ should include("http://www.youtube.com/embed/#{video_id}?feature=oembed")}
      it_behaves_like "iframe embed"
    end
  end

  context "soundcloud" do
    let(:link){ "https://soundcloud.com/shapeshifterlivenz/shapeshifter-monarch-total" }
    before do
      fake("https://soundcloud.com/oembed?format=json&url=#{CGI.escape(link)}", response("oembed/soundcloud"))
    end
    specify{ Onebox.has_matcher?(link).should be_true }

    context "#to_s" do
      include_context "preview html"
      it_behaves_like "iframe embed"
    end
  end

  context "flickr" do
    let(:link){ "http://www.flickr.com/photos/bees/2362225867/" }
    before do
      fake("http://www.flickr.com/services/oembed?format=json&url=#{CGI.escape(link)}", response("oembed/flickr"))
    end
    specify{ Onebox.has_matcher?(link).should be_true }
    context "#to_s" do
      include_context "preview html"
      it{ should_not be_empty }
      it{ should include("http:\/\/farm4.staticflickr.com\/3040\/2362225867_4a87ab8baf_b.jpg")}
    end
  end
end
