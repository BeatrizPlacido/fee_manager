class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :cpf
      t.date :bithdate
      t.string :payment_method

      t.timestamps
    end
  end
end
