# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Categoria.find_or_create_by(id: 3, name: "food", description: "Refeição/Delivery")
Categoria.find_or_create_by(id: 4, name: "housing", description: "Gasto de condominio")
Categoria.find_or_create_by(id: 5, name: "utilities", description: "Gasto de energia/luz")
Categoria.find_or_create_by(id: 7, name: "services", description: "General Services")
Categoria.find_or_create_by(id: 8, name: "credit_card", description: "Credit card spendings")
Categoria.find_or_create_by(id: 9, name: "internet", description: "Internet")
