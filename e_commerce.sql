CREATE DATABASE e_commerce;
USE ecommerce_db;

CREATE TABLE product_gender
(
product_gender_id INT,
gender_name VARCHAR(10),
constraint pk_prodgender
primary key(product_gender_id)
);

insert into product_gender(product_gender_id, gender_name) values
(1, 'Women'),
(2, 'Men');

SELECT 
product_gender_id,
gender_name
FROM product_gender;

CREATE TABLE product_category(
product_category_id int,
category_name varchar(100),
category_image varchar(400),
product_gender_id int,
constraint pk_prodcategory
primary key (product_category_id),
constraint fk_prodcategory_gender
foreign key (product_gender_id) references product_gender(product_gender_id)
);

INSERT INTO product_category (product_category_id, category_name, category_image, product_gender_id) VALUES
(1, 'Dresses', 'images/women/dresses.jpg', 1),
(2, 'Tops', 'images/women/tops.jpg', 1),
(3, 'Skirts', 'images/women/skirts.jpg', 1),
(4, 'Jackets', 'images/women/jackets.jpg', 1),
(5, 'Pants', 'images/women/pants.jpg', 1),
(6, 'Accessories', 'images/women/accessories.jpg', 1),
(7, 'Shirts', 'images/men/shirts.jpg', 2),
(8, 'Trousers', 'images/men/trousers.jpg', 2),
(9, 'Jackets', 'images/men/jackets.jpg', 2),
(10, 'Suits', 'images/men/suits.jpg', 2),
(11, 'T-Shirts', 'images/men/tshirts.jpg', 2),
(12, 'Accessories', 'images/men/accessories.jpg', 2);

ALTER TABLE product_category
ADD category_description VARCHAR(2000);

UPDATE product_category
SET category_description = "Layer up for less with key overview in our men\'s sale."
WHERE product_category_id = 7;

UPDATE product_category
SET category_description = "Shoes - we\'ve got you covered less with key overview in our men\'s sale."
WHERE product_category_id = 3;

CREATE TABLE product (
    product_id INT AUTO_INCREMENT,
    product_name VARCHAR(100),
    original_price DECIMAL(10,2),
    sale_price DECIMAL(10,2),
    product_category_id INT,
    CONSTRAINT pk_product PRIMARY KEY (product_id),
    CONSTRAINT fk_prod_prodcategory FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id)
);

INSERT INTO product (product_id, product_name, original_price, sale_price, product_category_id) VALUES
(1, 'ASOS DESIGN Floral Midi Dress', 59.99, 47.99, 1),
(2, 'Collusion Oversized Crop Top', 29.99, NULL, 2),
(3, 'Topshop Pleated Mini Skirt', 39.99, 31.99, 3),
(4, 'ASOS Edition Faux Leather Jacket', 89.99, 71.99, 4),
(5, 'Pull&Bear High-Waisted Jeans', 49.99, NULL, 5),
(6, 'ASOS DESIGN Statement Necklace', 19.99, 15.99, 6),
(7, 'ASOS DESIGN Slim Fit Shirt', 34.99, 27.99, 7),
(8, 'Selected Homme Tailored Trousers', 69.99, NULL, 8),
(9, 'Jack & Jones Bomber Jacket', 79.99, 63.99, 9),
(10, 'ASOS DESIGN Wedding Suit', 149.99, 119.99, 10),
(11, 'New Look Graphic T-Shirt', 24.99, NULL, 11),
(12, 'ASOS DESIGN Leather Belt', 22.99, 18.39, 12);

CREATE TABLE product_image(
image_id INT,
product_id INT,
image_filename VARCHAR(400),
CONSTRAINT pk_prodimage PRIMARY KEY(image_id),
CONSTRAINT fk_prodimage_product FOREIGN KEY(product_id) REFERENCES product(product_id)
);

INSERT INTO product_image (image_id, product_id, image_filename) VALUES
(1, 1, 'images/products/1/floral-midi-dress.jpg'),
(2, 2, 'images/products/2/oversized-crop-top.jpg'),
(3, 3, 'images/products/3/pleated-mini-skirt.jpg'),
(4, 4, 'images/products/4/faux-leather-jacket.jpg'),
(5, 5, 'images/products/5/high-waisted-jeans.jpg'),
(6, 6, 'images/products/6/statement-necklace.jpg'),
(7, 7, 'images/products/7/slim-fit-shirt.jpg'),
(8, 8, 'images/products/8/tailored-trousers.jpg'),
(9, 9, 'images/products/9/bomber-jacket.jpg'),
(10, 10, 'images/products/10/wedding-suit.jpg'),
(11, 11, 'images/products/11/graphic-t-shirt.jpg'),
(12, 12, 'images/products/12/leather-belt.jpg');

CREATE TABLE color (
    color_id INT AUTO_INCREMENT,
    color_name VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT pk_color PRIMARY KEY (color_id)
);

INSERT INTO color (color_id, color_name) VALUES
(1, 'Black'),
(2, 'White'),
(3, 'Navy'),
(4, 'Red'),
(5, 'Sage Green'),
(6, 'Grey'),
(7, 'Blue'),
(8, 'Pink'),
(9, 'Mustard Yellow'),
(10, 'Beige'),
(11, 'Chocolate Brown'),
(12, 'Multicolor');

CREATE TABLE product_item (
    product_item_id INT AUTO_INCREMENT,
    product_id INT,
    color_id INT,
    size VARCHAR(50),
    CONSTRAINT pk_proditem PRIMARY KEY (product_item_id),
    CONSTRAINT fk_proditem_product FOREIGN KEY (product_id) REFERENCES product(product_id),
    CONSTRAINT fk_proditem_color FOREIGN KEY (color_id) REFERENCES color(color_id)
);

ALTER TABLE product_item
ADD COLUMN original_price DECIMAL(10,2) NOT NULL,
ADD COLUMN sale_price DECIMAL(10,2) NULL;

INSERT INTO product_item (product_id, color_id, size, original_price, sale_price) VALUES
(1, 1, 'UK 8', 59.99, 47.99),        -- Floral Midi Dress, Black, UK 8
(1, 5, 'UK 10', 59.99, 47.99),       -- Floral Midi Dress, Sage Green, UK 10
(2, 2, 'S', 29.99, NULL),            -- Oversized Crop Top, White, S
(3, 4, 'UK 6', 39.99, 31.99),        -- Pleated Mini Skirt, Red, UK 6
(4, 6, 'M', 89.99, 71.99),           -- Faux Leather Jacket, Grey, M
(5, 7, 'UK 8', 49.99, NULL),         -- High-Waisted Jeans, Blue, UK 8
(6, 8, 'One Size', 19.99, 15.99),    -- Statement Necklace, Pink, One Size
(7, 3, 'M', 34.99, 27.99),           -- Slim Fit Shirt, Navy, M
(8, 1, 'W 32 L 32', 69.99, NULL),    -- Tailored Trousers, Black, W 32 L 32
(9, 5, 'L', 79.99, 63.99),           -- Bomber Jacket, Sage Green, L
(10, 6, 'M', 149.99, 119.99),        -- Wedding Suit, Grey, M
(11, 11, 'S', 24.99, NULL);          -- Graphic T-Shirt, Chocolate Brown, 

ALTER TABLE product
DROP COLUMN original_price;

ALTER TABLE product
DROP COLUMN sale_price;

ALTER TABLE product_image
ADD COLUMN product_item_id INT;

UPDATE product_image
SET product_item_id = 1
WHERE product_id = 1;

UPDATE product_image
SET product_item_id = 2
WHERE product_id = 2;

UPDATE product_image
SET product_item_id = 3
WHERE product_id = 3;

UPDATE product_image
SET product_item_id = 4
WHERE product_id = 4;

ALTER TABLE product_item
DROP COLUMN size;

CREATE TABLE size_option(
size_id INT,
size_name VARCHAR(50),
size_order INT,
CONSTRAINT pk_size PRIMARY KEY(size_id)
);

ALTER TABLE size_option
CHANGE COLUMN size_order sort_order INT;

INSERT INTO size_option (size_id, size_name, sort_order) VALUES
(1, 'UK 4', 1),
(2, 'UK 6', 2),
(3, 'UK 8', 3),
(4, 'UK 10', 4),
(5, 'UK 12', 5),
(6, 'UK 14', 6),
(7, 'UK 16', 7);

ALTER TABLE product_item
ADD COLUMN size_id INT;

ALTER TABLE product_item
ADD CONSTRAINT fk_product_item
FOREIGN KEY (size_id) REFERENCES size_option (size_id);

ALTER TABLE product_item
ADD COLUMN qty_in_stock INT;


INSERT INTO product_item (product_id, color_id, original_price, sale_price, size_id, qty_in_stock) VALUES
(1, 1, 25.00, 20.00, 1, 15),  -- Black, XS
(1, 1, 25.00, 20.00, 2, 20),  -- Black, S
(1, 1, 25.00, 20.00, 3, 25),  -- Black, M
(1, 1, 25.00, 20.00, 4, 18),  -- Black, L
(1, 1, 25.00, 20.00, 5, 10),  -- Black, XL
(1, 2, 25.00, 25.00, 1, 12),  -- White, XS
(1, 2, 25.00, 25.00, 2, 15),  -- White, S
(1, 2, 25.00, 25.00, 3, 20),  -- White, M
(1, 2, 25.00, 25.00, 4, 10),  -- White, L
(1, 2, 25.00, 25.00, 5, 8),   -- White, XL
(1, 3, 25.00, 22.00, 1, 14),  -- Red, XS
(1, 3, 25.00, 22.00, 2, 18),  -- Red, S
(1, 3, 25.00, 22.00, 3, 22),  -- Red, M
(1, 3, 25.00, 22.00, 4, 16),  -- Red, L
(1, 3, 25.00, 22.00, 5, 9),   -- Red, XL
(2, 1, 40.00, 32.00, 1, 10),  -- Black, XS
(2, 1, 40.00, 32.00, 2, 12),  -- Black, S
(2, 1, 40.00, 32.00, 3, 15),  -- Black, M
(2, 1, 40.00, 32.00, 4, 8),   -- Black, L
(2, 1, 40.00, 32.00, 5, 5),   -- Black, XL
(2, 2, 40.00, 40.00, 1, 14),  -- White, XS
(2, 2, 40.00, 40.00, 2, 16),  -- White, S
(2, 2, 40.00, 40.00, 3, 18),  -- White, M
(2, 2, 40.00, 40.00, 4, 10),  -- White, L
(2, 2, 40.00, 40.00, 5, 7),   -- White, XL
(3, 1, 50.00, 45.00, 1, 20),  -- Black, XS
(3, 1, 50.00, 45.00, 2, 25);  -- Black, S

CREATE TABLE product_variation (
variation_id INT,
product_item_id INT,
size_id int,
qty_in_stock int,
constraint pk_prodvar primary key (variation_id),
constraint fk_prodvar_proditem foreign key (product_item_id) references product_item(product_item_id),
constraint fk_prodvar_size foreign key (size_id) references size_option(size_id)
);

INSERT INTO product_variation(variation_id,product_item_id,size_id,qty_in_stock)
select product_item_id, product_item_id, size_id, qty_in_stock
from product_item;

ALTER TABLE product_item
drop column size_id;

alter table product_item
drop constraint fk_product_item;

alter table product_item
drop column qty_in_stock;


alter table product
add column product_description varchar(100);

alter table product_item
add column product_code varchar(50);

CREATE TABLE brand (
brand_id INT,
brand_name varchar(100),
brand_description varchar(2000),
constraint pk_brand primary key (brand_id)
);

INSERT INTO brand VALUES
(1,'Jack & Jones','Founded in the 90s as a jeanswear brand, Danish label Jack & Jones has since gone on to expand its sartorial offering to include everything from jumpers, jackets and T-shirts to shoes, underwear and accessories (alongside more of its flex-worthy denim, of course). Scroll the Jack & Jones at ASOS edit to check out our latest drop of the brand’s laid-back pieces.'),
(2,'ASOS DESIGN','This is ASOS DESIGN – your go-to for all the latest trends, no matter who you are, where you’re from and what you’re up to. Exclusive to ASOS, our universal brand is here for you, and comes in Plus and Tall. Created by us, styled by you.');

ALTER TABLE product
ADD COLUMN brand_id INT;

ALTER TABLE product
ADD constraint fk_prod_brand foreign key(brand_id) references brand(brand_id);

update product
set brand_id = 1
where product_id in (1,2,4);

update product
set brand_id = 2
where product_id in (3);

alter table product
add column model_height varchar(50);

alter table product
add column model_wearing varchar(50);

alter table product
add column care_instructions varchar(200);

alter table product
add column about varchar(200);

-- Update product_id 1: T-shirt
UPDATE product
SET model_height = '5''9"',
    model_wearing = 'S',
    care_instructions = 'Machine wash at 30°C, tumble dry low',
    about = 'Soft cotton T-shirt, perfect for casual wear'
WHERE product_id = 1;

-- Update product_id 2: Dress
UPDATE product
SET model_height = '5''7"',
    model_wearing = 'M',
    care_instructions = 'Hand wash only, do not bleach',
    about = 'Elegant midi dress, ideal for day-to-night looks'
WHERE product_id = 2;

-- Update product_id 3: Jacket
UPDATE product
SET model_height = '5''8"',
    model_wearing = 'S',
    care_instructions = 'Machine wash cold, air dry',
    about = 'Classic denim jacket, great for layering'
WHERE product_id = 3;

-- Update product_id 4: Jeans
UPDATE product
SET model_height = '5''10"',
    model_wearing = 'XS',
    care_instructions = 'Machine wash at 40°C, do not tumble dry',
    about = 'Slim-fit jeans, versatile for any occasion'
WHERE product_id = 4;

-- Update product_id 5: Shirt
UPDATE product
SET model_height = '5''6"',
    model_wearing = 'M',
    care_instructions = 'Machine wash at 30°C, iron on low',
    about = 'Crisp cotton shirt, perfect for work or weekends'
WHERE product_id = 5;

-- Update product_id 6: Skirt
UPDATE product
SET model_height = '5''8"',
    model_wearing = 'S',
    care_instructions = 'Dry clean only',
    about = 'Flowy midi skirt, adds a chic touch to any outfit'
WHERE product_id = 6;

-- Update product_id 7: Sweater
UPDATE product
SET model_height = '5''9"',
    model_wearing = 'L',
    care_instructions = 'Hand wash cold, lay flat to dry',
    about = 'Cozy knit sweater, ideal for chilly days'
WHERE product_id = 7;

-- Update product_id 8: Trousers
UPDATE product
SET model_height = '5''7"',
    model_wearing = 'XS',
    care_instructions = 'Machine wash at 30°C, do not bleach',
    about = 'Tailored trousers, great for office or casual wear'
WHERE product_id = 8;

-- Update product_id 9: Blouse
UPDATE product
SET model_height = '5''10"',
    model_wearing = 'M',
    care_instructions = 'Hand wash, do not tumble dry',
    about = 'Lightweight blouse, perfect for summer styling'
WHERE product_id = 9;

-- Update product_id 10: Coat
UPDATE product
SET model_height = '5''8"',
    model_wearing = 'S',
    care_instructions = 'Dry clean only',
    about = 'Warm wool coat, a winter wardrobe essential'
WHERE product_id = 10;

-- Update product_id 11: Hoodie
UPDATE product
SET model_height = '5''6"',
    model_wearing = 'L',
    care_instructions = 'Machine wash at 40°C, tumble dry low',
    about = 'Comfy hoodie, great for lounging or layering'
WHERE product_id = 11;

-- Update product_id 12: Jumpsuit
UPDATE product
SET model_height = '5''9"',
    model_wearing = 'M',
    care_instructions = 'Machine wash cold, air dry',
    about = 'Sleek jumpsuit, effortless one-piece style'
WHERE product_id = 12;

CREATE TABLE size_category (
category_id INT,
category_name varchar(100),
constraint pk_size_category primary key (category_id)
);

INSERT INTO size_category(category_id, category_name) VALUES
(1, 'Men Clothing'),
(2,'Women Clothing');

ALTER TABLE size_option
add column size_category_id int;

alter table size_option
add constraint fk_sizeopt_category
foreign key (size_category_id) references size_category(category_id);


alter table product_category
add column parent_product_category_id int;

alter table product_category
add constraint fk_prodcat_parent
foreign key (parent_product_category_id) references product_category(product_category_id);

insert into product_category (product_category_id,category_name, category_image) values
(13, 'Men', '/images/man.png'),
(14, 'Men', '/images/woman.png');

update product_category
set parent_product_category_id = 13
where product_gender_id = 2;

update product_category
set parent_product_category_id = 14
where product_gender_id = 1;

alter table product_category
drop constraint fk_prodcategory_gender;

alter table product_category
drop column product_gender_id;

drop table product_gender;



-- Create attribute_type table
CREATE TABLE attribute_type (
    attribute_type_id INT,
    attribute_name VARCHAR(100),
    CONSTRAINT pk_attype PRIMARY KEY (attribute_type_id)
);

-- Insert data into attribute_type
INSERT INTO attribute_type (attribute_type_id, attribute_name) VALUES
(1, 'Sales/New Season'),
(2, 'Length'),
(3, 'Body Fit'),
(4, 'Color'),
(5, 'Style'),
(6, 'Sleeve Length'),
(7, 'Neckline');

-- Create attribute_option table
CREATE TABLE attribute_option (
    attribute_option_id INT,
    attribute_option_name VARCHAR(100),
    attribute_type_id INT,
    CONSTRAINT pk_atop PRIMARY KEY (attribute_option_id),
    CONSTRAINT fk_atop_attype FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

-- Insert data into attribute_option
INSERT INTO attribute_option (attribute_option_id, attribute_option_name, attribute_type_id) VALUES
(1, 'New Season', 1),
(2, 'Sale', 1),
(3, 'Mini', 2),
(4, 'Midi', 2),
(5, 'Maxi', 2),
(6, 'Regular', 3),
(7, 'Slim', 3),
(8, 'Oversized', 3),
(9, 'Black', 4),
(10, 'White', 4),
(11, 'Red', 4),
(12, 'Casual', 5),
(13, 'Formal', 5),
(14, 'Athleisure', 5),
(15, 'Sleeveless', 6),
(16, 'Short Sleeve', 6),
(17, 'Long Sleeve', 6),
(18, 'Crew Neck', 7),
(19, 'V-Neck', 7),
(20, 'Scoop Neck', 7);

CREATE TABLE product_attribute (
    product_id INT,
    attribute_option_id INT,
    CONSTRAINT fk_prodat_prod FOREIGN KEY (product_id) REFERENCES product(product_id),
    CONSTRAINT fk_prodat_prod_atop FOREIGN KEY (attribute_option_id) REFERENCES attribute_option(attribute_option_id)
);