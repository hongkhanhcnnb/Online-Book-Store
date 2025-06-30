# Online Bookstore - Flask Web Application

The **Online Bookstore** project is a full-stack web application developed to simulate the operation of a digital bookstore. It provides both administrative and customer-facing functionalities, supporting end-to-end processes from browsing books to placing and managing orders. This project was developed as part of a university-level course on software engineering fundamentals, with the aim of integrating key principles of web development, database design, and user experience.

---

## System Overview

The application is designed around a role-based access control model, offering separate interfaces and functionalities for two distinct user groups:

- **Administrators** have access to an internal dashboard that enables them to manage book inventory, review customer orders, and maintain general system operations.
- **Customers** interact with a public-facing storefront where they can register, browse available books, manage their shopping cart, and place orders.

The system emphasizes maintainability, modular code structure, and security through session-based authentication and environment-based configuration.

---

## Key Features

### User Authentication & Session Management
- Secure registration and login functionality for customers.
- Authentication system with role-based access control (admin vs customer).
- Session management to maintain user state across requests.

### Book Catalog Management (Admin)
- Admins can add, edit, and delete book entries.
- Metadata management: title, author, genre, pricing, and quantity.
- Real-time updates reflected in the public-facing bookstore.

### Shopping and Order System (Customer)
- Customers can browse the book catalog by categories.
- Add-to-cart functionality with quantity control.
- Order submission with confirmation interface.
- View order history after login.

### Order Management (Admin)
- View and manage all orders placed by customers.
- Filter orders by status and customer information.
- Ability to mark orders as fulfilled or canceled.

### Responsive User Interface
- Clean and intuitive design using HTML, CSS, and basic JavaScript.
- Dynamic content rendering via Flask templates.
- Mobile-friendly layout and navigation.

---

## Technologies Used

| Layer         | Technology              |
|---------------|--------------------------|
| **Backend**   | Python (Flask Framework) |
| **Database**  | MySQL                    |
| **Frontend**  | HTML, CSS, JavaScript    |
| **Tools**     | Python venv, dotenv      |
| **Version Control** | Git & GitHub      |

- **Flask**: Used to handle routing, session control, request processing, and template rendering.
- **MySQL**: Stores data for users, books, and orders in a relational schema.
- **Environment Configuration**: `.env` file is used to manage sensitive configuration values securely.

---

## Architectural Highlights

- **MVC-inspired structure**: Routes (controllers), templates (views), and database logic (models) are logically separated for maintainability.
- **Scalable design**: Easily extensible to include additional features such as payment integration or book reviews.
- **Database schema**: Normalized relational schema with foreign keys to ensure data integrity across users, products, and transactions.

---

## Educational Purpose

This project serves as a practical implementation of software engineering concepts taught in introductory courses. It emphasizes:
- Real-world application architecture.
- Collaborative development practices.
- Hands-on experience with full-stack development.

---

> This system was developed as part of the Software Engineering Fundamentals course (SE104) at the University of Information Technology – Vietnam National University, Ho Chi Minh City.
