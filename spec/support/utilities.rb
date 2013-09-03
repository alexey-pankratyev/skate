def full_title(page_title)
 base_title = "Mynda"
  if page_title.empty?
   base_title
  else
    "#{base_title}|#{page_title}"
  end
end


 def sign_in(user)
    visit signin_path
    fill_in "Email",  with: user.email
    fill_in "Password", with: user.password
     click_button "Sign in"
#     # Sign in when not using Capybara as well
#     cookies[:remember_toke] = user.remember_token
end

class ActionView::TestCase::TestController
  def default_url_options(options={})
    { :locale => I18n.default_locale }
  end
end

class ActionDispatch::Routing::RouteSet
  def default_url_options(options={})
    { :locale => I18n.default_locale }
  end
end

# include ApplicationHelper
