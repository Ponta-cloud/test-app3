require 'rails_helper'
RSpec.describe BlueshipScrapeSave do
  
  
  it "is valid scraping event_title" do
    agent = Mechanize.new
    page  = agent.get("https://blueshipjapan.com/event/5781")
    event_title = page.search('//*[@id="main_content"]/h1').inner_text 
    expect(event_title).to eq("【ポケごみ】親子deゴミ拾い散歩")
  end
  
  it "is valid scraping last_page_number" do
    base_url = 'https://blueshipjapan.com/search/event'
    base_dir = '/catalog?per_page='
    page = Nokogiri::HTML(open(base_url+base_dir + '0'))    
    last_page_number = page.css("#search_result > div > div > div > a:nth-child(5)")[0]['href']
    expect(last_page_number).to match(/page=(\d+)/)
  end
  
  let(:instance) { BlueshipScrapeSave.new }
  describe 'private method' do
    subject { instance.send(:each_event_title, (["https://blueshipjapan.com/event/5781"])) }
    it 'is valid private each_event_title' do
      expect(subject).to eq (["https://blueshipjapan.com/event/5781"])
      end
  end
end



