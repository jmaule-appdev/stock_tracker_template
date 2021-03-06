class UpvotesController < ApplicationController
  before_action :current_user_must_be_upvote_user, :only => [:show, :edit_form, :update_row, :destroy_row]

  def current_user_must_be_upvote_user
    upvote = Upvote.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == upvote.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.likes.ransack(params[:q])
    @upvotes = @q.result(:distinct => true).includes(:user, :photo).page(params[:page]).per(10)

    render("upvote_templates/index.html.erb")
  end

  def show
    @upvote = Upvote.find(params.fetch("id_to_display"))

    render("upvote_templates/show.html.erb")
  end

  def new_form
    @upvote = Upvote.new

    render("upvote_templates/new_form.html.erb")
  end

  def create_row
    @upvote = Upvote.new

    @upvote.user_id = params.fetch("user_id")
    @upvote.stock_id = params.fetch("stock_id")

    if @upvote.valid?
      @upvote.save

      redirect_back(:fallback_location => "/upvotes", :notice => "Upvote created successfully.")
    else
      render("upvote_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_stock
    @upvote = Upvote.new

    @upvote.user_id = params.fetch("user_id")
    @upvote.stock_id = params.fetch("stock_id")

    if @upvote.valid?
      @upvote.save

      redirect_to("/stocks/#{@upvote.stock_id}", notice: "Upvote created successfully.")
    else
      render("upvote_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @upvote = Upvote.find(params.fetch("prefill_with_id"))

    render("upvote_templates/edit_form.html.erb")
  end

  def update_row
    @upvote = Upvote.find(params.fetch("id_to_modify"))

    
    @upvote.stock_id = params.fetch("stock_id")

    if @upvote.valid?
      @upvote.save

      redirect_to("/upvotes/#{@upvote.id}", :notice => "Upvote updated successfully.")
    else
      render("upvote_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_user
    @upvote = Upvote.find(params.fetch("id_to_remove"))

    @upvote.destroy

    redirect_to("/users/#{@upvote.user_id}", notice: "Upvote deleted successfully.")
  end

  def destroy_row_from_photo
    @upvote = Upvote.find(params.fetch("id_to_remove"))

    @upvote.destroy

    redirect_to("/stocks/#{@upvote.stock_id}", notice: "Upvote deleted successfully.")
  end

  def destroy_row
    @upvote = Upvote.find(params.fetch("id_to_remove"))

    @upvote.destroy

    redirect_to("/upvotes", :notice => "Upvote deleted successfully.")
  end
end
