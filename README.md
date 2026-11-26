# Grocery-Store-Management-System
A JavaOOP project following the 3-tier model

The project uses one root package (grocerystore), with the following package hierarchy:

grocerystore
├── model
│   ├── user      	User, Staff, Customer, Manager, Deliveryman
│   ├── product   	Category, Product, InventoryBatch
│   └── order     	Order, OrderStatus, InsufficientStockException
├── dao           	UserDAO, ProductDAO, OrderDAO, DaoFactory, DataAccessException
│   └── jdbc      	JdbcUserDAO, JdbcProductDAO, JdbcOrderDAO, DatabaseConnection
├── gui           	LoginScreen, CustomerScreen, ManagerScreen, DeliverymanScreen
└── Main
