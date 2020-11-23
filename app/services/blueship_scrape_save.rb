require 'nokogiri'
require 'open-uri'
require 'mechanize'

class BlueshipScrapeSave
  
  def scrape_blueship_last_page_catalog
    catalog_url(last_page_number)
  end 
  
  def blueship_scrape_title_url_event_detail(url)
    BlueshipScrapeTitleUrlEventDetail.new(url).scrape_event_title
  end
  
  def self.save_elements(url, name, title, date, application)
    save_elements(url, name, title, date, application)
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
      blueship_scrape_title_url_event_detail(url)
      sleep 1
    end
  end 
  
  def self.save_elements(url, name, title, date, application)
    group = Group.where(group_name: name).first_or_initialize
    group.save
    detail             = EventDetail.where(url: url).first_or_initialize
    detail.event_title       = title  
    detail.event_date        = date
    detail.event_deadline    = application
    detail.group_id          = group.id
    detail.save  
  end
  
end
