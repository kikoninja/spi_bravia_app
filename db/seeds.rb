puts 'Setting seeds for your environment'

User.delete_all
puts "- deleted old data"

admin = User.create!(:username => 'admin', :email => 'admin@example.org',
                   :password => 'password')
admin.admin = true
admin.save
puts "- created admin user (user: admin@example.org / pass: password)"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
