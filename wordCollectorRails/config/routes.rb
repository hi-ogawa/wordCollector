Rails.application.routes.draw do

  get 'home/show'

  # https://richonrails.com/articles/google-authentication-in-ruby-on-rails
  get 'sessions/create'
  get 'sessions/destroy'

  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure'            => redirect('/')
  get 'signout'                 => 'sessions#destroy', as: 'signout'

  # http://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing
  # resources :categories
  get    'categories'          => 'categories#index',  as: 'categories'
  post   'categories'          => 'categories#create'
  get    'categories/new'      => 'categories#new',    as: 'new_category'
  get    'categories/:id/edit' => 'categories#edit',   as: 'edit_category'
  get    'categories/:id'      => 'categories#show',   as: 'category'
  patch  'categories/:id'      => 'categories#update'
  put    'categories/:id'      => 'categories#update'
  delete 'categories/:id'      => 'categories#destroy'
 
  # resources :posts (removeing #index, #destroy)
  post   'posts'          => 'posts#create'
  get    'posts/new'      => 'posts#new',    as: 'new_post'
  get    'posts/:id/edit' => 'posts#edit',   as: 'edit_post'
  patch  'posts/:id'      => 'posts#update', as: 'post'
  put    'posts/:id'      => 'posts#update'
 
 
  ## probably, i should employ this nesting model relation, but not now.
  # resources :categories do
  #   resources :posts
  # end
 
  post 'change_category' => 'posts#change_category'
  post 'sort'            => 'posts#sort'
  post 'multiple_delete' => 'posts#multiple_delete'
  post 'multiple_edit'   => 'posts#multiple_edit'
 
  post 'chrome'      => 'posts#chrome'
  get  'iphone_word' => 'posts#iphone_word'
  post 'iphone_pic'  => 'posts#iphone_pic'

  post 'chrome_categories_create' => 'categories#chrome_categories_create'
  post 'chrome_categories_index'  => 'categories#chrome_categories_index'
   
  root 'categories#index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
