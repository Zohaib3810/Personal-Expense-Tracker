SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE users (
  user_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(25) NOT NULL,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL
);

CREATE TABLE expense_categories (
  category_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL
);

CREATE TABLE expenses (
  expense_id INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) NOT NULL,
  expense DECIMAL(10,2) NOT NULL,
  expense_date DATE NOT NULL,
  expense_category INT(11) NOT NULL,
  payment_method VARCHAR(50),
  notes TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (expense_category) REFERENCES expense_categories(category_id)
);

CREATE TABLE income_sources (
  income_source_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) NOT NULL,
  source_name VARCHAR(100) NOT NULL,
  description TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE incomes (
  income_id INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) NOT NULL,
  income_source_id INT(11) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  income_date DATE NOT NULL,
  notes TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (income_source_id) REFERENCES income_sources(income_source_id)
);

CREATE TABLE budgets (
  budget_id INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) NOT NULL,
  category_id INT(11) NOT NULL,
  budget_amount DECIMAL(10,2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (category_id) REFERENCES expense_categories(category_id)
);

CREATE TABLE payment_methods (
  payment_method_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  method_name VARCHAR(50) NOT NULL
);

CREATE TABLE debts (
  debt_id INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) NOT NULL,
  creditor_name VARCHAR(100) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  due_date DATE,
  status VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE savings_goals (
  goal_id INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) NOT NULL,
  goal_name VARCHAR(100) NOT NULL,
  target_amount DECIMAL(10,2) NOT NULL,
  saved_amount DECIMAL(10,2) DEFAULT 0,
  target_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE recurring_expenses (
  recurring_expense_id INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) NOT NULL,
  expense_category INT(11) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  recurrence_period VARCHAR(50) NOT NULL,
  next_due_date DATE,
  notes TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (expense_category) REFERENCES expense_categories(category_id)
);

INSERT INTO users (firstname, lastname, email, password) VALUES
('Ahmed', 'Khan', 'ahmed.khan@example.com', 'e99a18c428cb38d5f260853678922e03'), -- password: abc123
('Fatima', 'Ali', 'fatima.ali@example.com', '5f4dcc3b5aa765d61d8327deb882cf99');  -- password: password

INSERT INTO expense_categories (category_name) VALUES
('Medicine'),
('Food'),
('Bills & Recharges'),
('Entertainment'),
('Clothing'),
('Rent'),
('Household Items'),
('Education'),
('Transport'),
('Others');

INSERT INTO payment_methods (method_name) VALUES
('Cash'),
('Credit Card'),
('Debit Card'),
('UPI'),
('Net Banking');

INSERT INTO expenses (user_id, expense, expense_date, expense_category, payment_method, notes) VALUES
(1, 500.00, '2025-05-10', 1, 'Cash', 'Purchased medicine for flu'),
(1, 200.00, '2025-05-11', 2, 'Debit Card', 'Groceries shopping'),
(2, 150.00, '2025-05-09', 3, 'UPI', 'Electricity bill payment'),
(2, 300.00, '2025-05-12', 4, 'Credit Card', 'Movie night with friends'),
(1, 250.00, '2025-05-08', 5, 'Cash', 'Bought new shirt'),
(1, 1200.00, '2025-05-01', 6, 'Net Banking', 'Monthly house rent'),
(2, 80.00, '2025-05-05', 7, 'Cash', 'Kitchen cleaning supplies'),
(2, 600.00, '2025-05-02', 8, 'Debit Card', 'Books for studies'),
(1, 50.00, '2025-05-04', 9, 'UPI', 'Taxi fare to office'),
(1, 100.00, '2025-05-03', 10, 'Cash', 'Miscellaneous expenses');

INSERT INTO income_sources (user_id, source_name, description) VALUES
(1, 'Salary', 'Monthly salary from IT company'),
(2, 'Freelance', 'Freelance graphic designing jobs');

INSERT INTO incomes (user_id, income_source_id, amount, income_date, notes) VALUES
(1, 1, 5000.00, '2025-05-01', 'May salary'),
(2, 2, 1500.00, '2025-05-07', 'Project payment');

INSERT INTO budgets (user_id, category_id, budget_amount, start_date, end_date) VALUES
(1, 2, 1000.00, '2025-05-01', '2025-05-31'),
(1, 6, 1200.00, '2025-05-01', '2025-05-31'),
(2, 8, 700.00, '2025-05-01', '2025-05-31');

INSERT INTO debts (user_id, creditor_name, amount, due_date, status) VALUES
(1, 'Ali Hassan', 300.00, '2025-06-01', 'Pending'),
(2, 'Sara Malik', 150.00, '2025-05-25', 'Paid');

INSERT INTO savings_goals (user_id, goal_name, target_amount, saved_amount, target_date) VALUES
(1, 'Umrah Trip', 10000.00, 2500.00, '2026-01-01'),
(2, 'New Laptop', 2000.00, 500.00, '2025-12-01');

INSERT INTO recurring_expenses (user_id, expense_category, amount, recurrence_period, next_due_date, notes) VALUES
(1, 3, 150.00, 'Monthly', '2025-06-05', 'Electricity bill'),
(2, 2, 400.00, 'Monthly', '2025-06-01', 'Grocery shopping'),
(1, 6, 1200.00, 'Monthly', '2025-06-01', 'Rent payment');

COMMIT;
