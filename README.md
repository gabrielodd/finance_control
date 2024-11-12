# Finance Control

Finance Control is a personal finance management application built with Ruby on Rails. The app helps users manage and track their expenses by categorizing them, showing monthly breakdowns, and other various statistics.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Database Structure](#database-structure)
- [Contributing](#contributing)
- [License](#license)

## Features

- **User Authentication**: Built with Devise to support secure user sign-ups and logins.
- **Expense Tracking**: Track your expenses by month and category.
- **Categories**: Organize expenses into customizable categories.
- **Future Expenses**: Add and view future expenses.
- **Reports and Analysis**: View monthly summaries and expense comparison with previous months.
- **Localization**: Switch between different languages (supports both English and Portuguese).
- **Color Themes**: Customize the background color of the panel.
- **Data Export/Import**: Export expenses to JSON and import JSON files for easy data management.

## Screenshots

Here are some screenshots of the app:

1. **Main Expenses Screen**

   [Main Expenses](https://github.com/user-attachments/assets/1b63b7f1-8241-4819-80c9-37ce721d4fa4)

## Installation

### Prerequisites

- Ruby 2.7.0
- Rails 6.0.6.1
- MySQL

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/finance-control.git
   cd finance-control
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Configure the database:
   Update the `config/database.yml` file with your MySQL credentials.

   Then, run the following commands:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the Rails server:
   ```bash
   rails server
   ```

5. Visit `http://localhost:3000` in your browser.

## Usage

### Managing Expenses
- To add a new expense, click on the "New Expense" button.
- Organize expenses by month and category, and view monthly summaries.
- Toggle monthly expenses to see details for each category.

### Data Export/Import
- Use the "Export to JSON" button to save your expenses data.
- Use the "Import JSON" button to load expenses from a JSON file.

## Dependencies

Here's a summary of key dependencies used in the project:

- **Rails** 6.0.6.1
- **MySQL2** (for MySQL database integration)
- **Devise** (user authentication)
- **Chartkick** (for generating charts in reports)
- **Delayed Job Active Record** (for background job processing)

## Database Structure

The database structure is defined as follows:

- **categoria**: Stores categories created by the user. Each category belongs to a user.
- **despesas**: Stores expenses with fields for description, value, date, and whether it's a recurring expense. Each expense is associated with a category and a user.
- **user_configurations**: Stores user-specific settings like `locale` and `panel_color`.
- **users**: Stores user authentication data and user type (admin or regular user).

Here’s an example schema for each table:

```ruby
create_table "categoria" do |t|
  t.string "name"
  t.text "description"
  t.bigint "user_id"
end

create_table "despesas" do |t|
  t.string "descricao"
  t.decimal "valor", precision: 15, scale: 2
  t.date "date"
  t.boolean "repeating"
  t.bigint "categoria_id"
  t.bigint "user_id"
end

create_table "user_configurations" do |t|
  t.string "locale"
  t.bigint "user_id"
  t.string "panel_color"
end

create_table "users" do |t|
  t.string "email", null: false
  t.string "encrypted_password", null: false
  t.boolean "admin", default: false
end
```

## Contributing

Contributions are welcome! If you find bugs or have feature requests, please open an issue or create a pull request. Make sure to follow the project coding style and write tests for any new functionality.

## License

This project is open-source under the MIT License.
