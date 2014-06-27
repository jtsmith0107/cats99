class ChangeUserIdToNotNull < ActiveRecord::Migration
  def change
    change_column :cat_rental_requests, :user_id, :integer, null: false
  end
end
