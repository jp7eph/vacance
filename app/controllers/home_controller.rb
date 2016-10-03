class HomeController < ApplicationController
  before_action :set_students
  def index
    find_student_with_place
  end

  def update
    students = Student.find(params[:student_id])
    if params[:place_id].present?
      students.map do |student|
        student.update_attribute(:place_id, params[:place_id])
     end
   end
   if params[:band_id].present?
      students = Student.find(params[:student_id])
      students.map do |student|
        student.update_attribute(:band_id, params[:band_id])
      end
    end
    render :index
  end

  private

  def find_student_with_place
    @student_hash = {}
    @student_band_hash = {}
    @place_hash = @places.group_by do |place|
      place.id
    end
    @band_hash = @bands.group_by do |band|
      band.id
    end
    if @places.present?
      @places.each do |key, value|
        @student_hash["#{key.id}"] = @students.where("place_id = ?", "#{key.id}")
      end
    end
    if @bands.present?
      @bands.each do |key, value|
        @student_band_hash["#{key.id}"] = @students.where("band_id = ?", "#{key.id}")
      end
    end
  end

  def set_students
    @students = Student.all
    @places = Place.all
    @bands = Band.all
    @students_map = Student.all.pluck(:name,:id)
    @places_map = Place.all.pluck(:name, :id)
    @bands_map = Band.all.pluck(:name, :id)
    find_student_with_place
  end
end
