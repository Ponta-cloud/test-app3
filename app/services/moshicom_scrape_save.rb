require 'mechanize'
class MoshicomScrapeSave < DefaltScraping 
  def run
    url = moshicom_url
    url.each do |url|
      scrape_save_event_detail(url)
      sleep 1
    end
  end
  
  def scrape_save_event_detail(url)
    scrape_event_detail(url)
    url, name, title, date, application = @url, @name, @title, @date, @application
    save_elements(url, name, title, date, application)
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
    @name        = page.search('//*[@id="main"]/div[4]/div[1]/section/div[1]/div/div[2]/h2/a').inner_text 
    @title       = page.search('//*[@id="main"]/div[3]/div[1]/div[1]/div/h1/span[1]').inner_text 
    @date        = page.search('//*[@id="main"]/div[4]/div[1]/section[1]/div/div[2]/ul/li[1]/dl/dd/div/div/span').inner_text 
    @application = page.search('//*[@id="main"]/div[4]/div[1]/section[1]/div/div[2]/ul/li[2]/dl/dd').inner_text 
    @url = url
  end
  #Scrapingクラスを継承し、要素をモデルに保存
end
  



