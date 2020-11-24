require 'nokogiri'
require 'open-uri'
require 'mechanize'
class BlueshipScrapeSave < Scraping
  
  def run
    catalog_url(last_page_catalog_url)
  end 
  
  def scrape_event_titles(urls)
    scrape_event_title(urls)
  end 
       
  def scrape_save_event_detail(url)
    scrape_event_detail(url)
  end
  
  
  private
  
  def last_page_catalog_url
    base_url = 'https://blueshipjapan.com/search/event'
    base_dir = '/catalog?per_page='
    
    page = Nokogiri::HTML(open(base_url+base_dir + '0'))
    page.css("#search_result > div > div > div > a:nth-child(5)")[0]['href'].match(/page=(\d+)/)[1].to_i
  end  
  
  def catalog_url(last_pg_number)
    link = []
    for pg_number in 0..last_pg_number do
      link << "https://blueshipjapan.com/search/event/catalog?per_page=#{pg_number/18*18}"
    end
    links = link.uniq
    catalog_url_each(links)
  end

#以下のscrape_event_titles(urls)でpublicに戻る  
  def catalog_url_each(links)
    links.each do |urls|
      scrape_event_titles(urls)
      sleep 1
    end
  end 
  
  def scrape_event_title(urls)
    link  = []
    agent = Mechanize.new
    page  = agent.get(urls)
    elements = page.search('#search_result > div > div > ul > li > article > div.event_info > h2 > a')
    elements.each do |ele|
    link << ele.get_attribute('href')
    end  
    each_event_title(link)
  end  
  
#以下のscrape_save_event_detail(url)でpublicに戻る    
  def each_event_title(link)
    link.each do |url|
      scrape_save_event_detail(url)
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
    save_elements(url, name, title, date, application)
  end
end
#Scrapingクラスを継承し、要素をモデルに保存