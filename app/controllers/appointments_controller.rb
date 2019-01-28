class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_appointments, only: [:index, :show, :edit]
  before_action :set_client, only: [:index, :new, :edit]
  before_action :set_template, only: [:index, :new, :edit]

  def index
    @upcoming_appointments = Appointment.order(appointment_time: :desc).select { |a| a.appointment_time > (DateTime.now) } if Appointment.count != 0
  end

  def show
  end

  def new
    @appointments = Appointment.select { |a| a.persisted? }
    @appointment = Appointment.new
    @templates = Template.all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    my_phone = "7866619324"
    phone = @appointment.client.phone_number
    message = "You have a appointment on #{@appointment.appointment_time.strftime('%m/%d/%y at %I:%M%p')} \rClient:#{@appointment.client.name}\rtemplate:#{@appointment.template.nickname}\rPayout:$#{@appointment.template.price}"
    if @appointment.valid?
      phone.gsub!(/\D/, '')
      TwilioTextMessenger.new(message, phone).call
      phone = my_phone
      TwilioTextMessenger.new(message, phone).call
      @appointment.price = @appointment.template.price
      @appointment.save
      redirect_to templates_path
    else
      @appointments = Appointment.select { |a| a.persisted? }
      render :new
    end
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else
      set_appointments
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path
  end

  private

  def set_client
    @client = Client.find_by(id: params[:client_id])
  end

  def set_template
    @template = Template.find_by(id: params[:template_id])
  end

  def set_appointment
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment.nil?
      flash[:error] = "Appointment not found."
      redirect_to appointments_path
    end
  end

  def set_appointments
    @appointments = Appointment.order(appointment_time: :desc)
  end

  def appointment_params
    params.require(:appointment).permit(:client_id, :price, :template_id, template_attributes: [:nickname, :price], client_attributes: [:name, :phone_number], appointment_time: [:date, :hour, :min], duration: [:hour, :min])
  end

end
