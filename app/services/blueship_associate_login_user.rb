require 'mechanize'
class BlueshipAssociateLoginUser 
  
  def self.blueship_urls
    link = []
    6369.upto(6370) do |pagenum|
      link << ("https://blueshipjapan.com/event/#{pagenum}")
    end  
    each_event_title(link)
  end
  
  def self.each_event_title(link)
    link.each do |url|
      scrape_event_detail(url)
      sleep 1
    end
  end 
       
  def self.scrape_event_detail(url)
    agent = Mechanize.new
    page  = agent.get(url)
    name  = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr/td/a/span').inner_text 
    user(name)
  end
  
  def self.user(name)
    auser = User.find_by(name: name)
    if auser then
      group = Group.find_by(group_name: name)
      User.where(name: name).find_each do |book|
        book.group_id = group.id
        book.save
      end
    end
  end  
end