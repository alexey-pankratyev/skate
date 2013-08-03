<<<<<<< HEAD
 #include ApplicationHelper
def full_title(page_title)
  base_title = "Mynda"
  if page_title.empty?
    base_title
=======
def full_title(page_title)
 base_title = "Mynda"
  if page_title.empty?
   base_title
>>>>>>> f611b4b9cbb517a41e7ed99b5b356c63e51389c0
  else
    "#{base_title}|#{page_title}"
  end
end
<<<<<<< HEAD
=======
# include ApplicationHelper
>>>>>>> f611b4b9cbb517a41e7ed99b5b356c63e51389c0
