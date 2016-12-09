class HomesController < ApplicationController
  def price  
  end
  def index
    @homes = Home.all
  end
end
