DROP TABLE IF EXISTS properties;
CREATE TABLE properties (
  id SERIAL8 PRIMARY KEY,
  address VARCHAR(255),
  value INT8,
  number_of_bedrooms INT2,
  buy_let_status BOOLEAN
);
