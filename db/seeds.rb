# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者のデータが消えないように「seed」に記入している
Admin.create!(
  name: 'test',
  email: 'test@test',
  password: 'testtest',
)

Category.create!(
  name: '10代'
)