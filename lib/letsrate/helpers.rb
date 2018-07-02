<<<<<<< HEAD
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

=======
module Helpers
  def rating_for(rateable_obj, dimension=nil, options={})

    cached_average = rateable_obj.average dimension

    avg = cached_average ? cached_average.avg : 0

    star = options[:star] || 5

    disable_after_rate = options[:disable_after_rate] || true

    readonly = !(current_user && rateable_obj.can_rate?(current_user, dimension))

    content_tag :div, '', "data-dimension" => dimension, :class => "star", "data-rating" => avg,
                "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
                "data-disable-after-rate" => disable_after_rate,
                "data-readonly" => readonly,
                "data-star-count" => star
>>>>>>> upstream/master
  end

  def rating_for_user(rateable_obj, rating_user, dimension = nil, options = {})
    @object = rateable_obj
    @user = rating_user
	  @rating = Rate.find_by_rater_id_and_rateable_id_and_dimension(@user.id, @object.id, dimension)
	  stars = @rating ? @rating.stars : 0

    disable_after_rate = options[:disable_after_rate] || false

    readonly=false
    if disable_after_rate
      readonly = current_user.present? ? !rateable_obj.can_rate?(current_user.id, dimension) : true
    end

    content_tag :div, '', "data-dimension" => dimension, :class => "star", "data-rating" => stars,
                "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
                "data-disable-after-rate" => disable_after_rate,
                "data-readonly" => readonly,
                "data-star-count" => stars
  end

end

class ActionView::Base
  include Helpers
end
