require 'mechanize'

class ScrapeEventTitle 
  attr_reader :url
  def initialize(url)
    @url = url
  end  
  
  def scrape_event_title
    link  = []
    agent = Mechanize.new
    page  = agent.get(url)
    elements = page.search('#search_result > div > div > ul > li > article > div.event_info > h2 > a')
    elements.each do |ele|
    link << ele.get_attribute('href')
    end  
    each_event_title(link)
  end  
  
  def each_event_title(link)
    link.each do |ai|
      sharaku(ai)
      sleep 1
    end
  end 
  
  def sharaku(ai)
    ScrapeSaveBlueship.scrape_event_detail(ai)
  end 
end
