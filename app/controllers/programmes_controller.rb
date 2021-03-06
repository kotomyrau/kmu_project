class ProgrammesController < ApplicationController
  def new
    @programme = Programme.new
    @user = current_user
  end

  def create
    @programme = Programme.new(programme_params)
    @user = current_user
    if @programme.save
      redirect_to users_path
    else
      render :new
    end
  end

    def show
      @programme = Programme.find(params[:id])
      @project_programme = ProjectProgramme.where(programme_id: @programme.id)
    end



    def destroy
      @programme = Programme.find(params[:id])
      if @programme.destroy
        flash[:notice] = "#{@programme.name} has been deleted"
        redirect_to root_path
      else
        redirect_to programme_path(@programme), notice: 'There was a problem, this programme was not deleted!'
      end
    end
  private

  def programme_params
    params.require(:programme).permit(:name, :skill)
  end
end
