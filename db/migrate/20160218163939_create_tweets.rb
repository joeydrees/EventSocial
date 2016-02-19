class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|

      t.string 		:name
      t.string 		:username
      t.string		:text
      t.string		:id_str
      t.boolean 	:approved, :default => true
      
      t.timestamps null: false
    end
  end
end
