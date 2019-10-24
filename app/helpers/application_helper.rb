module ApplicationHelper

  # https://gist.github.com/mynameispj/5692162
  def nav_link_class(test_path)
    if url_for(request.path) == url_for(test_path) || (test_path == cars_path && request.path == '/')
      'nav-item active'
    else
      'nav-item'
    end
  end

end
