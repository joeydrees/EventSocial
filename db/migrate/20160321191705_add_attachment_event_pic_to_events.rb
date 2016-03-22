class AddAttachmentEventPicToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :event_pic
    end
  end

  def self.down
    remove_attachment :events, :event_pic
  end
end
