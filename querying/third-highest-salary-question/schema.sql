create table employee
(
    name CHAR(20),
    salary DECIMAL(20,2)
);

INSERT INTO employee(name, salary) 
VALUES 
	('Joe', 1000), 
	('Steve', 2000), 
	('Mary', 3000), 
	('Fred', 4000), 
	('John', 5000);
