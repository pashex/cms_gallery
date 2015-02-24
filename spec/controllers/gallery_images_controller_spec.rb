require 'rails_helper'

RSpec.describe GalleryImagesController, :type => :controller do
  render_views
  
  let!(:gallery) { create :gallery }
  let!(:other_gallery) { create :gallery }

  let!(:first_image) { create :gallery_image, gallery: gallery }
  let!(:second_image) { create :gallery_image, gallery: gallery }

  describe '#show' do
    context "when gallery image exists" do
      it "should return gallery image" do
        get :show, id: second_image.id
        expect(response).to render_template("show")
        expect(assigns(:gallery_image)).to eq(second_image)
      end
    end

    context "when gallery image doesn't exist" do
      it "should raise not found exception" do
        expect{ get :show, id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  
  describe '#new' do
    context "when gallery exists" do
      it "should return new gallery image to edit" do
        get :new, gallery_id: gallery.id
        expect(response).to render_template("new")
        expect(assigns(:gallery_image)).to be_new_record
        expect(assigns(:gallery_image).gallery_id).to eq(gallery.id)
      end
    end
    
    context "when gallery doesn't exist" do
      it "should raise not found exception" do
        expect{ get :new, gallery_id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  
  describe '#edit' do
    context "when gallery image exists" do
      it "should return gallery image to edit" do
        get :edit, id: second_image.id
        expect(response).to render_template("edit")
        expect(assigns(:gallery_image)).to eq(second_image)
      end
    end

    context "when gallery image doesn't exist" do
      it "should raise not found exception" do
        expect{ get :edit, id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#create' do
    context "when gallery exists" do  
      it "should create new gallery image" do
        expect { post :create, gallery_id: gallery.id, gallery_image: { name: 'new image' } }.to change { gallery.gallery_images.count }.by(1)
        expect(response).to redirect_to gallery
        expect(GalleryImage.last.name).to eq('new image')
      end
    end

    context "when gallery doesn't exist" do
      it "should raise not found exception" do
        expect{ post :create, gallery_id: 0, gallery_image: { name: 'new image' } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#update' do
    context "when gallery image exists" do
      it "should update gallery image" do
        patch :update, id: second_image.id, gallery_image: { name: 'new image' }
        expect(response).to redirect_to gallery
        expect(second_image.reload.name).to eq('new image')
      end
    end
    
    context "when gallery image doesn't exist" do
      it "should raise not found exception" do
        expect{ patch :update, id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  
  describe '#destroy' do
    context "when gallery image exists" do
      it "should destroy gallery image" do
        delete :destroy, id: second_image.id
        expect(response).to redirect_to gallery
        expect{ second_image.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    context "when gallery image doesn't exist" do
      it "should raise not found exception" do
        expect{ delete :destroy, id: 0 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
