class AddAttachmentImageToUserIcons < ActiveRecord::Migration
  def self.up
    change_table :user_icons do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :user_icons, :image
  end
end
