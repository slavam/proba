class CityTypesController < ApplicationController
  def index 
    @city_types = CityType.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @city_types }
    end
  end
  
  def new
    @city_type = CityType.new
  end
  
  def create
    @city_type = CityType.new(params[:city_type])
    @city_type.full_name
#    @city_type = CityType.create :params[:city_type]
    if not @city_type.save 
      render :new
    else
#      notice_created
      redirect_to :city_types
    end
  end
end
