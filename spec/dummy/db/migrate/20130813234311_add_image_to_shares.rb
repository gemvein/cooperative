class AddImageToShares < ActiveRecord::Migration
  def self.up
    change_table :shares do |t|
      t.has_attached_file :image
    end
  end
  def self.down
    drop_attached_file :shares, :image
  end
end
