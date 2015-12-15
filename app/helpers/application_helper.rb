module ApplicationHelper
  def fix_url(str)
     /http:\/\/|^https:\/\//.match(str) ? str : "http://#{str}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime("%m/%d/%Y %a %l:%M %p %Z")
  end
end
