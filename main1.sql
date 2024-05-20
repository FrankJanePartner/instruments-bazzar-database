SET foreign_key_checks = 0;

CREATE TABLE account_address (
  id CHAR(32) NOT NULL,
  full_name VARCHAR(150) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  postcode VARCHAR(50) NOT NULL,
  address_line VARCHAR(255) NOT NULL,
  address_line2 VARCHAR(255) NOT NULL,
  town_city VARCHAR(150) NOT NULL,
  delivery_instructions VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  `default` TINYINT(1) NOT NULL,
  customer_id BIGINT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (customer_id) REFERENCES account_customer (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE account_customer (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  password VARCHAR(128) NOT NULL,
  last_login DATETIME,
  is_superuser TINYINT(1) NOT NULL,
  email VARCHAR(254) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  is_active TINYINT(1) NOT NULL,
  is_staff TINYINT(1) NOT NULL,
  UNIQUE (email)
);

CREATE TABLE account_customer_groups (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id BIGINT NOT NULL,
  group_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES account_customer (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (group_id) REFERENCES auth_group (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE account_customer_user_permissions (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id BIGINT NOT NULL,
  permission_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES account_customer (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (permission_id) REFERENCES auth_permission (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE account_otptoken (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tp_created_at DATETIME NOT NULL,
  otp_expires_at DATETIME,
  user_id BIGINT NOT NULL,
  otp_code VARCHAR(6) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES account_customer (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE auth_group (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  UNIQUE (name)
);

CREATE TABLE auth_group_permissions (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  group_id INT NOT NULL,
  permission_id INT NOT NULL,
  FOREIGN KEY (group_id) REFERENCES auth_group (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (permission_id) REFERENCES auth_permission (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE auth_permission (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  content_type_id INT NOT NULL,
  codename VARCHAR(100) NOT NULL,
  name VARCHAR(255) NOT NULL,
  FOREIGN KEY (content_type_id) REFERENCES django_content_type (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE checkout_deliveryoptions (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  delivery_name VARCHAR(255) NOT NULL,
  delivery_price DECIMAL(10, 2) NOT NULL,
  delivery_method VARCHAR(255) NOT NULL,
  delivery_timeframe VARCHAR(255) NOT NULL,
  delivery_window VARCHAR(255) NOT NULL,
  `order` INT NOT NULL,
  is_active TINYINT(1) NOT NULL
);

CREATE TABLE checkout_paymentselections (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  is_active TINYINT(1) NOT NULL
);

CREATE TABLE django_admin_log (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  object_id TEXT,
  object_repr VARCHAR(200) NOT NULL,
  action_flag SMALLINT UNSIGNED NOT NULL,
  change_message TEXT NOT NULL,
  content_type_id INT,
  user_id BIGINT NOT NULL,
  action_time DATETIME NOT NULL,
  FOREIGN KEY (content_type_id) REFERENCES django_content_type (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (user_id) REFERENCES account_customer (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE django_content_type (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  app_label VARCHAR(100) NOT NULL,
  model VARCHAR(100) NOT NULL
);

CREATE TABLE django_migrations (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  app VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  applied DATETIME NOT NULL
);

CREATE TABLE django_session (
  session_key VARCHAR(40) NOT NULL,
  session_data TEXT NOT NULL,
  expire_date DATETIME NOT NULL,
  PRIMARY KEY (session_key)
);

CREATE TABLE orders_order (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(50) NOT NULL,
  email VARCHAR(254) NOT NULL,
  address1 VARCHAR(250) NOT NULL,
  address2 VARCHAR(250) NOT NULL,
  city VARCHAR(100) NOT NULL,
  phone VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20) NOT NULL,
  country_code VARCHAR(4) NOT NULL,
  created DATETIME NOT NULL,
  updated DATETIME NOT NULL,
  total_paid DECIMAL(10, 2) NOT NULL,
  order_key VARCHAR(200) NOT NULL,
  payment_option VARCHAR(200) NOT NULL,
  billing_status TINYINT(1) NOT NULL,
  user_id BIGINT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES account_customer (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE orders_orderitem (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  price DECIMAL(10, 2) NOT NULL,
  quantity INT UNSIGNED NOT NULL,
  order_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders_order (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (product_id) REFERENCES store_product (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sponsor_sponsors (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  image VARCHAR(100) NOT NULL
);

CREATE TABLE store_category (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL,
  is_active TINYINT(1) NOT NULL,
  is_parent TINYINT(1) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  lft INT UNSIGNED NOT NULL,
  rght INT UNSIGNED NOT NULL,
  tree_id INT UNSIGNED NOT NULL,
  level INT UNSIGNED NOT NULL,
  parent_id BIGINT,
  FOREIGN KEY (parent_id) REFERENCES store_category (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE (name),
  UNIQUE (slug)
);

CREATE TABLE store_product (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  slug VARCHAR(255) NOT NULL,
  regular_price DECIMAL(10, 2) NOT NULL,
  discount_price DECIMAL(10, 2) NOT NULL,
  is_active TINYINT(1) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  category_id BIGINT NOT NULL,
  product_type_id BIGINT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES store_category (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (product_type_id) REFERENCES store_producttype (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE store_product_users_wishlist (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  customer_id BIGINT NOT NULL,
  FOREIGN KEY (product_id) REFERENCES store_product (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (customer_id) REFERENCES account_customer (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE store_productimage (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  alt_text VARCHAR(255),
  is_feature TINYINT(1) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  product_id BIGINT NOT NULL,
  image VARCHAR(100) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES store_product (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE store_productspecification (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  product_type_id BIGINT NOT NULL,
  FOREIGN KEY (product_type_id) REFERENCES store_producttype (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE store_productspecificationvalue (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  value VARCHAR(255) NOT NULL,
  product_id BIGINT NOT NULL,
  specification_id BIGINT NOT NULL,
  FOREIGN KEY (product_id) REFERENCES store_product (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (specification_id) REFERENCES store_productspecification (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE store_producttype (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  is_active TINYINT(1) NOT NULL,
  UNIQUE (name)
);

CREATE TABLE taggit_tag (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL,
  UNIQUE (name),
  UNIQUE (slug)
);

CREATE TABLE taggit_taggeditem (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  object_id INT NOT NULL,
  content_type_id INT NOT NULL,
  tag_id INT NOT NULL,
  FOREIGN KEY (content_type_id) REFERENCES django_content_type (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (tag_id) REFERENCES taggit_tag (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  UNIQUE (content_type_id, object_id, tag_id)
);

SET foreign_key_checks = 1;
