module ApplicationHelper
   def logo
       image_tag("onegasity.jpg", :alt => "Myndozero", :class => "round") 
     end

  # Return a title on a per-page basis.
   def title
    base_title = "Mynda"
    if @title.nil?
      base_title
    else
      "#{base_title}|#{@title}"
    end
  end
end
