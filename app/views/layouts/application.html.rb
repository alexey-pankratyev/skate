DOCTYPE html
html
  head
    title =@title  
    = csrf_meta_tag
    meta name="keywords" content="template language"
  body
    = yield
