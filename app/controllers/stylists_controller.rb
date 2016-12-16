class StylistsController < ApplicationController
  before_action :authenticate_user!

  def new
    @stylist = Stylist.new
    @work    = @stylist.works.build
  end

  def index
    @stylists = Stylist.all
  end

  def show
   @stylist      = Stylist.find(params[:id])
   @appointment  = @stylist.appointments.build
   @stylist_work = Stylist.find(params[:id]).works
  end

  def create
    @stylist = current_user.stylists.build(stylist_params)
    if @stylist.save
      redirect_to stylists_path, notice: "Stylist Created"
    else
      render 'form'
    end
  end

  private

  def stylist_params
    params.require(:stylist).permit(:name, :email, :bio, :image)
  end
end
