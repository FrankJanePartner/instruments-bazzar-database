/*
 Navicat Premium Dump SQL

 Source Server         : mysqlite3
 Source Server Type    : SQLite
 Source Server Version : 3045000 (3.45.0)
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3045000 (3.45.0)
 File Encoding         : 65001

 Date: 20/05/2024 14:40:07
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for account_address
-- ----------------------------
DROP TABLE IF EXISTS "account_address";
CREATE TABLE "account_address" (
  "id" char(32) NOT NULL,
  "full_name" varchar(150) NOT NULL,
  "phone" varchar(50) NOT NULL,
  "postcode" varchar(50) NOT NULL,
  "address_line" varchar(255) NOT NULL,
  "address_line2" varchar(255) NOT NULL,
  "town_city" varchar(150) NOT NULL,
  "delivery_instructions" varchar(255) NOT NULL,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "default" bool NOT NULL,
  "customer_id" bigint NOT NULL,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("customer_id") REFERENCES "account_customer" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for account_customer
-- ----------------------------
DROP TABLE IF EXISTS "account_customer";
CREATE TABLE "account_customer" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "password" varchar(128) NOT NULL,
  "last_login" datetime,
  "is_superuser" bool NOT NULL,
  "email" varchar(254) NOT NULL,
  "first_name" varchar(100) NOT NULL,
  "last_name" varchar(100) NOT NULL,
  "is_active" bool NOT NULL,
  "is_staff" bool NOT NULL,
  UNIQUE ("email" ASC)
);

-- ----------------------------
-- Table structure for account_customer_groups
-- ----------------------------
DROP TABLE IF EXISTS "account_customer_groups";
CREATE TABLE "account_customer_groups" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "customer_id" bigint NOT NULL,
  "group_id" integer NOT NULL,
  FOREIGN KEY ("customer_id") REFERENCES "account_customer" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for account_customer_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS "account_customer_user_permissions";
CREATE TABLE "account_customer_user_permissions" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "customer_id" bigint NOT NULL,
  "permission_id" integer NOT NULL,
  FOREIGN KEY ("customer_id") REFERENCES "account_customer" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for account_otptoken
-- ----------------------------
DROP TABLE IF EXISTS "account_otptoken";
CREATE TABLE "account_otptoken" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "tp_created_at" datetime NOT NULL,
  "otp_expires_at" datetime,
  "user_id" bigint NOT NULL,
  "otp_code" varchar(6) NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "account_customer" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS "auth_group";
CREATE TABLE "auth_group" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(150) NOT NULL,
  UNIQUE ("name" ASC)
);

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS "auth_group_permissions";
CREATE TABLE "auth_group_permissions" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "group_id" integer NOT NULL,
  "permission_id" integer NOT NULL,
  FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS "auth_permission";
CREATE TABLE "auth_permission" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "content_type_id" integer NOT NULL,
  "codename" varchar(100) NOT NULL,
  "name" varchar(255) NOT NULL,
  FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for checkout_deliveryoptions
-- ----------------------------
DROP TABLE IF EXISTS "checkout_deliveryoptions";
CREATE TABLE "checkout_deliveryoptions" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "delivery_name" varchar(255) NOT NULL,
  "delivery_price" decimal NOT NULL,
  "delivery_method" varchar(255) NOT NULL,
  "delivery_timeframe" varchar(255) NOT NULL,
  "delivery_window" varchar(255) NOT NULL,
  "order" integer NOT NULL,
  "is_active" bool NOT NULL
);

-- ----------------------------
-- Table structure for checkout_paymentselections
-- ----------------------------
DROP TABLE IF EXISTS "checkout_paymentselections";
CREATE TABLE "checkout_paymentselections" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(255) NOT NULL,
  "is_active" bool NOT NULL
);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS "django_admin_log";
CREATE TABLE "django_admin_log" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "object_id" text,
  "object_repr" varchar(200) NOT NULL,
  "action_flag" smallint unsigned NOT NULL,
  "change_message" text NOT NULL,
  "content_type_id" integer,
  "user_id" bigint NOT NULL,
  "action_time" datetime NOT NULL,
  FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("user_id") REFERENCES "account_customer" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
   ("action_flag" >= 0)
);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS "django_content_type";
CREATE TABLE "django_content_type" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "app_label" varchar(100) NOT NULL,
  "model" varchar(100) NOT NULL
);

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS "django_migrations";
CREATE TABLE "django_migrations" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "app" varchar(255) NOT NULL,
  "name" varchar(255) NOT NULL,
  "applied" datetime NOT NULL
);

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS "django_session";
CREATE TABLE "django_session" (
  "session_key" varchar(40) NOT NULL,
  "session_data" text NOT NULL,
  "expire_date" datetime NOT NULL,
  PRIMARY KEY ("session_key")
);

-- ----------------------------
-- Table structure for orders_order
-- ----------------------------
DROP TABLE IF EXISTS "orders_order";
CREATE TABLE "orders_order" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "full_name" varchar(50) NOT NULL,
  "email" varchar(254) NOT NULL,
  "address1" varchar(250) NOT NULL,
  "address2" varchar(250) NOT NULL,
  "city" varchar(100) NOT NULL,
  "phone" varchar(100) NOT NULL,
  "postal_code" varchar(20) NOT NULL,
  "country_code" varchar(4) NOT NULL,
  "created" datetime NOT NULL,
  "updated" datetime NOT NULL,
  "total_paid" decimal NOT NULL,
  "order_key" varchar(200) NOT NULL,
  "payment_option" varchar(200) NOT NULL,
  "billing_status" bool NOT NULL,
  "user_id" bigint NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "account_customer" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for orders_orderitem
-- ----------------------------
DROP TABLE IF EXISTS "orders_orderitem";
CREATE TABLE "orders_orderitem" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "price" decimal NOT NULL,
  "quantity" integer unsigned NOT NULL,
  "order_id" bigint NOT NULL,
  "product_id" bigint NOT NULL,
  FOREIGN KEY ("order_id") REFERENCES "orders_order" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("product_id") REFERENCES "store_product" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
   ("quantity" >= 0)
);

-- ----------------------------
-- Table structure for sponsor_sponsors
-- ----------------------------
DROP TABLE IF EXISTS "sponsor_sponsors";
CREATE TABLE "sponsor_sponsors" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "image" varchar(100) NOT NULL
);

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "sqlite_sequence";
CREATE TABLE "sqlite_sequence" (
  "name",
  "seq"
);

-- ----------------------------
-- Table structure for store_category
-- ----------------------------
DROP TABLE IF EXISTS "store_category";
CREATE TABLE "store_category" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(255) NOT NULL,
  "slug" varchar(255) NOT NULL,
  "is_active" bool NOT NULL,
  "is_parent" bool NOT NULL,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "lft" integer unsigned NOT NULL,
  "rght" integer unsigned NOT NULL,
  "tree_id" integer unsigned NOT NULL,
  "level" integer unsigned NOT NULL,
  "parent_id" bigint,
  FOREIGN KEY ("parent_id") REFERENCES "store_category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  UNIQUE ("name" ASC),
  UNIQUE ("slug" ASC),
   ("lft" >= 0),
   ("rght" >= 0),
   ("tree_id" >= 0),
   ("level" >= 0)
);

-- ----------------------------
-- Table structure for store_product
-- ----------------------------
DROP TABLE IF EXISTS "store_product";
CREATE TABLE "store_product" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(255) NOT NULL,
  "description" text NOT NULL,
  "slug" varchar(255) NOT NULL,
  "regular_price" decimal NOT NULL,
  "discount_price" decimal NOT NULL,
  "is_active" bool NOT NULL,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "category_id" bigint NOT NULL,
  "product_type_id" bigint NOT NULL,
  FOREIGN KEY ("category_id") REFERENCES "store_category" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("product_type_id") REFERENCES "store_producttype" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for store_product_users_wishlist
-- ----------------------------
DROP TABLE IF EXISTS "store_product_users_wishlist";
CREATE TABLE "store_product_users_wishlist" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "product_id" bigint NOT NULL,
  "customer_id" bigint NOT NULL,
  FOREIGN KEY ("product_id") REFERENCES "store_product" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("customer_id") REFERENCES "account_customer" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for store_productimage
-- ----------------------------
DROP TABLE IF EXISTS "store_productimage";
CREATE TABLE "store_productimage" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "alt_text" varchar(255),
  "is_feature" bool NOT NULL,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "product_id" bigint NOT NULL,
  "image" varchar(100) NOT NULL,
  FOREIGN KEY ("product_id") REFERENCES "store_product" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for store_productspecification
-- ----------------------------
DROP TABLE IF EXISTS "store_productspecification";
CREATE TABLE "store_productspecification" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(255) NOT NULL,
  "product_type_id" bigint NOT NULL,
  FOREIGN KEY ("product_type_id") REFERENCES "store_producttype" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for store_productspecificationvalue
-- ----------------------------
DROP TABLE IF EXISTS "store_productspecificationvalue";
CREATE TABLE "store_productspecificationvalue" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "value" varchar(255) NOT NULL,
  "product_id" bigint NOT NULL,
  "specification_id" bigint NOT NULL,
  FOREIGN KEY ("product_id") REFERENCES "store_product" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("specification_id") REFERENCES "store_productspecification" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Table structure for store_producttype
-- ----------------------------
DROP TABLE IF EXISTS "store_producttype";
CREATE TABLE "store_producttype" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(255) NOT NULL,
  "is_active" bool NOT NULL,
  UNIQUE ("name" ASC)
);

-- ----------------------------
-- Table structure for taggit_tag
-- ----------------------------
DROP TABLE IF EXISTS "taggit_tag";
CREATE TABLE "taggit_tag" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(100) NOT NULL,
  "slug" varchar(100) NOT NULL,
  UNIQUE ("name" ASC),
  UNIQUE ("slug" ASC)
);

-- ----------------------------
-- Table structure for taggit_taggeditem
-- ----------------------------
DROP TABLE IF EXISTS "taggit_taggeditem";
CREATE TABLE "taggit_taggeditem" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "object_id" integer NOT NULL,
  "content_type_id" integer NOT NULL,
  "tag_id" integer NOT NULL,
  FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("tag_id") REFERENCES "taggit_tag" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  CONSTRAINT "taggit_taggeditem_content_type_id_object_id_tag_id_4bb97a8e_uniq" UNIQUE ("content_type_id" ASC, "object_id" ASC, "tag_id" ASC)
);

-- ----------------------------
-- Indexes structure for table account_address
-- ----------------------------
CREATE INDEX "account_address_customer_id_752e23ab"
ON "account_address" (
  "customer_id" ASC
);

-- ----------------------------
-- Auto increment value for account_customer
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 3 WHERE name = 'account_customer';

-- ----------------------------
-- Indexes structure for table account_customer_groups
-- ----------------------------
CREATE INDEX "account_customer_groups_customer_id_a98350d1"
ON "account_customer_groups" (
  "customer_id" ASC
);
CREATE UNIQUE INDEX "account_customer_groups_customer_id_group_id_d501b316_uniq"
ON "account_customer_groups" (
  "customer_id" ASC,
  "group_id" ASC
);
CREATE INDEX "account_customer_groups_group_id_c1cf6611"
ON "account_customer_groups" (
  "group_id" ASC
);

-- ----------------------------
-- Indexes structure for table account_customer_user_permissions
-- ----------------------------
CREATE INDEX "account_customer_user_permissions_customer_id_0eddb67e"
ON "account_customer_user_permissions" (
  "customer_id" ASC
);
CREATE UNIQUE INDEX "account_customer_user_permissions_customer_id_permission_id_05910c6f_uniq"
ON "account_customer_user_permissions" (
  "customer_id" ASC,
  "permission_id" ASC
);
CREATE INDEX "account_customer_user_permissions_permission_id_508cbdb1"
ON "account_customer_user_permissions" (
  "permission_id" ASC
);

-- ----------------------------
-- Auto increment value for account_otptoken
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 2 WHERE name = 'account_otptoken';

-- ----------------------------
-- Indexes structure for table account_otptoken
-- ----------------------------
CREATE INDEX "account_otptoken_user_id_05988488"
ON "account_otptoken" (
  "user_id" ASC
);

-- ----------------------------
-- Auto increment value for auth_group
-- ----------------------------

-- ----------------------------
-- Indexes structure for table auth_group_permissions
-- ----------------------------
CREATE INDEX "auth_group_permissions_group_id_b120cbf9"
ON "auth_group_permissions" (
  "group_id" ASC
);
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq"
ON "auth_group_permissions" (
  "group_id" ASC,
  "permission_id" ASC
);
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e"
ON "auth_group_permissions" (
  "permission_id" ASC
);

-- ----------------------------
-- Auto increment value for auth_permission
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 84 WHERE name = 'auth_permission';

-- ----------------------------
-- Indexes structure for table auth_permission
-- ----------------------------
CREATE INDEX "auth_permission_content_type_id_2f476e4b"
ON "auth_permission" (
  "content_type_id" ASC
);
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq"
ON "auth_permission" (
  "content_type_id" ASC,
  "codename" ASC
);

-- ----------------------------
-- Auto increment value for django_admin_log
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 20 WHERE name = 'django_admin_log';

-- ----------------------------
-- Indexes structure for table django_admin_log
-- ----------------------------
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb"
ON "django_admin_log" (
  "content_type_id" ASC
);
CREATE INDEX "django_admin_log_user_id_c564eba6"
ON "django_admin_log" (
  "user_id" ASC
);

-- ----------------------------
-- Auto increment value for django_content_type
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 21 WHERE name = 'django_content_type';

-- ----------------------------
-- Indexes structure for table django_content_type
-- ----------------------------
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq"
ON "django_content_type" (
  "app_label" ASC,
  "model" ASC
);

-- ----------------------------
-- Auto increment value for django_migrations
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 34 WHERE name = 'django_migrations';

-- ----------------------------
-- Indexes structure for table django_session
-- ----------------------------
CREATE INDEX "django_session_expire_date_a5c62663"
ON "django_session" (
  "expire_date" ASC
);

-- ----------------------------
-- Indexes structure for table orders_order
-- ----------------------------
CREATE INDEX "orders_order_user_id_e9b59eb1"
ON "orders_order" (
  "user_id" ASC
);

-- ----------------------------
-- Auto increment value for orders_orderitem
-- ----------------------------

-- ----------------------------
-- Indexes structure for table orders_orderitem
-- ----------------------------
CREATE INDEX "orders_orderitem_order_id_fe61a34d"
ON "orders_orderitem" (
  "order_id" ASC
);
CREATE INDEX "orders_orderitem_product_id_afe4254a"
ON "orders_orderitem" (
  "product_id" ASC
);

-- ----------------------------
-- Auto increment value for store_category
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 13 WHERE name = 'store_category';

-- ----------------------------
-- Indexes structure for table store_category
-- ----------------------------
CREATE INDEX "store_category_parent_id_a6e736ff"
ON "store_category" (
  "parent_id" ASC
);
CREATE INDEX "store_category_tree_id_e788f215"
ON "store_category" (
  "tree_id" ASC
);

-- ----------------------------
-- Indexes structure for table store_product
-- ----------------------------
CREATE INDEX "store_product_category_id_574bae65"
ON "store_product" (
  "category_id" ASC
);
CREATE INDEX "store_product_product_type_id_ba5a6252"
ON "store_product" (
  "product_type_id" ASC
);
CREATE INDEX "store_product_slug_6de8ee4b"
ON "store_product" (
  "slug" ASC
);

-- ----------------------------
-- Indexes structure for table store_product_users_wishlist
-- ----------------------------
CREATE INDEX "store_product_users_wishlist_customer_id_5c4da0f9"
ON "store_product_users_wishlist" (
  "customer_id" ASC
);
CREATE UNIQUE INDEX "store_product_users_wishlist_product_id_customer_id_eea55aaf_uniq"
ON "store_product_users_wishlist" (
  "product_id" ASC,
  "customer_id" ASC
);
CREATE INDEX "store_product_users_wishlist_product_id_dcd1a6b2"
ON "store_product_users_wishlist" (
  "product_id" ASC
);

-- ----------------------------
-- Auto increment value for store_productimage
-- ----------------------------

-- ----------------------------
-- Indexes structure for table store_productimage
-- ----------------------------
CREATE INDEX "store_productimage_product_id_e50e4046"
ON "store_productimage" (
  "product_id" ASC
);

-- ----------------------------
-- Auto increment value for store_productspecification
-- ----------------------------

-- ----------------------------
-- Indexes structure for table store_productspecification
-- ----------------------------
CREATE INDEX "store_productspecification_product_type_id_f0ff4c4b"
ON "store_productspecification" (
  "product_type_id" ASC
);

-- ----------------------------
-- Indexes structure for table store_productspecificationvalue
-- ----------------------------
CREATE INDEX "store_productspecificationvalue_product_id_12da60d4"
ON "store_productspecificationvalue" (
  "product_id" ASC
);
CREATE INDEX "store_productspecificationvalue_specification_id_61ba6b54"
ON "store_productspecificationvalue" (
  "specification_id" ASC
);

-- ----------------------------
-- Auto increment value for taggit_tag
-- ----------------------------

-- ----------------------------
-- Auto increment value for taggit_taggeditem
-- ----------------------------

-- ----------------------------
-- Indexes structure for table taggit_taggeditem
-- ----------------------------
CREATE INDEX "taggit_tagg_content_8fc721_idx"
ON "taggit_taggeditem" (
  "content_type_id" ASC,
  "object_id" ASC
);
CREATE INDEX "taggit_taggeditem_content_type_id_9957a03c"
ON "taggit_taggeditem" (
  "content_type_id" ASC
);
CREATE INDEX "taggit_taggeditem_object_id_e2d7d1df"
ON "taggit_taggeditem" (
  "object_id" ASC
);
CREATE INDEX "taggit_taggeditem_tag_id_f4f5b767"
ON "taggit_taggeditem" (
  "tag_id" ASC
);

PRAGMA foreign_keys = true;
