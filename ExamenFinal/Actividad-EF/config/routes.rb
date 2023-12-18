Rottenpotatoes::Application.routes.draw do
  get 'search_tmdb/index'

    resources :movies
    # map '/' to be a redirect to '/movies'
    root :to => redirect('/movies')

    get '/search_tmdb',to: 'search_tmdb#index'
end
  