module ApplicationHelper
  def fix_url(str)
    (str.starts_with?('http://') || str.starts_with?('https://')) ?
      str : 'http://' + str
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %a %l:%M %p %Z")
  end
end
