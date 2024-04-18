# Creating 'Location' table.
CREATE TABLE IF NOT EXISTS Location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(85) NOT NULL,
    country VARCHAR(20) NOT NULL
);

# Creating 'Restaurant' table. 
# Each restaurant belongs to one location. Each location can have multiple restaurants.
CREATE TABLE IF NOT EXISTS Restaurant (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    contact_number VARCHAR(20),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE SET NULL
);

# Creating 'Category' table.
CREATE TABLE IF NOT EXISTS Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

# Creating 'Item' table. 
# Each item belongs to one category. Each category can have multiple items.
CREATE TABLE IF NOT EXISTS Item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE SET NULL
);

# Creating 'Employee' table.
# Each employee works at one restaurant. Each restaurant can have multiple employees.
CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    position VARCHAR(25) NOT NULL,
    contact_number VARCHAR(20),
    salary DECIMAL(10, 2) NOT NULL,
    restaurant_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id) ON DELETE SET NULL
);

# Creating 'Customer' table.
CREATE TABLE IF NOT EXISTS Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    phone_number VARCHAR(20)
);

# Creating 'Reservation' table.
# Each reservation is made by one customer. Each customer can make multiple reservations. Each reservation is associated with one restaurant. Each restaurant can have multiple reservations.
CREATE TABLE IF NOT EXISTS Reservation (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    date DATE NOT NULL,
    table_number TINYINT NOT NULL,
    restaurant_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id) ON DELETE SET NULL
);

# Creating 'Order' table.
# Each order is placed by one customer. Each customer can place multiple orders.
CREATE TABLE IF NOT EXISTS `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    rating TINYINT NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE SET NULL
);

# Creating 'Order_Item' table. 
# Each order can have multiple order items. Each order item belongs to one order. Each order item is associated with one item. Each item can be part of multiple order items.
CREATE TABLE IF NOT EXISTS Order_Item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity TINYINT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Item(item_id) ON DELETE SET NULL
);

# Creating 'Order_Log' table (for logging purposes).
CREATE TABLE IF NOT EXISTS Order_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    log_message VARCHAR(255) NOT NULL,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id) ON DELETE SET NULL
);

# -------------------------------------------------------------------------------------

# Exercise E
# Inserting Locations
INSERT INTO Location (location_id, city, country) VALUES
  (1,"Stockholm","Sweden"),
  (2,"Barcelona","Spain"),
  (3,"Oslo","Norway");

# Inserting Restaurants
INSERT INTO Restaurant (restaurant_id, name, address, contact_number, location_id) VALUES
  (1,"Restaurant_STOC","111 35 Kungsgatan 12","(788) 260-4617", 1),
  (2,"Restaurant_BARC","98 110 C. de Pujades 14","1-538-237-3443", 2),
  (3,"Restaurant_OSLO","0154 Karl Johans gt. 14","1-362-755-7217", 3);

# Inserting Categories
INSERT INTO Category (category_id, name) VALUES
    (1, 'Main course'),
    (2, 'Dessert'),
    (3, 'Drink');

# Inserting main dishes
INSERT INTO Item (item_id, item_name, description, price, category_id) VALUES
    (1, 'Salmon Sushi', 'Fresh salmon slices on a bed of rice', 18.99, 1),
    (2, 'Swedish Meatballs', 'Classic Swedish meatballs with lingonberry sauce', 14.50, 1),
    (3, 'Pasta Bolognese', 'Spaghetti with hearty meat sauce', 16.75, 1),
    (4, 'Shrimp Scampi', 'Garlic butter shrimp served over linguine', 19.99, 1),
    (5, 'Caprese Salad', 'Fresh mozzarella, tomatoes, and basil with balsamic glaze', 11.75, 1),
    (6, 'Vegetarian Sushi Roll', 'Sushi roll with avocado, cucumber, and pickled radish', 14.99, 1),
    (7, 'Paella Valenciana', 'Traditional Spanish paella with seafood and saffron', 22.50, 1),
    (8, 'Tapas Platter', 'Assorted Spanish tapas for sharing', 20.99, 1),
    (9, 'Patatas Bravas', 'Fried potatoes with spicy tomato sauce', 12.25, 1),
    (10, 'Vegetarian Paella', 'Paella with a mix of vegetables and saffron', 17.50, 1),
    (11, 'Barcelona Burger', 'Burger with chorizo and manchego cheese', 14.49, 1),
    (12, 'Mediterranean Pizza', 'Pizza with olives, feta, and sun-dried tomatoes', 16.25, 1),
    (13, 'Chicken Paella', 'Paella with tender chicken and saffron', 18.50, 1),
    (14, 'Spanish Flan', 'Creamy caramel custard dessert', 8.99, 1),
    (15, 'Norwegian Salmon Salad', 'Salad with smoked salmon and dill dressing', 15.99, 1),
    (16, 'Fish and Chips', 'Crispy battered fish with fries', 13.50, 1),
    (17, 'Lamb Kebabs', 'Grilled lamb skewers with mint yogurt sauce', 18.75, 1),
    (18, 'Oslo Omelette', 'Scandinavian-style omelette with smoked salmon', 12.99, 1),
    (19, 'Viking Platter', 'Assorted Nordic delicacies on a platter', 21.50, 1),
    (20, 'Scandinavian Herring Plate', 'Pickled herring served with rye bread', 15.25, 1);

# Inserting desserts
INSERT INTO Item (item_id, item_name, description, price, category_id) VALUES
    (21, 'Chocolate Fondue', 'Assorted fruits with a rich chocolate dipping sauce', 10.99, 2),
    (22, 'Tiramisu', 'Classic Italian dessert with layers of coffee-soaked ladyfingers and mascarpone', 9.50, 2),
    (23, 'Mango Sorbet', 'Refreshing mango-flavored sorbet', 6.50, 2),
    (24, 'Churros with Chocolate Sauce', 'Spanish doughnuts served with a side of chocolate sauce', 8.75, 2),
    (25, 'Cheesecake', 'New York-style cheesecake with raspberry sauce', 12.99, 2),
    (26, 'Tropical Fruit Salad', 'Fresh fruit salad with a tropical twist', 8.50, 2),
    (27, 'Creme Brulee', 'Vanilla custard with a crispy caramelized sugar topping', 10.25, 2),
    (28, 'Danish Apple Cake', 'Apple cake with cinnamon and a hint of cardamom', 9.75, 2),
    (29, 'Nordic Berry Tart', 'Tart filled with mixed berries from the Nordic region', 11.25, 2),
    (30, 'Flan de Naranja', 'Orange-flavored caramel custard dessert', 7.99, 2);

# Inserting drinks
INSERT INTO Item (item_id, item_name, description, price, category_id) VALUES
    (31, 'Mojito', 'Classic Cuban cocktail with mint, lime, and rum', 7.99, 3),
    (32, 'Swedish Lingonberry Punch', 'Punch with lingonberry and citrus notes', 7.50, 3),
    (33, 'Iced Cappuccino', 'Chilled cappuccino with a shot of espresso', 5.99, 3),
    (34, 'Blueberry Lemonade', 'Lemonade with a burst of blueberry flavor', 4.99, 3),
    (35, 'Sangria', 'Spanish punch with red wine and mixed fruits', 8.50, 3),
    (36, 'Spanish Horchata', 'Sweet rice milk beverage with cinnamon', 4.50, 3),
    (37, 'Barcelona Breeze', 'Fruity cocktail with a blend of tropical juices', 8.75, 3),
    (38, 'Nordic Forest Smoothie', 'Blend of berries and yogurt inspired by Nordic flavors', 6.75, 3),
    (39, 'Oslo Sunrise', 'Refreshing citrus mocktail inspired by the Oslo skyline', 6.25, 3),
    (40, 'Copenhagen Cooler', 'Cooling drink with cucumber and mint', 5.25, 3);

# Inserting Employees
INSERT INTO Employee (employee_id,name,position,contact_number, salary, restaurant_id) VALUES
  (1,"Harding Dawson","Waiter", "(788) 260-4617",2691, 1),
  (2,"Odysseus Farmer", "Manager", "1-538-237-3443",4260, 1),
  (3,"Kirestin Simmons"," Waiter", "1-362-755-7217",3248, 1),
  (4,"Briar Myers","Waiter", "(497) 260-4044",3143, 1),
  (5,"Sylvia Oneal","Waiter","1-421-533-5573",1783, 1),
  (6,"Brenda Olsen","Waiter", "(882) 946-6601",2383, 2),
  (7,"Kaseem Meyers","Waiter","1-573-975-6892",1315, 2),
  (8,"Avye Dotson","Waiter", "1-805-651-6354",1201, 2),
  (9,"Abraham Davidson","Manager","(474) 265-1862",3996, 2),
  (10,"Meredith Hubbard","Waiter", "1-104-486-2514",3893, 2),
  (11,"Jeremy Nash","Waiter", "(872) 628-1414",2952, 3),
  (12,"Driscoll Aguirre","Waiter", "1-507-411-4413",1425, 3),
  (13,"Zephania Perry","Manager", "(330) 732-8835",4565, 3),
  (14,"Cooper Crawford","Waiter", "(822) 753-0573",2369, 3),
  (15,"Leandra Perry","Waiter", "(858) 877-7461",2108, 3);

# Inserting Customers
INSERT INTO Customer (customer_id,name,email,phone_number) VALUES
  (1,"Jeremy Nash","metus.in.nec@aol.com","1-581-776-7312"),
  (2,"Driscoll Aguirre","maecenas@outlook.org","1-475-243-2262"),
  (3,"Zephania Perry","at.egestas@hotmail.ca","(351) 370-4772"),
  (4,"Cooper Crawford","mi.felis@hotmail.ca","(806) 646-8848"),
  (5,"Leandra Perry","ipsum.sodales.purus@hotmail.net","1-484-573-0543"),
  (6,"Ishmael Acevedo","donec.sollicitudin@google.net","1-899-231-4808"),
  (7,"Whitney Maddox","iaculis.lacus@icloud.couk","1-165-572-2942"),
  (8,"Hedy Finch","rutrum.non.hendrerit@protonmail.org","1-247-415-1845"),
  (9,"Solomon Joyner","at.arcu@aol.org","(482) 876-7127"),
  (10,"Haley Roy","interdum.enim@hotmail.org","1-784-797-7766"),
  (11,"Uriah Chan","facilisis.eget@hotmail.net","(753) 214-3160"),
  (12,"Ann Baird","mi.felis.adipiscing@google.edu","1-168-233-8595"),
  (13,"Alexander Sawyer","facilisis.eget@aol.com","1-715-531-1322"),
  (14,"Bernard Alvarez","nibh.sit@hotmail.edu","1-575-919-7726"),
  (15,"Yardley Diaz","augue@google.couk","(377) 156-4104"),
  (16, "Eleanor Shaw", "el.shaw@email.com", "(222) 333-4444"),
  (17, "David Foster", "david.foster@email.com", "(555) 666-7777"),
  (18, "Alicia Hernandez", "alicia@email.com", "(999) 888-7777"),
  (19, "Emma Turner", "emma.turner@email.com", "(111) 222-3333"),
  (20, "Lucas Walker", "lucas.walker@email.com", "(444) 555-6666"),
  (21, "Sophia Collins", "sophia.collins@email.com", "(777) 888-9999"),
  (22, "Jackson Hall", "jackson.hall@email.com", "(111) 222-3333"),
  (23, "Mia Foster", "mia.foster@email.com", "(444) 555-6666"),
  (24, "Aiden Brown", "aiden.brown@email.com", "(777) 888-9999"),
  (25, "Olivia Murphy", "olivia.murphy@email.com", "(111) 222-3333");

# Inserting Reservation
INSERT INTO Reservation (reservation_id, customer_id, date, table_number, restaurant_id) VALUES
    (1, 1, '2020-01-15', 14, 1),
    (2, 2, '2020-01-25', 13, 1),
    (3, 3, '2020-02-07', 2, 1),
    (4, 1, '2021-02-23', 7, 1),
    (5, 2, '2021-02-25', 1, 1),
    (6, 14, '2022-06-27', 5, 1),
    (7, 22, '2022-07-15', 13, 1),
    (8, 25, '2022-12-15', 5, 1),
    (9, 9, '2020-09-15', 1, 2),
    (10, 20, '2020-09-15', 9, 2),
    (11, 18, '2020-10-11', 5, 2),
    (12, 11, '2020-11-22', 11, 2),
    (13, 15, '2021-03-14', 22, 2),
    (14, 13, '2021-04-23', 14, 2),
    (15, 19, '2021-04-24', 7, 2),
    (16, 7, '2022-05-26', 3, 2),
    (17, 8, '2020-06-01', 6, 3),
    (18, 23, '2020-06-02', 8, 3),
    (19, 6, '2020-09-29', 5, 3),
    (20, 11, '2020-11-25', 13, 3),
    (21, 22, '2021-01-02', 85, 3),
    (22, 17, '2021-01-02', 3, 3),
    (23, 25, '2022-01-03', 5, 3),
    (24, 25, '2022-09-16', 9, 3),
    (25, 14, '2022-10-05', 10, 3);

# Inserting Order
INSERT INTO `Order` (order_id, date, total_amount, rating, customer_id) VALUES
  (1, '2020-01-15', 49.73, 4, 1),
  (2, '2020-01-25', 43.49, 5, 2),
  (3, '2020-02-07', 15.99, 3, 3),
  (4, '2021-02-23', 29.00, 4, 1),
  (5, '2021-02-25', 17.50, 5, 2),
  (6, '2022-06-27', 20.49, 4, 14),
  (7, '2022-07-15', 8.99, 4, 22),
  (8, '2022-12-15', 21.50, 5, 25),
  (9, '2020-09-15', 11.98, 3, 9),
  (10, '2020-09-15', 14.49, 4, 20),
  (11, '2020-10-11', 31.74, 5, 18),
  (12, '2020-11-22', 18.50, 3, 11),
  (13, '2021-03-14', 9.75, 4, 15),
  (14, '2021-04-23', 11.25, 3, 13),
  (15, '2021-04-24', 6.50, 4, 19),
  (16, '2022-05-26', 8.50, 3, 7),
  (17, '2020-06-01', 4.50, 4, 8),
  (18, '2020-06-02', 12.25, 3, 23),
  (19, '2020-09-29', 15.25, 4, 6),
  (20, '2020-11-25', 7.99, 5, 11),
  (21, '2021-01-02', 15.5, 4, 22),
  (22, '2021-01-02', 6.25, 3, 17),
  (23, '2022-01-03', 5.25, 4, 25),
  (24, '2022-09-16', 13.50, 3, 25),
  (25, '2022-10-05', 8.75, 4, 14);

# Inserting Order_Item
INSERT INTO Order_Item (order_item_id, order_id, item_id, quantity) VALUES
  (1, 1, 1, 2),
  (2, 1, 5, 1),
  (3, 2, 7, 1),
  (4, 2, 8, 1),
  (5, 3, 15, 1),
  (6, 4, 2, 2),
  (7, 5, 10, 1),
  (8, 6, 21, 1),
  (9, 6, 22, 1),
  (10, 7, 14, 1),
  (11, 8, 19, 1),
  (12, 9, 33, 2),
  (13, 10, 11, 1),
  (14, 11, 17, 1),
  (15, 11, 18, 1),
  (16, 12, 13, 1),
  (17, 13, 28, 1),
  (18, 14, 29, 1),
  (19, 15, 23, 1),
  (20, 16, 35, 1),
  (21, 17, 36, 1),
  (22, 18, 9, 1),
  (23, 19, 20, 1),
  (24, 20, 31, 1),
  (25, 21, 37, 1),
  (26, 21, 38, 1),
  (27, 22, 39, 1),
  (28, 23, 40, 1),
  (29, 24, 16, 1),
  (30, 25, 24, 1);


# Exercise C
# Trigger for updating total_amount and inserting a new row into log table.
DELIMITER //
CREATE TRIGGER update_total_amount
AFTER INSERT ON Order_Item
FOR EACH ROW
BEGIN
    DECLARE order_total DECIMAL(10, 2);
    SELECT SUM(I.price * NEW.quantity) INTO order_total
    FROM Item I
    WHERE I.item_id = NEW.item_id;

    UPDATE `Order`
    SET total_amount = total_amount + order_total
    WHERE order_id = NEW.order_id;
    
    INSERT INTO Order_Log (order_id, log_message)
    VALUES (NEW.order_id, CONCAT('Total amount updated for new item (', NEW.item_id, ')'));
END;
//
DELIMITER ;

# Test insert
INSERT INTO Order_Item (order_item_id, order_id, item_id, quantity)
VALUES (31, 1, 40, 2);

# Checking results
SELECT * FROM `Order`;
SELECT * FROM Order_Log;


# Exercise F
# 1
  SELECT
    C.name AS customer_name,
    R.date AS transaction_date,
    I.item_name 
AS product_or_service
FROM
    Customer C
JOIN Reservation R ON C.customer_id = R.customer_id
JOIN `Order` O ON C.customer_id = O.customer_id
JOIN Order_Item OI ON O.order_id = OI.order_id
JOIN Item I ON OI.item_id = I.item_id
WHERE
    (R.date BETWEEN '2020-01-15' AND '2022-10-05')
    OR (O.date BETWEEN '2020-01-15' AND '2022-10-05');
    
# 2 Assuming that the 'best' customer spends the most money
SELECT
    C.name AS customer_name,
    SUM(O.total_amount) AS total_sales
FROM
    Customer C
JOIN `Order` O ON C.customer_id = O.customer_id
GROUP BY
    C.customer_id
ORDER BY
    total_sales DESC
LIMIT 3;

# 3
SELECT
    start_date,
    end_date,
    total_sales,
    yearly_average,
    total_sales / TIMESTAMPDIFF(MONTH, start_date, end_date) AS monthly_average
FROM (
    SELECT
        MIN(date) AS start_date,
        MAX(date) AS end_date,
        SUM(total_amount) AS total_sales,
        AVG(total_amount) AS yearly_average
    FROM
        `Order`
    WHERE
        YEAR(date) BETWEEN 2010 AND 2021
) AS aggregated_data;

# 4
SELECT
    Location.city,
    Location.country,
    SUM(`Order`.total_amount) AS TotalSales
FROM
    `Order`
JOIN
    Reservation ON `Order`.customer_id = Reservation.customer_id
JOIN
    Customer ON Reservation.customer_id = Customer.customer_id
JOIN
    Restaurant ON Reservation.restaurant_id = Restaurant.restaurant_id
JOIN
    Location ON Restaurant.location_id = Location.location_id
GROUP BY
    Location.city, Location.country;
    
# 5
SELECT DISTINCT
    L.city,
    L.country
FROM
    `Restaurant` R
JOIN 
	`Reservation` RV ON R.restaurant_id = RV.restaurant_id
JOIN 
	`Customer` C ON RV.customer_id = C.customer_id
JOIN 
	`Order` O ON RV.customer_id = O.customer_id
JOIN 
	`Order_Item` OI ON O.order_id = OI.order_id
JOIN 
	`Item` I ON OI.item_id = I.item_id
JOIN 
	`Location` L ON R.location_id = L.location_id
WHERE
    O.rating IS NOT NULL;


CREATE VIEW InvoiceDetails AS
SELECT
    o.order_id,
    oi.order_item_id,
    i.item_id,
    i.item_name,
    oi.quantity,
    i.price,
    oi.quantity * i.price AS total_item_amount
FROM `Order` o
JOIN Order_Item oi ON o.order_id = oi.order_id
JOIN Item i ON oi.item_id = i.item_id
ORDER BY order_id;

SELECT * FROM InvoiceDetails;



CREATE VIEW InvoiceHeadTotals AS
SELECT
    o.order_id,
    c.customer_id,
    c.name AS customer_name,
    c.email AS customer_email,
    c.phone_number AS customer_phone,
    o.date AS order_date,
    r.name AS restaurant_name,
    r.address AS restaurant_address,
    l.city AS restaurant_city,
    l.country AS restaurant_country,
    SUM(oi.quantity * i.price) AS total_amount
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Order_Item oi ON o.order_id = oi.order_id
JOIN Item i ON oi.item_id = i.item_id
JOIN Employee e ON o.customer_id = e.employee_id
JOIN Restaurant r ON e.restaurant_id = r.restaurant_id
JOIN Location l ON r.location_id = l.location_id
GROUP BY o.order_id;

SELECT * FROM InvoiceHeadTotals;