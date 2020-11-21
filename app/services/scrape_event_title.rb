require 'mechanize'
require_relative 'scrape_save_blueship'

class ScrapeEventTitle 
  def self.each_catalog_url(links)
    links.each do |url|
      scrape_event_title(url)
      sleep 1
    end
  end 
  
  def self.scrape_event_title(url)
    link  = []
    agent = Mechanize.new
    page  = agent.get(url)
    elements = page.search('#search_result > div > div > ul > li > article > div.event_info > h2 > a')
    elements.each do |ele|
    link << ele.get_attribute('href')
    end  
    ScrapeSaveBlueship.each_event_title(link)
  end  
end
