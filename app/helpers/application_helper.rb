module ApplicationHelper

  # https://gist.github.com/mynameispj/5692162
  def nav_link_class(test_path)

    return 'nav-item active' if request.path == test_path

    'nav-item'
  end

end
