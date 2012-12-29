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
    else
      render :json => false        
    end
  end                                        
  
  
end