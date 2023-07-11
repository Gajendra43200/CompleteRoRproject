class RemoveUserIdFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_reference :reviews, :user
  end
end
