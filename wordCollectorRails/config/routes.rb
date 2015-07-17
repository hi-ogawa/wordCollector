Rails.application.routes.draw do

  devise_for :users
  # which generates below:
#         new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
#             user_session POST   /users/sign_in(.:format)       devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
#        user_registration POST   /users(.:format)               devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
#                          PATCH  /users(.:format)               devise/registrations#update
#                          PUT    /users(.:format)               devise/registrations#update
#                          DELETE /users(.:format)               devise/registrations#destroy

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
