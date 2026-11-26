# Grocery Store Management System
Java OOP project for module Object-Oriented Programming in Java, Vietnamese-German University, WS 2026.

A grocery store system for three kinds of users: customers who search for products and place orders, managers who control products, stock, orders and sales reports, and deliverymen who carry out deliveries.

## Features

- **Customer:** register and log in, search and view products, manage a shopping cart, place an order, track order status
- **Manager:** add, update and delete products and categories, monitor stock levels, expiration dates and restock dates, view orders and transactions, generate sales reports
- **Deliveryman:** log in, view orders, start a delivery (BEING_DELIVERED) and complete it (DELIVERED)

## Repository layout

```
.
├── docs/        project report, UML and database diagrams (PNG, PlantUML, draw.io)
├── database/    schema.sql and seed.sql (MySQL)
├── src/         Java source code (package grocerystore)
├── web/         HTML, CSS and JavaScript interface
└── tests/       automated browser tests
```

## Demo accounts

All demo accounts use the password `Password123!`. They exist only in the sample data.

| Role | Username |
|---|---|
| Customer | `jamie`, `riley` |
| Manager | `manager1` |
| Deliveryman | `delivery1` |

## Project report

The full report is in `docs/`. It describes the requirements, class design, package design, access control, database and interface.
