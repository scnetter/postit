module ApplicationHelper
  def fix_url(str)
     /http:\/\/|^https:\/\//.match(str) ? str : "http://#{str}"
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %a %l:%M %p %Z")
  end
end
