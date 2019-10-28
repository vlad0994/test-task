Rails.application.routes.draw do
  scope '/api' do
    resources :images, only: %i[create index show update], defaults: { format: :json }
    resource :users, only: [:create], defaults: { format: :json }
  end
end
