require 'nokogiri'
require 'rails_helper'
RSpec.describe BlueshipUrls do
  
  it "should be true" do
    base_url = 'https://blueshipjapan.com/search/event'
    base_dir = '/catalog?per_page='
    page = Nokogiri::HTML(open(base_url+base_dir + '0'))    
    last_page_number = page.css("#search_result > div > div > div > a:nth-child(5)")[0]['href']
    expect(last_page_number).to match(/page=(\d+)/)
  end

end