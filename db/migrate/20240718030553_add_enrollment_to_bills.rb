class AddEnrollmentToBills < ActiveRecord::Migration[7.1]
  def change
    add_reference :bills, :enrollment, null: false, foreign_key: true
  end
end
