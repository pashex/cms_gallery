class Admin::GalleryImagesController < ApplicationController
  before_action :load_gallery_image

  def show
  end
  
  def new
  end

  def edit
  end
  
  def create
    save_gallery_image(:new)   
  end

  def update
    save_gallery_image(:edit)
  end

  def destroy
    @gallery_image.destroy
    flash[:notice] = I18n.t('gallery_image.destroyed')
    redirect_to controller: :galleries, action: :show, id: @gallery_image.gallery_id
  end

  private
  
  def gallery
    @gallery ||= Gallery.find(params[:gallery_id])
  end

  def gallery_images_scope
    @gallery_images_scope ||= gallery.gallery_images
  end

  def gallery_image
    @gallery_image ||= params[:id] ? GalleryImage.find(params[:id]) : gallery_images_scope.build
  end
  alias_method :load_gallery_image, :gallery_image
  
  def gallery_image_params
    params.require(:gallery_image).permit(:name, :description, :image, :image_cache, :alt)
  end

  def save_gallery_image(template)
    @gallery_image.attributes = gallery_image_params
    if @gallery_image.save
      flash[:notice] = get_message(template)
      redirect_to controller: :galleries, action: :show, id: @gallery_image.gallery_id
    else
      render template
    end
  end

  def get_message(action)
    action == :new ? I18n.t('gallery_image.created') : I18n.t('gallery_image.updated')
  end
end
