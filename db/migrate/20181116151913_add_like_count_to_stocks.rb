class AddLikeCountToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :likes_count, :integer
  end
end
