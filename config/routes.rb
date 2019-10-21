Rails.application.routes.draw do
  
  get "/", to: "pages#home", as: "root"

    get "/listings", to: "listings#index", as: "listings"
    post "/listings", to: "listings#create"
    get "/listings/new", to: "listings#new", as: "new_listing"
    get "/listings/:id", to: "listings#show", as: "listing"
    put "/listings/:id", to: "listings#update"
    patch "/listings/:id", to: "listings#update"
    delete "/listings/:id", to: "listings#destroy"
    get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"

    get "/breeds", to: "breeds#index", as: "breeds"
    post "/breeds", to: "breeds#create"
    get "/breeds/new", to: "breeds#new", as: "new_breed"
    get "/breeds/:id", to: "breeds#show", as: "breed"
    put "/breeds/:id", to: "breeds#update"
    patch "/breeds/:id", to: "breeds#update"
    delete "/breeds/:id", to: "breeds#destroy"
    get "/breeds/:id/edit", to: "breeds#edit", as: "edit_breed"

    get "*path", to: "pages#not_found", constraints: lambda { |req| req.path.exclude? 'rails/active_storage'}

end
