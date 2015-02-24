class GalleriesController < ApplicationController
  before_action :load_gallery, except: [:index]

  def index
    @galleries = Gallery.all
  end

  def show
    @gallery_images = @gallery.gallery_images
  end
  
  def new
  end

  def edit
  end
  
  def create
    save_gallery(:new)   
  end

  def update
    save_gallery(:edit)
  end

  def destroy
    @gallery.destroy
    flash[:notice] = I18n.t('gallery.destroyed')
    redirect_to action: :index
  end

  def add_images
    if params[:gallery] && gallery_params[:images]
      gallery_params[:images].each do |image|
        @gallery.gallery_images.create(image: image)
      end
    end
    redirect_to action: :show, id: @gallery.id
  end

  private

  def gallery
    @gallery ||= params[:id] ? Gallery.find(params[:id]) : Gallery.new
  end
  alias_method :load_gallery, :gallery
  
  def gallery_params
    params.require(:gallery).permit(:name, :slug, :description, :image, :image_cache, images: [])
  end

  def save_gallery(template)
    @gallery.attributes = gallery_params
    if @gallery.save
      flash[:notice] = get_message(template)
      redirect_to action: :index
    else
      render template
    end
  end

  def get_message(action)
    action == :new ? I18n.t('gallery.created') : I18n.t('gallery.updated')
  end
end
