require 'mechanize'
require_relative 'scrape_save_blueship'
class BlueshipUrls 
  def self.blueship_urls
    links = []
    6235.upto(6240) do |pagenum|
      links << ("https://blueshipjapan.com/event/#{pagenum}")
    end  
    ScrapeSaveBlueship.acquire_links(links)
  end
end
