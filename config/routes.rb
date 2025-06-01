Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  scope '/api' do
    post :assign, to: 'devices#assign'
    post :unassign, to: 'devices#unassign'
    get :assigned, to: 'devices#assigned'
    get 'device_history/:serial_number', to: 'devices#device_history'
  end
end
