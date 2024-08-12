class EnrollmentsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :set_enrollment, only: %i[ show update destroy ]

  http_basic_authenticate_with(
    name: ENV['BASIC_AUTH_NAME'],
    password: ENV['BASIC_AUTH_PASSWORD'],
    only: %i[ create update destroy ]
  )

  # GET /enrollments
  def index
    @enrollments = Enrollment.all

    render json: @enrollments
  end

  # GET /enrollments?page=1&count=2
  def index
    page = (params[:page] || 1).to_i
    count = (params[:count] || 10).to_i
    offset = (page - 1) * count

    @enrollment_list = Enrollment.offset(offset).limit(count)
    @enrollments = @enrollment_list.map do |enrollment|
      {
        "id": enrollment.id,
        "student_id": enrollment.student_id,
        "amount": enrollment.amount,
        "installments": enrollment.installments,
        "due_day": enrollment.due_day,
        "bills": enrollment.bills.each do |bill|
          {
            "id": bill.id,
            "due_date": bill.due_date,
            "status": bill.status,
            "amount": bill.amount
          }
        end
      }
    end

    render json: {
      page: page,
      items: @enrollments
    }
  end

  # GET /enrollments/1
  def show
    render json: @enrollment
  end

  # POST /enrollments
  def create
    @enrollment = Enrollment.new(enrollment_params)

    if @enrollment.save
      @saida = {
        "id": @enrollment.id,
        "student_id": @enrollment.student_id,
        "amount": @enrollment.amount,
        "installments": @enrollment.installments,
        "due_day": @enrollment.due_day,
        "bills": @enrollment.bills.each do |bill|
          {
            "id": bill.id,
            "due_date": bill.due_date,
            "status": bill.status,
            "amount": bill.amount
          }
        end
      }

      render json: @saida
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /enrollments/1
  def update
    if @enrollment.update(enrollment_params)
      render json: @enrollment
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /enrollments/1
  def destroy
    @enrollment.destroy!
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def enrollment_params
    params.require(:enrollment).permit(:amount, :installments, :due_day, :student_id)
  end
end
