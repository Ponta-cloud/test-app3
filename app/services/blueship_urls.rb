require 'nokogiri'
require 'open-uri'
require 'mechanize'

class BlueshipUrls 
  attr_reader :ai
  def initialize(ai)
    @ai = ai
  end  
       
  def scrape_event_detail
    agent = Mechanize.new
    page  = agent.get(ai)
    name        = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr/td/a/span').inner_text 
    title       = page.search('//*[@id="main_content"]/h1').inner_text 
    date        = page.search('//*[@id="main_content"]/div[2]/div[1]/div[1]/div[1]/p[2]').inner_text 
    application = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr[4]/td').inner_text
    save_elements(ai, name, title, date, application)
  end
  
  #groupモデルに団体名、detailモデルに詳細情報を保存する
  def save_elements(ai, name, title, date, application)
    group = Group.where(group_name: name).first_or_initialize
    group.save
    detail             = EventDetail.where(url: ai).first_or_initialize
    detail.event_title       = title  
    detail.event_date        = date
    detail.event_deadline    = application
    detail.group_id          = group.id
    detail.save
  end
end
