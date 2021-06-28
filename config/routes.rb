Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit] # view, edit and create nested posts for authors
    # can now use /authors/author/:id/post and new_author_post_path
  end

  resources :posts
end
