require 'rails_helper'

RSpec.describe EventDetail, type: :model do
    
  before do
    @event_detail = FactoryBot.create(:event_detail)
  end  
  
  it "is updated if event_title is changed" do
    @event_detail.event_title = "運動会" 
    expect(@event_detail.event_title).not_to eq '【ポケごみ】親子deゴミ拾い散歩'
  end
end
