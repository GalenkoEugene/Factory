# frozen_string_literal: true

require_relative 'factory'

puts '=-=-=- User -=-=-='
User = Factory.new(:name, :age)
puts user = User.new('Alex', 24)

puts user[:name] # Alex
puts user['name'] # Alex
puts user.name # Alex
puts user[0] # Alex
puts user[1] # 24
puts user[2] # raise error "IndexError: Wrong index of attributes"

puts '=-=-=- Reader -=-=-='
Reader = Factory.new(:name, :email, :city) do
  def info
    puts "Name is: #{name}, contact me: #{email}, I live in #{city}"
  end
end

puts reader = Reader.new('Oleg', 'oleg@gmail.ru', 'Dnipro')
puts reader[2] # Dnipro
puts reader.info # Name is: Oleg, contact me: oleg@gmail.ru, I live in Dnipro
