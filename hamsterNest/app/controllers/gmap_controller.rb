class GmapController < ApplicationController
  def index
    load_routers
  end
  
  
  def load_routers  
   @routers_default = Gmaps4rails.build_markers(Item.all) do |item, marker|  
      
    @item = item
    @user_profile = @item.user_profile

    marker.lat @user_profile.latitude  
    marker.lng @user_profile.longitude 

    @status = @item.status 

    if @status == true
      @status = "Available"  
    else  
      @status = "Currently unavailable"  
    end  

    marker.infowindow render_to_string(:partial => "/gmap/template", :locals => {:item => @item, :category => @category, :status => @status})  
  end  
 end
  
  
end
