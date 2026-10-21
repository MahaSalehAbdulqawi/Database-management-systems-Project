-- =========================================================
-- 5. Database Implementation in MySQL
-- Manufacturing Community Database System
-- SQL statements transcribed from the uploaded project PDF.
-- =========================================================


-- =========================================================
-- 5.1 Tables creation
-- =========================================================

-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
Dep_ID INT NOT NULL,
Dep_Name VARCHAR(40) NOT NULL,
Dep_Description VARCHAR(100) NOT NULL,
CONSTRAINT DEPARTMENT_PK PRIMARY KEY (Dep_ID)
);



-- Create MEMBER table
CREATE TABLE MEMBER (
Student_ID INT NOT NULL,
SSN VARCHAR(10) NOT NULL,
M_Phone_Number VARCHAR(10) NOT NULL,
M_FName VARCHAR(20) NOT NULL,
M_LName VARCHAR(20) NOT NULL,
Department VARCHAR(40) NOT NULL,
Position VARCHAR(30) NOT NULL,
Faculty VARCHAR(40) NOT NULL,
Major VARCHAR(40) NOT NULL,
Graduate_Year INT NOT NULL,
Gender VARCHAR(6) NOT NULL,
Assigned_Date DATE NOT NULL,
Dep_ID INT,
CONSTRAINT MEMBER_PK PRIMARY KEY (Student_ID),
CONSTRAINT MEMBER_SSN_UK UNIQUE (SSN),
CONSTRAINT MEMBER_DEPT_FK FOREIGN KEY (Dep_ID) REFERENCES DEPARTMENT (Dep_ID)
ON DELETE SET NULL
);



-- Create EVENT table
CREATE TABLE EVENT (
Event_ID INT NOT NULL,
Event_Name VARCHAR(50) NOT NULL,
Event_Place VARCHAR(50) NOT NULL,
Event_Date DATE NOT NULL,
CONSTRAINT EVENT_PK PRIMARY KEY (Event_ID)
);

-- Create ATTENDEE table
CREATE TABLE ATTENDEE (
Attendee_SSN VARCHAR(15) NOT NULL,
A_FName VARCHAR(20) NOT NULL,
A_LName VARCHAR(20) NOT NULL,
Attendee_Gender VARCHAR(10) NOT NULL,
Attendee_Email VARCHAR(50) NOT NULL,
A_Phone_Number VARCHAR(10) NOT NULL,
CONSTRAINT ATTENDEE_PK PRIMARY KEY (Attendee_SSN),
CONSTRAINT ATTENDEE_PHONE_UK UNIQUE (A_Phone_Number)
);

-- Create FEEDBACK table
CREATE TABLE FEEDBACK (
Feedback_ID INT NOT NULL,
Feedback_Name VARCHAR(50) NOT NULL,
Feedback_Type VARCHAR(30) NOT NULL,
Description VARCHAR(350) NOT NULL,
Student_ID INT,
Attendee_SSN VARCHAR(10),
CONSTRAINT FEEDBACK_PK PRIMARY KEY (Feedback_ID),
CONSTRAINT FEEDBACK_MEMBER_FK FOREIGN KEY (Student_ID) REFERENCES MEMBER (Student_ID)
ON DELETE SET NULL,
CONSTRAINT FEEDBACK_ATTENDEE_FK FOREIGN KEY (Attendee_SSN) REFERENCES ATTENDEE (Attendee_SSN)
ON DELETE SET NULL
);

-- Create PARTICIPATION table
CREATE TABLE PARTICIPATION (
Event_ID INT NOT NULL,
Student_ID INT NOT NULL,
Participation_Date DATE NOT NULL,
Member_Role VARCHAR(50) NOT NULL,
CONSTRAINT PARTICIPATION_PK PRIMARY KEY (Event_ID, Student_ID),
CONSTRAINT PARTICIPATION_EVENT_FK FOREIGN KEY (Event_ID) REFERENCES EVENT (Event_ID)
ON DELETE CASCADE,
CONSTRAINT PARTICIPATION_MEMBER_FK FOREIGN KEY (Student_ID) REFERENCES MEMBER (Student_ID)
ON DELETE CASCADE
);

-- Create SPONSOR table
CREATE TABLE SPONSOR (
Sponsor_ID INT NOT NULL,
Sponsor_Name VARCHAR(50) NOT NULL,
S_Phone_Number VARCHAR(10) NOT NULL,
CONSTRAINT SPONSOR_PK PRIMARY KEY (Sponsor_ID)
);

-- Create EVENT_SPONSOR table
CREATE TABLE EVENT_SPONSOR (
Event_ID INT NOT NULL,
Sponsor_ID INT NOT NULL,
CONSTRAINT EVENT_SPONSOR_PK PRIMARY KEY (Event_ID, Sponsor_ID),
CONSTRAINT EVENT_SPONSOR_EVENT_FK FOREIGN KEY (Event_ID) REFERENCES EVENT (Event_ID)
ON DELETE CASCADE,
    CONSTRAINT EVENT_SPONSOR_SPONSOR_FK FOREIGN KEY (Sponsor_ID) REFERENCES SPONSOR (Sponsor_ID)
        ON DELETE CASCADE
);

-- Create EVENT_ATTENDEE table
CREATE TABLE EVENT_ATTENDEE (
Event_ID INT NOT NULL,
Attendee_SSN VARCHAR(10) NOT NULL,
CONSTRAINT EVENT_ATTENDEE_PK PRIMARY KEY (Event_ID, Attendee_SSN),
CONSTRAINT EVENT_ATTENDEE_EVENT_FK FOREIGN KEY (Event_ID) REFERENCES EVENT (Event_ID)
ON DELETE CASCADE,
CONSTRAINT EVENT_ATTENDEE_ATTENDEE_FK FOREIGN KEY (Attendee_SSN) REFERENCES ATTENDEE (Attendee_SSN)
ON DELETE CASCADE
);

-- Create INSTRUCTOR table
CREATE TABLE INSTRUCTOR (
Instructor_ID INT NOT NULL,
Instructor_Full_Name VARCHAR(60) NOT NULL,
In_Phone_Number VARCHAR(10) NOT NULL,
Instructor_Email VARCHAR(50) NOT NULL,
CONSTRAINT INSTRUCTOR_PK PRIMARY KEY (Instructor_ID)
);

-- Create EVENT_INSTRUCTOR table
CREATE TABLE EVENT_INSTRUCTOR (
Event_ID INT NOT NULL,
Instructor_ID INT NOT NULL,
CONSTRAINT EVENT_INSTRUCTOR_PK PRIMARY KEY (Event_ID, Instructor_ID),
CONSTRAINT EVENT_INST_EVENT_FK FOREIGN KEY (Event_ID) REFERENCES EVENT (Event_ID)
ON DELETE CASCADE,
CONSTRAINT EVENT_INST_INSTRUCTOR_FK FOREIGN KEY (Instructor_ID) REFERENCES INSTRUCTOR (Instructor_ID)
ON DELETE CASCADE
);

-- Create INSTRUCTOR_ACC table
CREATE TABLE INSTRUCTOR_ACC (
Instructor_ID INT NOT NULL,
Social_Media_Acc VARCHAR(150) NOT NULL,
CONSTRAINT INSTRUCTOR_ACC_PK PRIMARY KEY (Instructor_ID, Social_Media_Acc),
CONSTRAINT INSTRUCTOR_ACC_FK FOREIGN KEY (Instructor_ID) REFERENCES INSTRUCTOR (Instructor_ID)
ON DELETE CASCADE
);

-- Create ANNOUNCEMENT table
CREATE TABLE ANNOUNCEMENT (
An_Name VARCHAR(100) NOT NULL,
An_Date DATE NOT NULL,
An_Time TIME NOT NULL,
Event_ID INT,
CONSTRAINT ANNOUNCEMENT_PK PRIMARY KEY (An_Name),
CONSTRAINT ANNOUNCEMENT_EVENT_FK FOREIGN KEY (Event_ID) REFERENCES EVENT (Event_ID)
ON DELETE SET NULL
);

-- Create MEMBER_EMAIL table
CREATE TABLE MEMBER_EMAIL (
Student_ID INT NOT NULL,
Member_Email VARCHAR(50) NOT NULL,
CONSTRAINT MEMBER_EMAIL_PK PRIMARY KEY (Student_ID, Member_Email),
CONSTRAINT MEMBER_EMAIL_FK FOREIGN KEY (Student_ID) REFERENCES MEMBER (Student_ID)
ON DELETE CASCADE
);

-- Create MEMBER_ACHIEVEMENT table
CREATE TABLE MEMBER_ACHIEVEMENT (
Student_ID INT NOT NULL,
Ach_No INT NOT NULL,
Ach_Date DATE NOT NULL,
Ach_Desc VARCHAR(150) NOT NULL,
CONSTRAINT MEMBER_ACHIEVEMENT_PK PRIMARY KEY (Student_ID, Ach_No, Ach_Date, Ach_Desc),
CONSTRAINT MEMBER_ACHIEVE_MEMBER_FK FOREIGN KEY (Student_ID) REFERENCES MEMBER (Student_ID)
ON DELETE CASCADE
);

-- Create DEPARTMENT_EVENT table
CREATE TABLE DEPARTMENT_EVENT (
Event_ID INT NOT NULL,
Dep_ID INT NOT NULL,
CONSTRAINT DEPARTMENT_EVENT_PK PRIMARY KEY (Event_ID, Dep_ID),
CONSTRAINT DEPT_EVENT_EVENT_FK FOREIGN KEY (Event_ID) REFERENCES EVENT (Event_ID)
ON DELETE CASCADE,
CONSTRAINT DEPT_EVENT_DEPT_FK FOREIGN KEY (Dep_ID) REFERENCES DEPARTMENT (Dep_ID)
ON DELETE CASCADE
);

-- Create DEPARTMENT_ACHIEVEMENT table
CREATE TABLE DEPARTMENT_ACHIEVEMENT (
A_No INT NOT NULL,
A_Date DATE NOT NULL,
A_Desc VARCHAR(150) NOT NULL,
Dep_ID INT NOT NULL,
CONSTRAINT DEPT_ACHIEVE_PK PRIMARY KEY (A_No, A_Date, A_Desc, Dep_ID),
CONSTRAINT DEPT_ACHIEVE_FK FOREIGN KEY (Dep_ID) REFERENCES DEPARTMENT (Dep_ID)
ON DELETE CASCADE
);


-- =========================================================
-- 5.2 Insert into Tables
-- =========================================================

-- Insert into DEPARTMENT Table
INSERT INTO DEPARTMENT (Dep_ID, Dep_Name, Dep_Description) VALUES
(1, 'Human Resources', 'Responsible for internal members and organizing member affairs'),
(2, 'Operation', 'Responsible for planning and managing events inside and outside the club'),
(3, 'Marketing', 'Responsible for advertisements and the external image of the club'),
(4, 'Financial Management', 'Responsible for the club budget, expenses, income, and invoice management'),
(5, 'Public Relations', 'Responsible for communicating with sponsors and speakers and searching for event venues');

-- Insert into MEMBER Table
INSERT INTO MEMBER
(Student_ID, SSN, M_Phone_Number, M_FName, M_LName, Department, Position, Faculty, Major, Graduate_Year, Gender, Assigned_Date, Dep_ID)
VALUES
(2300011, '1234567890', '0501112223', 'Ahmed', 'Khaled', 'Operation', 'Member', 'Since', 'Math', 2026, 'Male', '2024-09-01', 2),
(2300012, '2345678901', '0501112224', 'Sara', 'Omar', 'Human Resources', 'Member', 'Engineering', 'Electrical Engineering', 2027, 'Female', '2024-09-01', 1),
(2300013, '3456789012', '0501112225', 'Yousef', 'Ali', 'Marketing', 'Member', 'Engineering', 'Computer Engineering', 2025, 'Male', '2024-09-01', 3),
(2300014, '1029384760', '0501234570', 'Noura', 'Hassan', 'Public Relations', 'Designer', 'Computing', 'Computer Science', 2028, 'Female', '2025-01-18', 5),
(2200015, '1029384761', '0501234571', 'Yousef', 'Khaled', 'Operation', 'Content Writer', 'Business', 'Marketing', 2027, 'Male', '2025-01-20', 2);

-- Insert into ATTENDEE Table
INSERT INTO ATTENDEE
(Attendee_SSN, A_FName, A_LName, Attendee_Gender, Attendee_Email, A_Phone_Number)
VALUES
('1276543210', 'Noura', 'Hassan', 'Female', 'noura@gmail.com', '0552003001'),
('1165432109', 'Khalil', 'Mansour', 'Male', 'khalil@gmail.com', '0552003002'),
('2011223346', 'Dana', 'Ahmed', 'Female', 'dana@gmail.com', '0551112235'),
('2011223348', 'Reem', 'Hadi', 'Female', 'reem@gmail.com', '0551112237'),
('2011223347', 'Abdulrahman', 'Saad', 'Male', 'abdulrahman@gmail.com', '0551112236');

-- Insert into EVENT Table
INSERT INTO EVENT (Event_ID, Event_Name, Event_Place, Event_Date) VALUES
(101, 'AI Workshop', 'Faculty of Computing Hall', '2026-05-10'),
(102, 'Cybersecurity Bootcamp', 'Building 31', '2026-06-20'),
(103, 'Industrial Engineering Seminar', 'King Faisal Conference Center', '2026-06-15'),
(104, 'Manufacturing Basics Workshop', 'Campus - Hall A', '2026-05-20'),
(105, 'Innovation & Entrepreneurship Night', 'Innovation Center', '2026-06-10');

-- Insert into PARTICIPATION Table
INSERT INTO PARTICIPATION (Event_ID, Student_ID, Participation_Date, Member_Role) VALUES
(104, 2300011, '2026-05-20', 'Orgnaizer'),
(104, 2300014, '2026/05/21', 'Volunteer'),
(105, 2300011, '2026-06-10', 'Volunteer'),
(103, 2300013, '2026-06-15', 'Photographer'),
(103, 2300012, '2026-06-15', 'Volunteer'),
(102, 2300011, '2026-06-20', 'Orgnaizer'),
(101, 2200015, '2026-05-10', 'Volunteer'),
(101, 2300012, '2026-05-10', 'Photographer');

-- Insert into EVENT_ATTENDEE Table
INSERT INTO EVENT_ATTENDEE (Event_ID, Attendee_SSN) VALUES
(101, '2011223346'),
(102, '2011223348'),
(103, '2011223347'),
(103, '1165432109'),
(104, '2011223346'),
(105, '1276543210'),
(105, '1165432109'),
(105, '2011223346');

-- Insert into INSTRUCTOR Table
INSERT INTO INSTRUCTOR (Instructor_ID, In_Phone_Number, Instructor_Email, Instructor_Full_Name) VALUES
(3001, '0502001111', 'dr.ahmad@kau.edu.sa', 'Dr. Ahmad Al-Shehri'),
(3002, '0502002222', 'sara@kau.edu.sa', 'Sara Al-Qahtani'),
(3003, '0502003333', 'eng.khaled@kau.edu.sa', 'Eng. Khaled Al-Harbi'),
(3004, '0502004444', 'dr.noura@kau.edu.sa', 'Dr. Noura Al-Zahrani'),
(3005, '0502005555', 'faisal@kau.edu.sa', 'Faisal Al-Otaibi');

-- Insert into EVENT_INSTRUCTOR Table
INSERT INTO EVENT_INSTRUCTOR (Event_ID, Instructor_ID) VALUES
(101, 3005),
(101, 3003),
(102, 3004),
(102, 3003),
(103, 3001),
(103, 3002),
(104, 3002),
(104, 3001);

-- Insert into INSTRUCTOR_ACC Table
INSERT INTO INSTRUCTOR_ACC (Instructor_ID, Social_Media_Acc) VALUES
(3001, 'https://twitter.com/inst1'),
(3001, 'https://linkedin.com/in/inst1'),
(3002, 'https://twitter.com/inst2'),
(3003, 'https://twitter.com/inst3'),
(3003, 'https://linkedin.com/in/inst3'),
(3004, 'https://twitter.com/inst4'),
(3004, 'https://instagram.com/inst4'),
(3005, 'https://twitter.com/inst5');

-- Insert into SPONSOR Table
INSERT INTO SPONSOR (Sponsor_ID, Sponsor_Name, S_Phone_Number) VALUES
(4001, 'TechNova', '0558009001'),
(4002, 'BuildPro', '0558009002'),
(4003, 'SmartSolutions', '0558009003'),
(4004, 'FutureTech', '0558009004'),
(4005, 'EduPartners', '0558009005');

-- Insert into EVENT_SPONSOR Table
INSERT INTO EVENT_SPONSOR (Event_ID, Sponsor_ID) VALUES
(101, 4001),
(101, 4002),
(102, 4001),
(102, 4003),
(103, 4002),
(103, 4004),
(104, 4003),
(105, 4005);

-- Insert into ANNOUNCEMENT Table
INSERT INTO ANNOUNCEMENT (An_Name, An_Date, An_Time, Event_ID) VALUES
('Workshop Opening', '2026-05-18', '18:00:00', 101),
('Registration Reminder', '2026-05-19', '20:00:00', 101),
('Keynote Start', '2026-06-08', '19:30:00', 102),
('Cybersecurity Update', '2026-05-21', '17:00:00', 103),
('Leadership Event Announcement', '2026-05-24', '16:30:00', 104);

-- Insert into MEMBER_EMAIL Table
INSERT INTO MEMBER_EMAIL (Student_ID, Member_Email) VALUES
(2300011, 'ahmed.kh@gmail.com'),
(2300011, 'ahmed.m@kau.edu.sa'),
(2300012, 'sara.omar@kau.edu.sa'),
(2300013, 'yousef.ali@yahoo.com'),
(2300013, 'yousef.ali@kau.edu.sa'),
(2300014, 'noura.hassan@gmail.com'),
(2300014, 'noura.hassan@kau.edu.sa'),
(2200015, 'yousef.khaled@gmail.com');

-- Insert into MEMBER_ACHIEVEMENT Table
INSERT INTO MEMBER_ACHIEVEMENT (Student_ID, Ach_No, Ach_Date, Ach_Desc) VALUES
(2300011, 1, '2026-05-10', 'Best Organizer Award'),
(2300011, 2, '2026-05-15', 'Outstanding Participation'),
(2300012, 1, '2026-05-12', 'Excellent Team Work'),
(2300011, 3, '2026-05-18', 'Top Speaker Award'),
(2300013, 1, '2026-05-20', 'Event Contribution Recognition'),
(2300014, 1, '2026-05-22', 'Design Excellence Award'),
(2200015, 1, '2026-05-25', 'Leadership Recognition'),
(2200015, 2, '2026-05-28', 'Active Member Award');

-- Insert into DEPARTMENT_EVENT Table
INSERT INTO DEPARTMENT_EVENT (Event_ID, Dep_ID) VALUES
(101, 1),
(101, 2),
(102, 2),
(102, 3),
(103, 3),
(103, 4),
(104, 4),
(105, 2);

-- Insert into DEPARTMENT_ACHIEVEMENT Table
INSERT INTO DEPARTMENT_ACHIEVEMENT (A_No, A_Date, A_Desc, Dep_ID) VALUES
(1, '2026-05-10', 'Best Event Organization Award', 1),
(1, '2026-05-10', 'Best Event Organization Award', 2),
(2, '2026-05-12', 'Outstanding HR Performance', 2),
(1, '2026-05-12', 'Outstanding HR Performance', 3),
(2, '2026-05-15', 'Technical Excellence in Events', 3),
(3, '2026-05-15', 'Technical Excellence in Events', 4),
(5, '2026-05-18', 'Best Event Execution Award', 4),
(1, '2026-05-20', 'Top Communication and Outreach', 5);

-- Insert into FEEDBACK Table
INSERT INTO FEEDBACK (Feedback_ID, Feedback_Name, Feedback_Type, Description, Student_ID, Attendee_SSN) VALUES
(1, 'Event Organization Issue', 'Complaint', 'Time delay in starting the event', 2300011, NULL),
(2, 'Great Experience', 'Positive', 'Very well organized and informative event', NULL, '2011223347'),
(3, 'Suggestion for Improvement', 'Suggestion', 'Need more seating areas in events', NULL, '1276543210'),
(4, 'Technical Problem', 'Complaint', 'Sound system was not clear during workshop', 2300013, NULL),
(5, 'Excellent Event', 'Positive', 'Loved the cybersecurity workshop content', NULL, '2011223348');


-- =========================================================
-- 5.3 Table Modification
-- =========================================================

-- Applying a modification to add a default value
ALTER TABLE PARTICIPATION
MODIFY Participation_Date DATE DEFAULT (CURRENT_DATE);


-- =========================================================
-- 6. Querying in MySQL
-- 6.1 SQL Reports
-- =========================================================

-- Report 1: Events with Highest Attendance
-- The project manager within operation team needs this report to identify
-- the events that attracted the largest number of attendees.
SELECT EVENT.Event_ID, EVENT.Event_Name,
COUNT(EVENT_ATTENDEE.Attendee_SSN) AS Total_Attendees
FROM EVENT
JOIN EVENT_ATTENDEE
ON EVENT.Event_ID = EVENT_ATTENDEE.Event_ID
GROUP BY EVENT.Event_ID, EVENT.Event_Name
ORDER BY Total_Attendees DESC;

-- Report 2: Total Members per Department Report
-- Shows the population of each department by counting assigned students.
SELECT Dep_Name, COUNT(Student_ID) AS Total_Members
FROM DEPARTMENT
INNER JOIN MEMBER ON DEPARTMENT.Dep_ID = MEMBER.Dep_ID
GROUP BY Dep_Name
ORDER BY Total_Members DESC;

-- Report 3: Events held in June
-- The Operations Team uses this report to analyze events held in June.
SELECT Event_Name, Event_Date FROM EVENT
WHERE Event_Date BETWEEN '2026-06-01' AND '2026-06-30'
ORDER BY Event_Date;

-- Report 4: Instructor Contact List
-- Instructor contacts ordered alphabetically by instructor name.
SELECT Instructor_Full_Name, Instructor_Email, In_Phone_Number
FROM INSTRUCTOR
ORDER BY Instructor_Full_Name;

-- Report 5: Awards for Best Department Based on Achievements
-- Evaluates department performance based on achievements.
SELECT Dep_Name, COUNT(A_No) AS Total_Achievements
FROM DEPARTMENT D
JOIN DEPARTMENT_ACHIEVEMENT DA
    ON D.Dep_ID = DA.Dep_ID
GROUP BY Dep_Name
ORDER BY Total_Achievements DESC;

-- Report 6: Feedback Review and handling Complaints
-- Helps the HR team review complaints and identify urgent issues.
SELECT Feedback_ID, Feedback_Name, Feedback_Type, Description
FROM FEEDBACK
WHERE Feedback_Type = 'Complaint'
ORDER BY Feedback_ID DESC;

-- Report 7: Member Participation Performance
-- Evaluates member engagement in events.
SELECT CONCAT(MEMBER.M_FName, ' ', MEMBER.M_LName) AS Member_Name,
COUNT(P.Event_ID) AS Total_Participations,
(COUNT(P.Event_ID) * 100.0 / (SELECT COUNT(*) FROM EVENT)) AS Participation_Percentage
FROM MEMBER
JOIN PARTICIPATION P
ON MEMBER.Student_ID = P.Student_ID
GROUP BY MEMBER.Student_ID, MEMBER.M_FName, MEMBER.M_LName, MEMBER.Department
ORDER BY Participation_Percentage DESC;


-- =========================================================
-- 6.2 SQL Data Removal Statement
-- Delete a sponsor and all their event associations
-- =========================================================

DELETE FROM SPONSOR
WHERE Sponsor_ID = 4001;

SELECT * FROM SPONSOR;
SELECT * FROM EVENT_SPONSER;
