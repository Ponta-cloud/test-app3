require 'rails_helper'
RSpec.describe ScrapeSaveBlueship do
  
  it "should be true" do
    blueship = ScrapeSaveBlueship.each_event_title(["https://blueshipjapan.com/event/5781"])
    expect(blueship).to eq (["https://blueshipjapan.com/event/5781"])
  end
  
  it "is valid without date and application" do
    agent = Mechanize.new
    page  = agent.get("https://blueshipjapan.com/event/5781")
    event_title = page.search('//*[@id="main_content"]/h1').inner_text 
    expect(event_title).to eq("【ポケごみ】親子deゴミ拾い散歩")
  end
end