# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Categoria.find_or_create_by(name: "Condominio", description: "Gasto de condominio")
Categoria.find_or_create_by(name: "Internet", description: "Internet")
Categoria.find_or_create_by(name: "Conta de Energia", description: "Gasto de energia/luz")
Categoria.find_or_create_by(name: "Comida", description: "Refeição/Delivery")
Categoria.find_or_create_by(name: "Services", description: "General Services")
Categoria.find_or_create_by(name: "Credit Card", description: "Credit card spendings")
Categoria.find_or_create_by(name: "Gas", description: "Gas spendings")
