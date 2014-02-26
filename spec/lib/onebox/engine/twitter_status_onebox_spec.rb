require "spec_helper"

describe Onebox::Engine::TwitterStatusOnebox do
  let(:link){ "https://twitter.com/vyki_e/status/363116819147538433" }
  subject{ Onebox.preview(link) }
  before(:all){ fake("https://api.twitter.com/1/statuses/oembed.json?id=363116819147538433", response("twitter-json"))}

  its(:to_s){ should include("I&#39;m a sucker for pledges.") }
  # xit(:to_s){ should include(link) }
end
