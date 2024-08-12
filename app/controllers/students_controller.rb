class StudentsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :set_student, only: %i[ show update destroy ]

  http_basic_authenticate_with(
    name: ENV['BASIC_AUTH_NAME'],
    password: ENV['BASIC_AUTH_PASSWORD'],
    only: %i[ destroy ]
  )

  # GET /students?page=1&count=2
  def index
    page = (params[:page] || 1).to_i
    count = (params[:count] || 10).to_i
    offset = (page - 1) * count

    @students_list = Student.offset(offset).limit(count)
    @students = @students_list.map do |student|
      {
        "id": student.id,
        "name": student.name,
        "cpf": student.cpf,
        "birthdate": student.birthdate,
        "payment_method": student.payment_method
      }
    end

    render json: {
      page: page,
      count: count,
      items: @students
    }
  end

  # GET /students/1
  def show
    render json: @student
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      render json: { id: @student.id }
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :cpf, :bithdate, :payment_method)
    end
end
