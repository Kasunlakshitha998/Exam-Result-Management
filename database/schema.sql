-- University Exam Result Management System - Database Schema

CREATE DATABASE IF NOT EXISTS exam_management;
USE exam_management;

-- 1. Faculties Table
CREATE TABLE IF NOT EXISTS faculties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- 2. Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('SUPERVISOR', 'ADMIN', 'STUDENT') NOT NULL,
    facultyId INT,
    isFirstLogin BOOLEAN DEFAULT TRUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (facultyId) REFERENCES faculties(id) ON DELETE SET NULL
);

-- 3. Courses Table
CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    facultyId INT NOT NULL,
    FOREIGN KEY (facultyId) REFERENCES faculties(id) ON DELETE CASCADE
);

-- 4. Students Table
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL UNIQUE,
    fullName VARCHAR(255) NOT NULL,
    studentNumber VARCHAR(50) NOT NULL UNIQUE,
    academicYear VARCHAR(20) NOT NULL,
    courseId INT NOT NULL,
    photoUrl VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (courseId) REFERENCES courses(id) ON DELETE CASCADE
);

-- 5. Subjects Table
CREATE TABLE IF NOT EXISTS subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subjectCode VARCHAR(20) NOT NULL UNIQUE,
    subjectName VARCHAR(255) NOT NULL,
    level INT NOT NULL CHECK (level BETWEEN 1 AND 4),
    courseId INT NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id) ON DELETE CASCADE
);

-- 6. Results Table
CREATE TABLE IF NOT EXISTS results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    studentId INT NOT NULL,
    subjectId INT NOT NULL,
    marks DECIMAL(5, 2) NOT NULL,
    grade VARCHAR(5) NOT NULL,
    gpa DECIMAL(3, 2) NOT NULL,
    FOREIGN KEY (studentId) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (subjectId) REFERENCES subjects(id) ON DELETE CASCADE,
    UNIQUE KEY (studentId, subjectId)
);

-- 7. Access Keys Table
CREATE TABLE IF NOT EXISTS access_keys (
    id INT AUTO_INCREMENT PRIMARY KEY,
    keyValue VARCHAR(100) NOT NULL UNIQUE,
    facultyId INT NOT NULL,
    createdBySupervisorId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    isUsed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (facultyId) REFERENCES faculties(id) ON DELETE CASCADE,
    FOREIGN KEY (createdBySupervisorId) REFERENCES users(id) ON DELETE CASCADE
);

-- Sample Data Insertion Queries

-- Insert Initial Faculties
INSERT INTO faculties (name) VALUES ('Science'), ('Computing'), ('Medicine'), ('Humanities');

-- Insert Initial Supervisor (Password: supervisor123 - hashed version should be used in practice)
-- Note: 'isFirstLogin' is FALSE for Supervisor
-- Using a dummy hash for now: $2b$10$YourHashedPasswordHere (I will generate real one in backend setup)
INSERT INTO users (username, password, role, facultyId, isFirstLogin) 
VALUES ('supervisor', '$2b$10$6uPjL.4XfBf6tG5G9.U.U.oJzK/QWp.O1Z2uP3zV.B1Z2uP3zV.B1', 'SUPERVISOR', NULL, FALSE);
