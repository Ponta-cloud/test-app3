require 'mechanize'
class BlueshipAssociateLoginUser < ScrapeSaveBlueship 

  def self.save_blueship(url)
    agent = Mechanize.new
    page  = agent.get(url)
    name  = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr/td/a/span').inner_text 
    user(name)
  end
  
  def self.user(name)
    auser = ServiceUser.find_by(name: name)
    if auser then
      group = Group.find_by(group_name: name)
      ServiceUser.where(name: name).find_each do |book|
        book.group_id = group.id
        book.save
      end
    end
  end  

end