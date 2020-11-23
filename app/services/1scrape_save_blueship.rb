require 'nokogiri'
require 'open-uri'
require 'mechanize'

class ScrapeSaveBlueship

  def blueship_url
    catalog_url(last_page_number)
  end  
  
  def scrape_event_title(url)
    ScrapeEventTitle.new(url).scrape_event_title
  end 
       
  def self.scrape_event_detail(ai)
    BlueshipUrls.new(ai).scrape_event_detail
  end
  
  private
  def last_page_number
    base_url = 'https://blueshipjapan.com/search/event'
    base_dir = '/catalog?per_page='
    
    page = Nokogiri::HTML(open(base_url+base_dir + '0'))
    page.css("#search_result > div > div > div > a:nth-child(5)")[0]['href'].match(/page=(\d+)/)[1].to_i
  end  
  
  def catalog_url(orders)
    link = []
    for pg_number in 0..orders do
      link << "https://blueshipjapan.com/search/event/catalog?per_page=#{pg_number/18*18}"
    end
    links = link.uniq
    links.each do |url|
      scrape_event_title(url)
      sleep 1
    end
  end 
  

end