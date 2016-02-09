class AddNamesToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, :default => ""
    add_column :users, :profile_image, :string, :default => ""
  end
end
