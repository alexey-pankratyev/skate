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
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Вход без Capybara.
  # cookies[:remember_token] = user.remember_token
 end

def post_micropost(content)
  visit '/'
  fill_in :micropost_content, with: content
  click_button "Post"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', content: message) 
  end
end

RSpec::Matchers.define :have_content_h1_title do |message|
match do |page|
    page.should have_selector('h1', content: message) 
    page.should have_selector('title', content: message) 
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
