require 'rails_helper'

RSpec.describe Gallery, :type => :model do
  let(:gallery) { create :gallery }

  describe "image uploading" do
    it "should create thumb and medium versions of uploaded image" do
      gallery.update(image: File.open('spec/files/tux.png'))
      expect(gallery.image_url(:thumb)).to match /tux.png/
      expect(gallery.image_url(:medium)).to match /tux.png/
    end
  end 
end
