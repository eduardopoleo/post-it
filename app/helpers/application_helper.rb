module ApplicationHelper

  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_date(obj)
    obj.created_at.strftime("%b %d, %Y")
  end

end
