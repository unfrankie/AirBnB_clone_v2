-- Create or use the hbnb_dev_db database
-- Create or update the hbnb_dev user with the specified password
-- Grant all privileges on the hbnb_dev_db database to the hbnb_dev user
-- Grant SELECT privilege on the performance_schema database to the hbnb_dev user

CREATE DATABASE IF NOT EXISTS hbnb_dev_db;
CREATE USER IF NOT EXISTS 'hbnb_dev'@'localhost' IDENTIFIED BY 'hbnb_dev_pwd';
GRANT ALL PRIVILEGES ON hbnb_dev_db.* TO 'hbnb_dev'@'localhost';
GRANT SELECT ON performance_schema.* TO 'hbnb_dev'@'localhost';
