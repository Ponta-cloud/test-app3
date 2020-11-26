class ScrapingRun 
  def self.run
    BlueshipScrapeSave.new.run
    BlueshipAssociateLoginUser.new.run
    MoshicomScrapeSave.new.run
    MoshicomAssociateLoginUser.new.run
  end
end
