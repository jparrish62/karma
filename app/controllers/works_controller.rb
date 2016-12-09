class WorksController < ApplicationController

  def show
    @work    = Work.find(params[:stylist_id])
    @stylist = Stylist.find(params[:id])
  end

  def create
    @stylist  = Stylist.find(params[:stylist_id])
    @work     = @stylist.works.create(work_params)
    if @work.save!
      redirect_to stylist_path(@stylist)
    else
      render 'form'
    end
  end

  private

  def work_params
    params.require(:work).permit(:image, :title, :body)
  end
end
