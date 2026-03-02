# University Exam Result Management System - Setup Guide

## Prerequisites

- Node.js installed
- MySQL Server installed and running

## 1. Database Setup

1. Open your MySQL client (e.g., MySQL Workbench, phpMyAdmin).
2. Execute the queries in `database/schema.sql`.

## 2. Backend Setup

1. Navigate to the `backend` folder:
   ```bash
   cd backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Configure `.env`:
   - Open `.env` and verify your DB credentials.
4. Seed the database (Creates Supervisor account):
   ```bash
   node seed.js
   ```
5. Start the server:
   ```bash
   npm start
   ```
   _The server will run on http://localhost:5000_

## 3. Frontend Setup

1. Navigate to the `frontend` folder:
   ```bash
   cd frontend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the dev server:
   ```bash
   npm run dev
   ```
   _The app will run on http://localhost:5173 (check vite output)_

## Sample Users

- **Supervisor**: `supervisor` / `supervisor123`
- **Admin**: Create via Supervisor dashboard.
- **Student**: Create via Admin dashboard.

## Features

- **JWT Auth**: Secured endpoints.
- **First Login**: Compulsory password change.
- **Faculty Security**: Admins need an Access Key to proceed.
- **Profile Photo**: Students can upload their own photo.
"# Exam-Result-Management" 
