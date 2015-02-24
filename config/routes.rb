Rails.application.routes.draw do
  scope 'admin' do
    resources :galleries, shallow: true do
      put :add_images, on: :member 
      resources :gallery_images, except: :index
    end
  end
end
