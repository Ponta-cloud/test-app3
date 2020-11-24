class BlueshipAssociateLoginUser < BlueshipScrapeSave
  
#BlueshipScrapeSaveを継承し、scrape_event_detail(url)メソッドを変更
  def scrape_event_detail(url)
    agent = Mechanize.new
    page  = agent.get(url)
    name        = page.search('//*[@id="main_content"]/div[2]/div[2]/table/tr/td/a/span').inner_text 
    associate_service_user_save(name)
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
