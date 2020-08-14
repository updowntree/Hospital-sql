create schema healthCare2;

create table if not exists hospital (
    id                          serial primary key
    , principal_doctor_id       integer
    , name                      varchar(100) not null
    , address                   varchar(256) not null
    , funding                   varchar(100)
);
create table if not exists department (
    id                          serial primary key
    , head_doctor_id            integer
    , hospital_id               integer references hospital(id)
    , dep_name                  varchar(100) not null
    , dep_funding               varchar(100)
);

create table if not exists employee (
    id                      serial primary key
    , first_nm              varchar(100)
    , last_nm               varchar(100)
    , personnel_no          integer check (personnel_no > 0 and personnel_no < 1000000)
    , phone_no              varchar(20) check (phone_no like '+5%' and length(phone_no) = 12)
);

create table if not exists patient (
    id                      serial primary key
    , hospital_id           integer
    , employee_id           integer references employee(id)
    , department_id         integer references department(id)
    , first_nm              varchar(100)
    , last_nm               varchar(100)
    , contact_no            varchar(20) check (contact_no like '+5%' and length(contact_no) = 12)
    , constraint patient_fkey foreign key (department_id) references department(id)
);

create table if not exists room (
    id                      serial primary key
    , department_id         integer
    , hospital_id           integer references hospital(id)
    , technician_id         integer
    , building_no           integer
    , place_type            varchar(100)
    , place_capacity        integer check (place_capacity > 0 and place_capacity < 4)
    , constraint room_fkey  foreign key (department_id) references department(id)
);


create table if not exists positions (
    id                      serial primary key
    , employee_id           integer
    , minimum_rate          integer check (minimum_rate > 100000 and minimum_rate < 2000000)
    , maximum_rate          integer check (maximum_rate > 400000 and maximum_rate < 6000000)
    , minimum_allowance     integer check (minimum_allowance > 200000 and minimum_allowance < 2000000)
    , maximum_allowance     integer check (maximum_allowance > 500000 and maximum_allowance < 6000000)
);

create table if not exists employee_at_position (
    id                      serial primary key
    , employee_id           integer
    , position_id           integer references positions(id)
    , Employment_share      varchar(100)
    , employment_date       timestamp
    , dismissal_date        timestamp
);

INSERT INTO hospital VALUES(Default, 16, 'Ken Sánchez', 'Berlin, Genslerstraße 84', 6578000000);
INSERT INTO hospital VALUES(Default, 17, 'Kevin Brown', 'Berlin, Genslerstraße 85', 235084);

INSERT INTO department VALUES(14, 17, 1, 'Accident and emergency (A&E)', 'Gov');
INSERT INTO department VALUES(15, 22, 2, 'Anaesthetics', 'Gov');
INSERT INTO department VALUES(16, 23, 2, 'Cardiology', 'Gov');
INSERT INTO department VALUES(17, 21, 2, 'Chaplaincy', 'City-Council');
INSERT INTO department VALUES(18, 20, 1, 'Critical care', 'V&D Med');
INSERT INTO department VALUES(19, 18, 2, 'Diagnostic imaging', 'City-Council');
INSERT INTO department VALUES(20, 19, 1, 'Discharge lounge', 'Gov');
INSERT INTO department VALUES(21, 24, 2, 'Ear nose and throat (ENT)','V&D Med');
INSERT INTO department VALUES(22, 26, 2, 'Elderly services', 'Healthy health');
INSERT INTO department VALUES(23, 25, 1, 'General surgery', 'Johns Hopkins');
INSERT INTO department VALUES(25, 27, 1, 'Microbiology', 'V&D Med') ;
INSERT INTO department VALUES(24, 20, 1, 'Neonatal unit', 'EU');
INSERT INTO department VALUES(26, 15, 1, 'Nephrology', 'EU');
INSERT INTO department VALUES(27, 16, 1, 'Neurology', 'Sobianin &co');


INSERT INTO employee VALUES(Default,  'Margie', 'Shoop', 431, '+56862993572');
INSERT INTO employee VALUES(Default,  'Rebecca', 'Laszlo', 432, '+57467266818');
INSERT INTO employee VALUES(Default,  'Annik','Stahl', 435, '+56486976356');
INSERT INTO employee VALUES(Default,  'Suchitra','Mohan', 433, '+53186261559');
INSERT INTO employee VALUES(Default, 'Brandon',' Heidepriem', 634, '+56773558858') ;
INSERT INTO employee VALUES(Default, 'Jose', 'Lugo', 477, '+55112267435');
INSERT INTO employee VALUES(Default, 'Chris', ' Okelberry',353, '+52923297147');
INSERT INTO employee VALUES(Default, 'Kim', 'Abercrombie',532, '+53796479295');
INSERT INTO employee VALUES(Default, 'Ed','Dudenhoefer',523, '+59791376232');
INSERT INTO employee VALUES(Default, 'JoLynn',' Dobney',989, '+54479215947');

INSERT INTO patient Values(Default, 1, 14, 23, 'Bryan',' Baker', '+59913142246');
INSERT INTO patient Values(Default, 2, 15, 20, 'James',' Kramer', '+55634725862');
INSERT INTO patient Values(Default, 2, 16, 18, 'Nancy',' Anderson', '+51675814531');
INSERT INTO patient Values(Default, 1, 17, 19, 'Simon',' Rapier', '+52568545144');
INSERT INTO patient Values(Default, 1, 11, 24, 'Thomas',' Michaels', '+56611334634');
INSERT INTO patient Values(Default, 2, 10, 21, 'Eugene',' Kogan', '+54566549125');
INSERT INTO patient Values(Default, 1, 9, 16, 'Andrew',' Hill', '+56451799154');
INSERT INTO patient Values(Default, 2, 8, 15, 'Ruth',' Ellerbrock','+51234567890');

INSERT INTO room VALUES(DEFAULT, 22, 1, 12, 11,  'Emergency', 1);
INSERT INTO room VALUES(DEFAULT, 20, 2, 14, 39,  'Casual', 2);
INSERT INTO room VALUES(DEFAULT, 21, 1, 12, 24,  'Casual', 2);
INSERT INTO room VALUES(DEFAULT, 18, 1, 12, 357, 'Casual', 2);
INSERT INTO room VALUES(DEFAULT, 19, 1, 15, 124, 'Elderly', 3);
INSERT INTO room VALUES(DEFAULT, 27, 1, 8,  33,  'Elderly', 3);
INSERT INTO room VALUES(DEFAULT, 15, 2, 13, 324, 'Casual', 2);
INSERT INTO room VALUES(DEFAULT, 14, 2, 11, 78,  'Surgery', 1);
INSERT INTO room VALUES(DEFAULT, 17, 2, 12, 324, 'Surgery', 1);
INSERT INTO room VALUES(DEFAULT, 25, 1, 12, 79,  'Surgery', 1);

INSERT INTO positions VALUES(DEFAULT, 8, 250000, 1330000, 690000, 1990000);
INSERT INTO positions VALUES(DEFAULT, 9, 990000, 1690000, 530000, 1730000);
INSERT INTO positions VALUES(DEFAULT, 10, 330000, 1640000, 250000, 1330000);
INSERT INTO positions VALUES(DEFAULT, 11, 730000, 1960000, 530000, 1730000);
INSERT INTO positions VALUES(DEFAULT, 12, 690000, 1990000, 990000, 1690000);
INSERT INTO positions VALUES(DEFAULT, 13, 960000, 1420000, 420000, 1420000);
INSERT INTO positions VALUES(DEFAULT, 14, 550000, 1530000, 250000, 1330000);
INSERT INTO positions VALUES(DEFAULT, 15, 530000, 1730000, 730000, 1960000);
INSERT INTO positions VALUES(DEFAULT, 16, 640000, 1690000, 250000, 1330000);
INSERT INTO positions VALUES(DEFAULT, 17, 420000, 1420000, 420000, 1420000);

INSERT INTO employee_at_position VALUES(DEFAULT, 1, 11, '12%', '2015-01-22', '2019-01-10');
INSERT INTO employee_at_position VALUES(DEFAULT, 2, 12, '1%', '2014-08-28', '2021-08-31');
INSERT INTO employee_at_position VALUES(DEFAULT, 3, 14, '0%', '2016-09-13', '2021-12-23');
INSERT INTO employee_at_position VALUES(DEFAULT, 4, 13, '5%', '2018-03-27', '2020-02-27');
INSERT INTO employee_at_position VALUES(DEFAULT, 5, 15, '6%', '2018-06-20', '2019-01-10');
INSERT INTO employee_at_position VALUES(DEFAULT, 6, 16, '7%', '2015-01-22', '2019-01-10');
INSERT INTO employee_at_position VALUES(DEFAULT, 7, 17, '0.6%','2018-08-20','2022-01-04');
INSERT INTO employee_at_position VALUES(DEFAULT, 8, 18, '3%', '2014-08-28', '2021-12-13');
INSERT INTO employee_at_position VALUES(DEFAULT, 9, 19, '3%', '2017-12-19', '2022-03-11');
INSERT INTO employee_at_position VALUES(DEFAULT,10, 20,'0.7%', '2018-06-20', '2019-01-10');

-- CRUD PART
SELECT * FROM patient WHERE id=9;
UPDATE patient SET contact_no='+56667997777' WHERE id=9;
DELETE FROM patient WHERE first_nm = 'Simon';
SELECT * FROM patient;

SELECT * FROM room WHERE place_type = 'Casual';
DELETE FROM room WHERE place_type = 'Emergency';
SELECT * FROM room;
UPDATE room SET place_type='Emergency' WHERE id=10;
SELECT * FROM room;
--

-- Semantic Queries
SELECT MIN(maximum_rate)
FROM positions
GROUP BY employee_id;

SELECT patient.last_nm
FROM patient
JOIN employee
  ON patient.last_nm = employee.first_nm
GROUP BY patient.last_nm;

-- getting the departments that Are funded by Government
SELECT dep_name FROM department
WHERE dep_funding = 'Gov';




CREATE VIEW v_hospital AS
  SELECT
    name, address
  FROM
    hospital;

CREATE VIEW v_dep AS
  SELECT
    dep_name,
    substring(dep_funding, 1, 4) || '****' || substring(dep_funding, 11, 8) AS fund_masked
  FROM
    department;

CREATE VIEW v_emp AS
  SELECT
    first_nm, last_nm,
    substring(phone_no, 1, 4) || '****' || substring(phone_no, 11, 8) AS phone_masked
  FROM
    employee;

CREATE VIEW v_patient AS
  SELECT
    first_nm, last_nm,
    substring(contact_no, 1, 4) || '****' || substring(contact_no, 11, 8) AS contact_masked
  FROM
    patient;

CREATE VIEW v_position AS
  SELECT
    maximum_allowance, maximum_rate, minimum_allowance, minimum_rate
  FROM
    positions;

CREATE VIEW v_room AS
  SELECT
    place_type, place_capacity, building_no
  FROM
    room;

CREATE VIEW v_emp_pos AS
  SELECT
        employment_date, dismissal_date
  FROM
    employee_at_position;



select * FROM employee
full outer join patient
on employee.first_nm = patient.first_nm;

CREATE or REPLACE VIEW complex_1 (emp_id,d_min_alow, d_max_allowance,count_max_alow,avg_max_rate,sum_max_alo)
AS SELECT employee_id,COUNT(DISTINCT minimum_allowance),
COUNT(DISTINCT maximum_allowance),COUNT(maximum_allowance),
AVG(maximum_rate), SUM(maximum_allowance)
FROM positions
GROUP BY employee_id;

select * FROM employee
full outer join patient
on employee.first_nm = patient.first_nm;
