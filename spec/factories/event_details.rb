FactoryBot.define do
  factory :event_detail do
    
    association :group
    url { "https://blueshipjapan.com/event/5781" }
    event_title { "【ポケごみ】親子deゴミ拾い散歩" }
    event_date { "2020.11.10(火)" }
    event_deadline { "不要" }
    group_id { 1 }
  end
end
