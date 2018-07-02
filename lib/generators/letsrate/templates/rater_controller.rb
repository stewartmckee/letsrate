<<<<<<< HEAD
class RaterController < ApplicationController 
  
  def create
                                  
    if current_user.present?
      obj = params[:klass].constantize.find(params[:id])
      ap obj
      obj = eval "#{params[:klass]}.find(#{params[:id]})"     
      ap obj
      if params[:dimension].present?
        obj.rate params[:score].to_i, current_user.id, "#{params[:dimension]}"       
      else
        obj.rate params[:score].to_i, current_user.id 
      end
      
      render :json => true 
=======
class RaterController < ApplicationController

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_i, current_user, params[:dimension]

      render :json => true
>>>>>>> upstream/master
    else
      render :json => false
    end
  end

end
