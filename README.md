# Final Project Assignment

## Requirements

For your final project, you will create a website that uses Flask to access a MySQL database. Your project should include the following:

1. A SQL script that contains
    - a physical implementation for your database (database, tables, constraints, **indexes**) //done
    - statements that inserts sample data into your database //done
    - statements that create a user and grants appropriate access to the user.  This user will access the database in your Flask programs. //done

2. A Flask application that:
    - uses the libraries from the class example.  Applications that use another MySQL library such as SQLAlchemy will not be accepted.
    - displays an overview of the relevant data, excluding data that isn’t relevant to a user, such as autonumber keys
    - allow users to add, update and delete data in safe manner (prevent SQL injection attacks). 
    - includes any additional web pages that you feel would be useful, for example, a welcome page

## Grading

This project is worth **60 points**.
|Criteria|points|
| -- | -- |
| A SQL script is included that creates the database and tables| 10 |
|Attributes have reasonable data types|5 |
|Primary key constraints are included for all tables|5 |
|Foreign key constraints are included for all relationships including actions for update and delete.|10 |
|Indexes are created for fields frequently queried but not for fields that are primary keys or foreign keys| 10 |
|The script inserts sample data into tables|5 |
|Flask application displays an overview data, excluding data that isn’t relevant to a user, such as surrogate (auto increment) keys|5|
|Flask application allows users to securely add, edit and delete data for at least one table.|10|

### Assignment Submission

Push all files required to create your database and python files to your **GitHub repository**.

```shell
git add .
git commit -m "completed final project"
git push
```

**This assignment is due no later than 11:59 PM on Tuesday, December 12th.**
