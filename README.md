# ServiceBook – Service Booking Platform

A web-based service booking and management platform developed using **Java, JSP, Servlets, JDBC, MySQL, HTML, CSS, JavaScript, and Bootstrap**.

ServiceBook connects customers with service providers, allowing customers to explore and book services while providers manage their service listings and customer bookings.

## 🚀 Key Features

### 👤 Customer Module
- Customer registration and login
- Browse available services
- View service and provider details
- Book services online
- Track booking status
- Cancel pending bookings
- Receive booking notifications
- View and update profile information

### 🛠️ Service Provider Module
- Provider registration and login
- Provider dashboard
- Add, edit, and delete services
- Manage service listings
- View customer bookings
- Accept or reject booking requests
- Mark bookings as completed
- Receive notifications
- Manage provider profile

### 🔐 Authentication and Security
- Role-based login system
- Session-based authentication
- Protected customer and provider pages
- Logout functionality
- JDBC database connectivity

## 💻 Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend development |
| JSP | Dynamic web pages |
| Servlets | Request handling |
| JDBC | Database connectivity |
| MySQL | Database management |
| HTML5 | Page structure |
| CSS3 | Styling |
| JavaScript | Frontend interactions |
| Bootstrap | Responsive interface |
| Apache Tomcat 9 | Web server |
| Eclipse IDE | Development environment |
| Git & GitHub | Version control |

## 📂 Project Structure

```text
ServiceBookingPlatform/
├── src/
│   └── main/
│       ├── java/
│       │   ├── dao/
│       │   ├── db/
│       │   └── servlet/
│       └── webapp/
│           ├── customer/
│           ├── provider/
│           ├── Scripts/
│           ├── Styles/
│           ├── image/
│           ├── WEB-INF/
│           ├── index.jsp
│           ├── login.jsp
│           └── register.jsp
├── .gitignore
├── .project
└── .classpath
```

## 🗄️ Database

The application uses MySQL for storing user accounts, service listings, bookings, and notifications.

Main database tables:

- `users`
- `provider_services`
- `bookings`
- `notifications`

## ⚙️ Installation and Setup

1. Clone the repository:

```bash
git clone https://github.com/ujjal0045/ServiceBookingPlatform.git
```

2. Import the project into Eclipse IDE.
3. Configure Apache Tomcat 9.
4. Create a MySQL database named `servicebook`.
5. Create the required database tables according to the application's DAO classes.
6. Configure the `DB_PASSWORD` environment variable with your local MySQL password.
7. Ensure the MySQL JDBC driver is available.
8. Run the application using Tomcat.

**Note:** The database schema is not currently included in this README. Database tables must be created before running the application.

## 🔄 Booking Workflow

1. Customer logs into ServiceBook.
2. Customer browses available services.
3. Customer selects a service and submits a booking request.
4. Provider reviews the booking.
5. Provider accepts or rejects the request.
6. Accepted bookings can be marked as completed.
7. Customer receives booking status notifications.

## 📸 Project Screenshots

Screenshots of the customer dashboard, provider dashboard, service listings, and booking management pages can be added here.

## 🔮 Future Enhancements

- Admin dashboard
- Online payment integration
- Customer ratings and reviews
- Advanced service search and filtering
- Email notifications
- Improved security and password management

## 👥 Project Team

| Name | Department | Roll No. |
|---|---|---|
| Ujjal Burnwal | BCA | 92 |
| Sutapa Mondal | BCA | 89 |
| Ananya Bose | BCA | 14 |
| Tapesh Mahato | ECE | 55 |

## 🎓 Project Information

**Project Name:** ServiceBook  
**Project Type:** Full-Stack Web Application  
**Institution:** Asansol Engineering College  
**Purpose:** Academic project and practical full-stack development experience

## 📜 License

No license has been specified for this repository.

---

⭐ If you find this project useful, consider starring the repository.
