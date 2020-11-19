require 'nokogiri'
require 'open-uri'
require 'mechanize'
require_relative 'scrape_event_title'

class BlueshipUrls 
  def self.blueship_url
    base_url = 'https://blueshipjapan.com/search/event'
    base_dir = '/catalog?per_page='
    
    page = Nokogiri::HTML(open(base_url+base_dir + '0'))
    last_page_number = page.css("#search_result > div > div > div > a:nth-child(5)")[0]['href'].match(/page=(\d+)/)[1].to_i
    catalog_url(last_page_number)
  end  
  
  def self.catalog_url(last_page_number)
    link = []
    for pg_number in 0..last_page_number do
      link << "https://blueshipjapan.com/search/event/catalog?per_page=#{pg_number/18*18}"
    end
    links = link.uniq
    ScrapeEventTitle.each_catalog_url(links)
  end
end
