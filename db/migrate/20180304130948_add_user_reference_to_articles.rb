class AddUserReferenceToArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :user, index: true
  end
end
