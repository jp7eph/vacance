class StudentsController < ApplicationController
  before_action :set_students

  def index
    find_student_with_place
  end

  def new
    @student = Student.new
  end

  def create
    if Student.find_by(id: params[:student_id])
      update
    else
      @student = Student.new(student_params)
      @student.place_id = 0
      @student.band_id = 0
      if @student.save
        redirect_to student_path(@student)
      else
        render :new
      end
    end
  end

  def show
    @students = Student.all
    @student = Student.find(params[:id])
  end

  def update
    students = Student.find(params[:student_id])
    binding.pry
    students.map do |student|
      student.update_attribute(:place_id, params[:place_id])
    end
    render :index
  end

  private

  def student_params
    params.require(:student).permit(:id, :name, :license, :place_id)
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

  def set_students
    @students = Student.all
    @places = Place.all
    @students_map = Student.all.pluck(:name,:id)
    @places_map = Place.all.pluck(:name, :id)
    find_student_with_place
  end

end
