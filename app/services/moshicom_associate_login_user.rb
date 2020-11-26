require 'nokogiri'
require 'open-uri'
require 'mechanize'
class MoshicomAssociateLoginUser 
  
  def run
    url = moshicom_url
    url.each do |url|
      scrape_save_event_detail(url)
      sleep 1
    end
  end
  
  def scrape_save_event_detail(url)
    scrape_event_detail(url)
    name = @name
    associate_service_user_save(name)  
  end
  
  private
  
  def moshicom_url
    links = (41000..47600).to_a.freeze
    links.map do |i|
    "https://moshicom.com/#{i}"
    end  
  end 
  
  def scrape_event_detail(url)
    agent = Mechanize.new
    page  = agent.get(url)
    @name  = page.search('//*[@id="main"]/div[4]/div[1]/section/div[1]/div/div[2]/h2/a').inner_text     
  end
  
  def associate_service_user_save(name)
    user = ServiceUser.find_by(name: name)
    if user then
      group_name = Group.find_by(group_name: name)
      ServiceUser.where(name: name).find_each do |service_user|
      service_user.group_id = group_name.id
      service_user.save
      end
    end
  end

end 