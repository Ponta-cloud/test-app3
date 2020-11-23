require 'mechanize'
class BlueshipScrapeTitleUrlEventDetail
  
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
    link.each do |url|
      scrape_event_detail(url)
      sleep 1
    end
  end 
       
  def scrape_event_detail(url)
    agent = Mechanize.new
    page  = agent.get(url)
    name        = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr/td/a/span').inner_text 
    title       = page.search('//*[@id="main_content"]/h1').inner_text 
    date        = page.search('//*[@id="main_content"]/div[2]/div[1]/div[1]/div[1]/p[2]').inner_text 
    application = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr[4]/td').inner_text
    BlueshipScrapeSave.save_elements(url, name, title, date, application)
  end    
end