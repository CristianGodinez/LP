Rails.application.routes.draw do
  get "perfiles/edit"
  get "perfiles/update"
  get "reportes/index"



  resources :productos
  resources :empleados, except: [:show]
  resources :compras
  resources :reportes, only: [:index, :edit, :update, :destroy] do
    collection do
      get :exportar_pdf
      get :exportar_excel
    end
  end




  devise_for :users, skip: [:registrations, :passwords]

  get "up" => "rails/health#show", as: :rails_health_check

  root "compras#index"

  #get "reportes/exportar_pdf", to: "reportes#exportar_pdf", as: :exportar_pdf_reportes
  #get "reportes/exportar_excel", to: "reportes#exportar_excel", as: :exportar_excel_reportes

  resource :perfil, only: [:edit, :update], controller: 'perfiles'
end
