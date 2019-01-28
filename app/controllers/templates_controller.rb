class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: [:client_list, :show, :edit, :update, :destroy]

  def index
    @templates = Template.all
  end

  def client_list
    @clients = @template.clients
  end

  def show
    @appointments = @template.appointments
  end

  def new
    @template = Template.new
  end

  def create
    @template = Template.new(template_params)
    if @template.valid?
      @template.user = current_user
      @template.save
      redirect_to templates_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @template.update(template_params)
      redirect_to template_path(@template)
    else
      render :edit
    end
  end

  def destroy
    @template.destroy
    redirect_to templates_path
  end

  private

  def set_template
    @template = Template.find_by(id: params[:id])
    if @template.nil?
      flash[:error] = "template not found."
      redirect_to templates_path
    end
  end

  def template_params
    params.require(:template).permit(:nickname, :src, :iframe, :price)
  end
end
