class StocksController < ApplicationController
  before_action :current_user_must_be_stock_owner, :only => [:edit_form, :update_row, :destroy_row]

  def current_user_must_be_stock_owner
    stock = Stock.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == stock.owner
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Stock.ransack(params[:q])
    @stocks = @q.result(:distinct => true).includes(:owner, :likes, :comments, :fan_followers, :followers, :fans).page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@stocks.where.not(:location_latitude => nil)) do |stock, marker|
      marker.lat stock.location_latitude
      marker.lng stock.location_longitude
      marker.infowindow "<h5><a href='/stocks/#{stock.id}'>#{stock.caption}</a></h5><small>#{stock.location_formatted_address}</small>"
    end

    render("stock_templates/index.html.erb")
  end

  def show
    @comment = Comment.new
    @upvote = Upvote.new
    @stock = Stock.find(params.fetch("id_to_display"))

    render("stock_templates/show.html.erb")
  end

  def new_form
    @stock = Stock.new

    render("stock_templates/new_form.html.erb")
  end

  def create_row
    @stock = Stock.new

    @stock.caption = params.fetch("caption")
    @stock.image = params.fetch("image") if params.key?("image")
    @stock.owner_id = params.fetch("owner_id")
    @stock.location = params.fetch("location")

    if @stock.valid?
      @stock.save

      redirect_back(:fallback_location => "/stocks", :notice => "Stock created successfully.")
    else
      render("stock_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @stock = Stock.find(params.fetch("prefill_with_id"))

    render("stock_templates/edit_form.html.erb")
  end

  def update_row
    @stock = Stock.find(params.fetch("id_to_modify"))

    @stock.caption = params.fetch("caption")
    @stock.image = params.fetch("image") if params.key?("image")
    
    @stock.location = params.fetch("location")

    if @stock.valid?
      @stock.save

      redirect_to("/stocks/#{@stock.id}", :notice => "Stock updated successfully.")
    else
      render("stock_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_owner
    @stock = Stock.find(params.fetch("id_to_remove"))

    @stock.destroy

    redirect_to("/users/#{@stock.owner_id}", notice: "Stock deleted successfully.")
  end

  def destroy_row
    @stock = Stock.find(params.fetch("id_to_remove"))

    @stock.destroy

    redirect_to("/stocks", :notice => "Stock deleted successfully.")
  end
end
