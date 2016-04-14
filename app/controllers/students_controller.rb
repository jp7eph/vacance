class StudentsController < ApplicationController
  def index
    @students = Student.all
    @places = Place.all
    find_student_with_place
    binding.pry
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.place_id = 0
    @student.band_id = 0

    if @student.save
      redirect_to student_path(@student)
    else
      render :new
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  private

  def student_params
    params.require(:student).permit(:name, :license,:place_id)
  end

  def find_student_with_place
    @student_hash = {}
    @place_hash = @places.group_by do |place|
      place.id
    end
    if @places.present?
      @places.each do |key, value|
        @student_hash["#{key.id}"] = @students.where("place_id = ?", "#{key.id}")
      end
    end
  end
end
