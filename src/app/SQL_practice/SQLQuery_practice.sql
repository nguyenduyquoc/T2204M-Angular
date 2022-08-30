--create table
create table Department (
	DepartId int identity(1,1) primary key,
	DepartName varchar(50) not null,
	Description varchar(100) not null
);

create table Employee (
	EmpCode char(6) primary key,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Birthday smalldatetime not null,
	Gender bit default 1,
	Address varchar(100),
	DepartId int not null foreign key references Department(DepartId),
	Salary money
);

--insert data
 
insert into Department(DepartName, Description) values 
('sale department','sales for the company'),
('marketing department','give all ideas to the company'),
('personnel department','Manage all employee issues in the company');

insert into Employee values
('EPAAA', 'Lionel', 'Messi', '19870206', '1', 'Barelona', 1, 200.05),
('EPAAB', 'David', 'Dgea', '19920905', '1', 'Manchester', 3, 200.35),
('EPAAC', 'Nguyen', 'Phuong Ngan', '20000506', '0', 'Ha Noi', 2, 200.87),
('EPAAD', 'Cristiano', 'Ronaldo', '19870204', '1', 'Madrid', 1, 300.78)

--2. Increase the salary for all employees by 10% 

update Employee set Salary = Salary * (1 + 0.1);

--3. Using ALTER TABLE statement to add constraint on Employee table to ensure that
--salary always greater than 0 

alter table Employee add constraint check_salary check(Salary > 0);

--4Create an unique, none-clustered index named IX_DepartmentName on
--DepartName column on Department table 

create index IX_DepartmentName on Department(DepartName);

--5. Create an unique, none-clustered index named IX_DepartmentName on
--DepartName column on Department table [1 marks].

create unique index IX_DeparmentName
on Department(DepartName);

--7. Create a stored procedure named sp_getAllEmp that accepts Department ID as
--given input parameter and displays all employees in that Department 

create procedure sp_getAllEmp @departmentId int as
select * from Employee where DepartId = @departmentId;

exec sp_getAllEmp  @departmentId = 1;
