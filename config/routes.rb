Rails.application.routes.draw do
  get"/carolinareaper" => "products#carolina_reaper"
  get"/habanero" => "products#habanero"
  get"/cayenne" => "products#cayenne"
  get"/jalapeno" => "products#jalapeno"
  get"/peppers" => "products#all_peppers"
end
