require 'mechanize'
class ScrapeSaveBlueship
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
    deadline = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr[4]/td').inner_text
    save_elements(url, name, title, date, deadline)
  end
  
  #groupモデルに団体名、detailモデルに詳細情報を保存する
  def self.save_elements(url, name, title, date, deadline)
    group = Group.where(group_name: name).first_or_initialize
    group.save
    detail                   = EventDetail.where(url: url).first_or_initialize
    detail.event_title       = title  
    detail.event_date        = date
    detail.event_deadline    = deadline
    detail.group_id          = group.id
    detail.save
  end
end      