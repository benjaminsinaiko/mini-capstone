class ProductsController < ApplicationController
  def carolina_reaper
    pepper = Product.first
    render json: pepper
  end

  def habanero
    pepper = Product.second
    render json: pepper
  end

  def cayenne
    pepper = Product.third
    render json: pepper
  end

  def jalapeno
    pepper = Product.fourth
    render json: pepper
  end

  def all_peppers
    peppers = Product.all
    render json: peppers.as_json
  end
end
