class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string      :name
      t.string     :license
      t.integer     :place_id
      t.integer     :band_id
      t.timestamps null: false
    end
  end
end
