class AddAttachmentImageToStylists < ActiveRecord::Migration
  def self.up
    change_table :stylists do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :stylists, :image
  end
end
