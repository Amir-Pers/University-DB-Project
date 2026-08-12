# University DB Project

A full-stack vehicle marketplace web application developed as a university database project, inspired by the core concepts of [Bama.ir](https://bama.ir).

The project combines relational database design with a Django-based backend to provide a practical vehicle marketplace where users can browse advertisements, publish their own listings, manage their accounts, and save advertisements as favorites.

> **Live Demo:** http://carino24.ir/

**Project Type:** University Database Project
**Backend:** Django
**Database:** PostgreSQL
**Architecture:** Relational Database + Django Web Application

---

## 🌐 Live Demo

The project has been deployed and is currently available online:

**http://carino24.ir/**

The deployed application is called **Carino 24** and provides a platform for buying and selling cars and motorcycles.

---

## 📌 Overview

The main goal of this project is to design and implement a relational database for a vehicle marketplace and integrate it with a Django web application.

The project was developed in multiple phases:

### 1. Database Design

* Entity-Relationship Diagram
* Relational schema
* Primary and foreign keys
* Constraints and indexes
* Database normalization

### 2. SQL Implementation

* Database schema creation
* Table creation
* Sample data
* Constraints and indexes
* Stored procedures
* Incremental schema modifications

### 3. Django Backend

* PostgreSQL database integration
* User accounts
* Advertisement management
* Vehicle management
* Image management
* Address and location management
* AJAX endpoints
* Favorites

### 4. Frontend Integration

* Dynamic vehicle selection
* Advertisement filtering
* User dashboard
* Advertisement details
* Favorite management
* Responsive web interface

### 5. Deployment

The application has been deployed and is available as a live web application at:

**http://carino24.ir/**

---

## ✨ Features

### 👤 User Accounts

* User registration and authentication
* User profile management
* Account status management
* Phone number and national ID
* Default address
* Integration with Django's built-in authentication system

The project uses Django's authentication system for login and authentication while maintaining a separate application-level `User` entity in the relational database.

---

### 🚗 Vehicle Management

The database separates general vehicle information from vehicle-specific information.

The main vehicle hierarchy is:

```text
Brand
 └── Model
      └── Vehicle
           ├── Car
           ├── Motorcycle
           └── HeavyVehicle
```

A `Vehicle` contains information such as:

* Model
* Production year
* Exterior color
* Interior color
* Transmission type
* Fuel type
* Fuel consumption

Vehicle-specific information is stored in separate tables.

For example:

```text
Vehicle
   │
   ├── Car
   └── Motorcycle
```

When a new vehicle is required while publishing an advertisement, the backend checks whether an equivalent vehicle already exists. If not, it creates the vehicle and its corresponding subtype record.

This prevents unnecessary duplication of vehicle records while keeping the database normalized.

---

### 📢 Advertisement Management

Users can:

* Create advertisements
* Edit advertisements
* Delete advertisements
* Activate/deactivate advertisements
* Upload multiple images
* Specify vehicle information
* Specify price and selling method
* Add descriptions
* Specify vehicle condition
* Specify mileage
* Specify body condition
* Specify advertisement location

Supported selling methods include:

* نقدی
* اقساطی
* حواله
* توافقی

Advertisement-related information is stored separately from vehicle information so that vehicle data and marketplace data are not unnecessarily mixed.

---

### 🔎 Advertisement Search & Filtering

The home page provides filtering capabilities for advertisements.

Available filters include:

* Text search
* Vehicle type
* Brand
* Model
* Minimum price
* Maximum price

Brand and model selection is dynamically loaded using AJAX.

The available brands depend on the selected vehicle category, and models are loaded according to the selected brand.

---

### ❤️ Favorites

Authenticated users can save advertisements to their favorites.

The favorites system supports:

* Adding an advertisement to favorites
* Removing an advertisement from favorites
* Preventing duplicate favorites
* Displaying saved advertisements in the user profile
* Removing favorites without refreshing the page using AJAX

The database enforces uniqueness for each:

```text
User + Advertisement
```

combination.

---

### 🖼️ Advertisement Images

Advertisements can contain multiple images.

Images are stored separately from the `Advertisement` table, allowing each advertisement to have an arbitrary number of uploaded images.

The application also handles image deletion when an advertisement is removed.

---

### 📍 Locations

The location system is structured hierarchically:

```text
Province
   └── City
        └── Address
```

Users can specify a default address and advertisements can be associated with an address.

---

## 🗃️ Database Design

The project uses **PostgreSQL** as its relational database management system.

The database design makes use of:

* Primary Keys
* Foreign Keys
* One-to-One relationships
* One-to-Many relationships
* Unique constraints
* Check constraints
* Indexes
* Cascading deletes
* Stored procedures/functions
* Database migrations

Some of the main entities include:

```text
User
Brand
Model
Vehicle
Car
Motorcycle
HeavyVehicle
Advertisement
Image
Address
Province
City
Favorite
Instalment
Remittance
```

The complete database design and SQL scripts are available in the repository.

---

## 🧩 Project Structure

```text
University-DB-Project/
│
├── accounts/
│   ├── models.py
│   ├── views.py
│   ├── utils.py
│   └── ...
│
├── advertisements/
│   ├── models.py
│   ├── views.py
│   ├── utils.py
│   └── ...
│
├── core/
│   ├── settings.py
│   ├── urls.py
│   └── ...
│
├── home/
│   ├── views.py
│   └── ...
│
├── locations/
│   ├── models.py
│   ├── views.py
│   └── ...
│
├── vehicles/
│   ├── models.py
│   ├── views.py
│   └── ...
│
├── templates/
│
├── static/
│
├── media/
│
├── phase1_er_diagram/
│   ├── project.vpp
│   └── ER diagram image
│
├── phase2_sql_scripts/
│   ├── ...
│   └── ...
│
├── manage.py
├── requirements.txt
├── LICENSE
└── README.md
```

---

## 🛠️ Technologies

### Backend

* Python
* Django 5.2.6

### Database

* PostgreSQL
* Django ORM
* Django Migrations
* PostgreSQL SQL scripts

### Frontend

* HTML
* CSS
* JavaScript
* AJAX / Fetch API
* Django Templates

### Other

* Pillow for image handling
* Django Authentication

The exact Python dependencies are listed in `requirements.txt`.

---

## ⚙️ Installation

### 1. Clone the repository

```bash
git clone https://github.com/Amir-Pers/University-DB-Project.git

cd University-DB-Project
```

### 2. Create a virtual environment

#### Windows

```bash
python -m venv venv
venv\Scripts\activate
```

#### Linux / macOS

```bash
python3 -m venv venv
source venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

---

## 🗄️ Database Setup

The project uses **PostgreSQL**.

Before running the application, make sure PostgreSQL is installed and a PostgreSQL database/user are available.

Configure the database connection in:

```text
core/settings.py
```

or using the environment variables expected by your project configuration.

### Important: Run Migrations First

The database schema must first be created using Django migrations.

Run:

```bash
python manage.py migrate
```

After the migrations have been successfully applied, execute the SQL scripts inside:

```text
phase2_sql_scripts/
```

**The SQL scripts must be executed in their intended numerical order.**

For example:

```text
01_...
02_...
03_...
...
```

The correct order is important because some scripts depend on database objects and data created by previous scripts.

### Database Initialization Order

```text
1. Install PostgreSQL
        ↓
2. Configure database connection
        ↓
3. Run Django migrations
        ↓
4. Execute SQL scripts in order
        ↓
5. Run the Django application
```

> **Note:** Unlike the previous SQL Server version of the project, the database itself is no longer created through the SQL scripts. PostgreSQL and Django migrations are responsible for establishing the required database schema before the additional SQL scripts are executed.

---

## 🔐 Django Configuration

Configure the PostgreSQL connection in:

```text
core/settings.py
```

Make sure the database configuration matches your local PostgreSQL installation.

For example, the configuration should contain the appropriate:

* Database name
* Database user
* Database password
* Host
* Port

Do not commit passwords, secret keys, or other private credentials to the repository.

For local development, use your own PostgreSQL credentials.

---

## ▶️ Running the Project

After configuring PostgreSQL and initializing the database:

```bash
python manage.py runserver
```

Then open:

```text
http://127.0.0.1:8000/
```

For the deployed version, visit:

**http://carino24.ir/**

---

## 🔄 AJAX Endpoints

The application uses AJAX for dynamic vehicle selection.

For example, when the user selects a vehicle category:

```text
Vehicle Type
      ↓
   Brands
      ↓
   Models
```

The frontend requests the appropriate brands and models from Django endpoints without requiring a full page reload.

This approach is used in:

* Advertisement creation
* Advertisement editing
* Home page filtering

---

## 🧠 Database Design Decisions

One of the important design decisions in the project is separating a vehicle from its advertisement.

Instead of storing all vehicle information directly inside `Advertisement`, the relationship is:

```text
Advertisement
      │
      ▼
   Vehicle
      │
      ├── Car
      └── Motorcycle
```

This allows vehicle-related information to remain independent from advertisement-specific information while keeping the database normalized.

The project also uses a `Favorite` relationship between users and advertisements:

```text
User
 │
 └── Favorite ─── Advertisement
```

with a unique constraint preventing the same user from saving the same advertisement more than once.

---

## 📚 Project Phases

### Phase 1 — ER Design

The initial database design was created as an ER diagram and is available in:

```text
phase1_er_diagram/
```

The repository contains both the editable diagram project and an exported diagram image.

### Phase 2 — SQL Implementation

The database was implemented using a sequence of SQL scripts.

These scripts document the evolution of the database schema and provide additional database-level functionality and sample data.

### Phase 3 — Django Application

The relational database was integrated with a Django web application.

Django models, views, templates, authentication, AJAX endpoints, and application logic were implemented as part of this phase.

### Phase 4 — Deployment

The application was deployed as a publicly accessible web application.

The current live version is available at:

**http://carino24.ir/**

---

## 🚧 Future Improvements

Possible future improvements include:

* Advanced advertisement search
* More detailed vehicle specifications
* Better pagination and query optimization
* Advertisement moderation improvements
* More comprehensive validation
* API development
* Improved test coverage
* Performance optimization
* Better image processing
* Responsive UI improvements
* Additional vehicle categories

---

## 🎓 Academic Purpose

This project was developed as a university database project with the goal of applying database concepts in a real-world web application.

The project focuses on connecting theoretical database concepts such as:

* ER modeling
* Relational schema design
* Normalization
* Constraints
* Indexing
* Foreign keys
* Transactions
* Stored procedures/functions
* Database migrations

with a practical Django backend and a deployed web application.

---

## 📄 License

This project is licensed under the MIT License.

See the `LICENSE` file for more information.

---

## 👨‍💻 Author

**Amirhosein**

GitHub: [@Amir-Pers](https://github.com/Amir-Pers)

Repository: [University-DB-Project](https://github.com/Amir-Pers/University-DB-Project)

Live Demo: [Carino 24](http://carino24.ir/)

---

## ⭐ Project Status

The project is currently **deployed and running**.

🚗 **Carino 24 — خرید و فروش خودرو و موتورسیکلت**

🌐 **http://carino24.ir/**
