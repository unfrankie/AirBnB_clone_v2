-- Create or use the hbnb_test_db database
-- Create or update the hbnb_test user with the specified password
-- Grant all privileges on the hbnb_test_db database to the hbnb_test user
-- Grant SELECT privilege on the performance_schema database to the hbnb_test user

CREATE DATABASE IF NOT EXISTS hbnb_test_db;
CREATE USER IF NOT EXISTS 'hbnb_test'@'localhost' IDENTIFIED BY 'hbnb_test_pwd';
GRANT ALL PRIVILEGES ON hbnb_test_db.* TO 'hbnb_test'@'localhost';
GRANT SELECT ON performance_schema.* TO 'hbnb_test'@'localhost';
