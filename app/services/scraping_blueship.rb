require 'mechanize'
class ScrapingBlueship < ApplicationRecord

    def self.blueship_urls
      links = []
      5010.upto(5020) do |pagenum|
        links << ("https://blueshipjapan.com/event/#{pagenum}")
      end  
      acquire_links(links)
    end
    #配列linksから要素を取り出し、self.add_urlsメソッドに送る
    def self.acquire_links(links)
      links.each do |url|
        scrape(url)
        sleep 1
      end
    end 
     
    def self.scrape(url)
      agent = Mechanize.new
      page  = agent.get(url)
      name        = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr/td/a/span').inner_text 
      title       = page.search('//*[@id="main_content"]/h1').inner_text 
      date        = page.search('//*[@id="main_content"]/div[2]/div[1]/div[1]/div[1]/p[2]').inner_text 
      application = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr[4]/td').inner_text
      save_elements(url, name, title, date, application)
    end
    
    #groupモデルに団体名、detailモデルに詳細情報を保存する
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
