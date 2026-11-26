## Grocery-Store-Management-System
A JavaOOP project following the 3-tier model

## Hierarchy
The project uses one root package (grocerystore), with the following package hierarchy:
- `grocerystore/model/user`:      	User, Staff, Customer, Manager, Deliveryman
- `grocerystore/model/product`:   	Category, Product, InventoryBatch
- `grocerystore/model/order`:     	Order, OrderStatus, InsufficientStockException
- `grocerystore/dao`:           	  UserDAO, ProductDAO, OrderDAO, DaoFactory, DataAccessException
- `DataAccessException/jdbc`:      JdbcUserDAO, JdbcProductDAO, JdbcOrderDAO, DatabaseConnection
- `DatabaseConnection/gui`:        LoginScreen, CustomerScreen, ManagerScreen, DeliverymanScreen
- `DatabaseConnection/Main`:

