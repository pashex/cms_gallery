class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.string  :name
      t.text    :description
      t.string  :image
      t.string  :alt
      t.integer :gallery_id
      t.integer :position
      t.timestamps
    end

    add_index :gallery_images, :gallery_id
  end
end
