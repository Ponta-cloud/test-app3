class ScrapingCommonPart
  def save_elements(url, name, title, date, application)
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