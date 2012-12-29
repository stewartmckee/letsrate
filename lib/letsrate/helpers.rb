module Helpers  
  def rating_for(rateable_obj, dimension=nil, options={})                             
  
    raise ArgumentError, "model object passed in for rating is nil" if rateable_obj.nil?

    if dimension.nil?
      klass = rateable_obj.average
    else             
      klass = rateable_obj.average "#{dimension}"    
    end
    
    if klass.nil?
      avg = 0
    else
      avg = klass.avg
    end
    
    star = options[:star] || 5
    options[:read_only] = false unless options.has_key?(:read_only)
    
    content_tag :div do 
      rating_contents = ""
      rating_contents += content_tag :div, "", "data-dimension" => dimension, :class => "star", "data-rating" => avg, 
                            "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
                            "data-star-count" => star, "data-read-only" => options[:read_only]
      rating_contents.html_safe
    end

  end
     
end

class ActionView::Base
  include Helpers
end