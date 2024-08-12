5.times do
  FactoryBot.create(:student, :boleto)
end

Student.all.each{ |student| FactoryBot.create(:enrollment, student: student) }
