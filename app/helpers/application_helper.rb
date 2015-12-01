module ApplicationHelper
  def fix_url(str)
    (str.starts_with?('http://') || str.starts_with?('https://')) ?
      str : 'http://' + str
  end
end
