-- 1
CREATE TABLE IF NOT EXISTS school(
	school_id SERIAL PRIMARY KEY,
	school_name TEXT NOT NULL,
	address TEXT,
	phone_number CHAR (15),
	davlat_maktabi BOOL
	
);
INSERT INTO school(school_name,address,phone_number,davlat_maktabi) VALUES
 ('Toshkent Davlat Maktabi', 'Toshkent shahri, Yashnobod tuman, Mustaqillik ko''chasi 5-uy', '998901234567', TRUE),
 ('Mirzo Ulug''bek Maktabi', 'Toshkent shahri, Mirzo Ulug''bek tumani, Ulug''bek ko''chasi 7-uy', '998901987654', TRUE),
 ('Zarafshon Xususiy Maktabi', 'Zarafshon shahridagi 12-uy', '998937654321', FALSE);

 SELECT * FROM school
----------------------------------------------------------------
-- 2
CREATE TABLE IF NOT EXISTS teachers(
	teachers_id SERIAL PRIMARY KEY ,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number CHAR(15),  
    school_id INT,  
    FOREIGN KEY (school_id) REFERENCES school(school_id)
);
INSERT INTO teachers (first_name, last_name, email, phone_number, school_id) 
VALUES 
    ('Toxir', 'Toxirov', 'toxirToxirov@gmail.com', '+998901234567', 1),
    ('Sobir', 'Sobirov', 'sobirSobirov@gmail.com', '+998937654321', 2),
	('Jalil', 'Jalilov', 'jalilJalilov@gmail.com', '+998937654321', 3);
SELECT teachers_id,first_name,last_name,email,phone_number,school_id FROM teachers;
JOIN school ON teachers.school_id = school.school_id;
------------------------------------------------------------------------------
-- 3
CREATE TABLE IF NOT EXISTS students (
    students_id SERIAL PRIMARY KEY ,  
    first_name VARCHAR(100) NOT NULL,    
    last_name VARCHAR(100) NOT NULL,     
    date_of_birth DATE,                 
    gender CHAR(1),                      
    school_id INT,                     
    FOREIGN KEY (school_id) REFERENCES school(school_id)  
);
INSERT INTO students (first_name, last_name, date_of_birth, gender, school_id) 
VALUES 
    ('Toxir', 'Sobirov', '2008-03-12', 'M', 1),
    ('sobir', 'Toxirov', '2009-05-24', 'M', 2);

SELECT students.students_id,
       students.first_name,
       students.last_name,
       students.date_of_birth,
       students.gender,
       students.school_id,
       school.name AS school_name
JOIN school ON students.school_id = school.school_id;
------------------------------------------------------------------------------
-- 4
CREATE TABLE IF NOT EXISTS sinf (
    class_id SERIAL PRIMARY KEY,       
    class_name VARCHAR(100) NOT NULL,   
    teacher_id INT,              
    school_id INT,                
    FOREIGN KEY (teacher_id) REFERENCES teachers(teachers_id) ON DELETE CASCADE, 
    FOREIGN KEY (school_id) REFERENCES school(school_id) ON DELETE CASCADE  
);

INSERT INTO sinf (class_name, teacher_id, school_id) 
VALUES 
    ('9-A', 1, 1),    
    ('10-B', 2, 2); 
   
SELECT sinf.class_id, sinf.class_name AS class_name, 
       teachers.first_name , teachers.last_name AS firs_name, 
       school.school_name AS school_name
FROM sinf
JOIN teachers ON sinf.teacher_id = teachers.teachers_id
JOIN school ON sinf.school_id = school.school_id;
------------------------------------------------------------------------------
-- 5
CREATE TABLE IF NOT EXISTS subject (
    subject_id SERIAL PRIMARY KEY,        
    subject_name VARCHAR(100) NOT NULL,   
    class_id INT,                 
    teacher_id INT,               
    FOREIGN KEY (class_id) REFERENCES sinf(class_id) ON DELETE CASCADE,  
    FOREIGN KEY (teacher_id) REFERENCES teachers(teachers_id) ON DELETE CASCADE  
);

INSERT INTO subject (subject_name, class_id, teacher_id) 
VALUES 
    ('Matematika', 1, 1),  
    ('Fizika', 2, 2);
	
SELECT subject.subject_id, 
       subject.subject_name AS subject_name, 
       sinf.class_name, 
       teachers.first_name , teachers.last_name AS teacher_name
FROM subject
JOIN sinf ON subject.class_id = sinf.class_id
JOIN teachers ON subject.teacher_id = teachers.teachers_id;
------------------------------------------------------------------------------
-- 6
CREATE TABLE IF NOT EXISTS enrollment (
    enrollment_id SERIAL PRIMARY KEY,           
    student_id INT,                 
    class_id INT,                    
    enrollment_date DATE DEFAULT CURRENT_DATE,  
    FOREIGN KEY (student_id) REFERENCES students(students_id) ON DELETE CASCADE,  
    FOREIGN KEY (class_id) REFERENCES sinf(class_id) ON DELETE CASCADE  
);
INSERT INTO enrollment (student_id, class_id)
VALUES 
    (1, 1),   
    (2, 2);  
SELECT enrollment.enrollment_id, 
       students.first_name , students.last_name AS student_name, 
       sinf.class_name, 
       enrollment.enrollment_date
FROM enrollment
JOIN students ON enrollment.student_id = students.students_id
JOIN sinf ON enrollment.class_id = sinf.class_id;
------------------------------------------------------------------------------
-- 7
CREATE TABLE IF NOT EXISTS grade (
    grade_id SERIAL PRIMARY KEY,               
    student_id INT,                    
    subject_id INT,                      
    grade_value INT CHECK (grade_value >= 1 AND grade_value <= 5), 
    date_given DATE DEFAULT CURRENT_DATE, 
    FOREIGN KEY (student_id) REFERENCES students(students_id) ON DELETE CASCADE, 
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id) ON DELETE CASCADE   
);
INSERT INTO grade (student_id, subject_id, grade_value)
VALUES 
    (1, 1, 5),  
    (2, 2, 4); 
SELECT grade.grade_id, 
       students.first_name , students.last_name AS student_name, 
       subject.subject_name AS subject_name, 
       grade.grade_value, 
       grade.date_given
FROM grade
JOIN students ON grade.student_id = students.students_id
JOIN subject ON grade.subject_id = subject.subject_id;

------------------------------------------------------------------------------
-- 8
CREATE TABLE IF NOT EXISTS attendance (
    id SERIAL PRIMARY KEY,               
    student_id INT,                      
    class_id INT,                       
    date DATE DEFAULT CURRENT_DATE,      
    FOREIGN KEY (student_id) REFERENCES students(students_id) ON DELETE CASCADE, 
    FOREIGN KEY (class_id) REFERENCES sinf(class_id) ON DELETE CASCADE   
);
INSERT INTO attendance (student_id, class_id)
VALUES 
    (1, 1),   
    (2, 2);   

SELECT attendance.id, 
       students.first_name , students.last_name AS student_name, 
       sinf.class_name, 
       attendance.date
FROM attendance
JOIN students ON attendance.student_id = students.students_id
JOIN sinf ON attendance.class_id = sinf.class_id;























