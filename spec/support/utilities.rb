def full_title(page_title)
 base_title = "Mynda"
  if page_title.empty?
   base_title
  else
    "#{base_title}|#{page_title}"
  end
end


 def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', content: message) 
  end
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
