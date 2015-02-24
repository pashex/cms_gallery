require 'rails_helper'

RSpec.describe GalleriesController, :type => :controller do
  render_views
  
  let!(:first_gallery) { create :gallery }
  let!(:second_gallery) { create :gallery }

  let!(:first_image) { create :gallery_image, gallery: second_gallery }
  let!(:second_image) { create :gallery_image, gallery: second_gallery }

  describe '#index' do
    it "should return list of galleries" do
      get :index
      expect(response).to render_template("index")
      expect(assigns(:galleries)).to eq([first_gallery, second_gallery])
    end
  end

  describe '#show' do
    context "when gallery exists" do
      it "should return gallery with images" do
        get :show, id: second_gallery.id
        expect(response).to render_template("show")
        expect(assigns(:gallery)).to eq(second_gallery)
        expect(assigns(:gallery_images).sort).to eq([first_image, second_image].sort)
      end
    end
    
    context "when gallery doesn't exist" do
      it "should raise not found exception" do
        expect{ get :show, id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  
  describe '#new' do
    it "should return new gallery to edit" do
      get :new
      expect(response).to render_template("new")
      expect(assigns(:gallery)).to be_new_record
    end
  end
  
  describe '#edit' do
    context "when gallery exists" do
      it "should return gallery to edit" do
        get :edit, id: second_gallery.id
        expect(response).to render_template("edit")
        expect(assigns(:gallery)).to eq(second_gallery)
      end
    end
    
    context "when gallery doesn't exist" do
      it "should raise not found exception" do
        expect{ get :edit, id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#create' do
    it "should create new gallery" do
      post :create, gallery: { name: 'new gallery' }
      expect(response).to redirect_to(:galleries)
      expect(Gallery.last.name).to eq('new gallery')
    end
  end

  describe '#update' do
    context "when gallery exists" do
      it "should update gallery" do
        patch :update, id: second_gallery.id, gallery: { name: 'new gallery' }
        expect(response).to redirect_to(:galleries)
        expect(second_gallery.reload.name).to eq('new gallery')
      end
    end
    
    context "when gallery doesn't exist" do
      it "should raise not found exception" do
        expect{ patch :update, id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  
  describe '#destroy' do
    context "when gallery exists" do
      it "should destroy gallery with images" do
        delete :destroy, id: second_gallery.id
        expect(response).to redirect_to(:galleries)
        expect{ second_gallery.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect{ first_image.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    context "when gallery doesn't exist" do
      it "should raise not found exception" do
        expect{ delete :destroy, id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  
  describe '#add_images' do
    before do
      @file = Rack::Test::UploadedFile.new('spec/files/tux.png')
    end

    it "should create several images in gallery" do
      expect { put :add_images, id: first_gallery.id, gallery: { images: [@file, @file] } }.to change { first_gallery.gallery_images.count }.by(2)
      
      expect(response).to redirect_to first_gallery
      expect(first_gallery.gallery_images.last(2).map {|gi| gi.image_url}).to match [/tux.png/, /tux.png/]
    end
  end

end
