Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "stocks#index"
  # Routes for the Downvote resource:

  # CREATE
  get("/downvotes/new", { :controller => "downvotes", :action => "new_form" })
  post("/create_downvote", { :controller => "downvotes", :action => "create_row" })

  # READ
  get("/downvotes", { :controller => "downvotes", :action => "index" })
  get("/downvotes/:id_to_display", { :controller => "downvotes", :action => "show" })

  # UPDATE
  get("/downvotes/:prefill_with_id/edit", { :controller => "downvotes", :action => "edit_form" })
  post("/update_downvote/:id_to_modify", { :controller => "downvotes", :action => "update_row" })

  # DELETE
  get("/delete_downvote/:id_to_remove", { :controller => "downvotes", :action => "destroy_row" })

  #------------------------------

  # Routes for the Comment resource:

  # CREATE
  get("/comments/new", { :controller => "comments", :action => "new_form" })
  post("/create_comment", { :controller => "comments", :action => "create_row" })
  post("/create_comment_from_stock", { :controller => "comments", :action => "create_row_from_stock" })

  # READ
  get("/comments", { :controller => "comments", :action => "index" })
  get("/comments/:id_to_display", { :controller => "comments", :action => "show" })

  # UPDATE
  get("/comments/:prefill_with_id/edit", { :controller => "comments", :action => "edit_form" })
  post("/update_comment/:id_to_modify", { :controller => "comments", :action => "update_row" })

  # DELETE
  get("/delete_comment/:id_to_remove", { :controller => "comments", :action => "destroy_row" })
  get("/delete_comment_from_photo/:id_to_remove", { :controller => "comments", :action => "destroy_row_from_photo" })
  get("/delete_comment_from_commenter/:id_to_remove", { :controller => "comments", :action => "destroy_row_from_commenter" })

  #------------------------------

  # Routes for the Follow request resource:

  # CREATE
  get("/follow_requests/new", { :controller => "follow_requests", :action => "new_form" })
  post("/create_follow_request", { :controller => "follow_requests", :action => "create_row" })

  # READ
  get("/follow_requests", { :controller => "follow_requests", :action => "index" })
  get("/follow_requests/:id_to_display", { :controller => "follow_requests", :action => "show" })

  # UPDATE
  get("/follow_requests/:prefill_with_id/edit", { :controller => "follow_requests", :action => "edit_form" })
  post("/update_follow_request/:id_to_modify", { :controller => "follow_requests", :action => "update_row" })

  # DELETE
  get("/delete_follow_request/:id_to_remove", { :controller => "follow_requests", :action => "destroy_row" })
  get("/delete_follow_request_from_recipient/:id_to_remove", { :controller => "follow_requests", :action => "destroy_row_from_recipient" })
  get("/delete_follow_request_from_sender/:id_to_remove", { :controller => "follow_requests", :action => "destroy_row_from_sender" })

  #------------------------------

  # Routes for the Upvote resource:

  # CREATE
  get("/upvotes/new", { :controller => "upvotes", :action => "new_form" })
  post("/create_upvote", { :controller => "upvotes", :action => "create_row" })
  post("/create_upvote_from_stock", { :controller => "upvotes", :action => "create_row_from_stock" })

  # READ
  get("/upvotes", { :controller => "upvotes", :action => "index" })
  get("/upvotes/:id_to_display", { :controller => "upvotes", :action => "show" })

  # UPDATE
  get("/upvotes/:prefill_with_id/edit", { :controller => "upvotes", :action => "edit_form" })
  post("/update_upvote/:id_to_modify", { :controller => "upvotes", :action => "update_row" })

  # DELETE
  get("/delete_upvote/:id_to_remove", { :controller => "upvotes", :action => "destroy_row" })
  get("/delete_upvote_from_photo/:id_to_remove", { :controller => "upvotes", :action => "destroy_row_from_photo" })
  get("/delete_upvote_from_user/:id_to_remove", { :controller => "upvotes", :action => "destroy_row_from_user" })

  #------------------------------

  # Routes for the Stock resource:

  # CREATE
  get("/stocks/new", { :controller => "stocks", :action => "new_form" })
  post("/create_stock", { :controller => "stocks", :action => "create_row" })

  # READ
  get("/stocks", { :controller => "stocks", :action => "index" })
  get("/stocks/:id_to_display", { :controller => "stocks", :action => "show" })

  # UPDATE
  get("/stocks/:prefill_with_id/edit", { :controller => "stocks", :action => "edit_form" })
  post("/update_stock/:id_to_modify", { :controller => "stocks", :action => "update_row" })

  # DELETE
  get("/delete_stock/:id_to_remove", { :controller => "stocks", :action => "destroy_row" })
  get("/delete_stock_from_owner/:id_to_remove", { :controller => "stocks", :action => "destroy_row_from_owner" })

  #------------------------------

  devise_for :users
  # Routes for the User resource:

  # READ
  get("/users", { :controller => "users", :action => "index" })
  get("/users/:id_to_display", { :controller => "users", :action => "show" })

  #------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
