DROP TABLE IF EXISTS campusLocations CASCADE;
DROP TABLE IF EXISTS filters CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS menu CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS periods CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS storedPreferences CASCADE;
DROP TABLE IF EXISTS meal CASCADE;
DROP TABLE IF EXISTS favourites CASCADE;
--Hillcrest or Vanderberg ---
CREATE TABLE campusLocations(
    locationId INT PRIMARY KEY,
    locationName TEXT,
    startHours TIME,
    endHours TIME
    );
CREATE TABLE filters(
    filterId INT PRIMARY KEY,
    filterName TEXT
);
--Food items--   
CREATE TABLE items(
    itemId INT PRIMARY KEY,
    itemName TEXT,
    itemPortion TEXT,
    itemIngridents TEXT,
    itemNutrients TEXT,
    itemCalories INT,
    itemFilters INT REFERENCES filters(filterId)
    ON UPDATE CASCADE ON DELETE CASCADE
);
--Menu for a specific time period---   
CREATE TABLE menu(
    menuId INT PRIMARY KEY,
    menuDate DATE,
    menuName TEXT,
    fromDate DATE,
    toDate DATE,
    locationID INT REFERENCES campusLocations(locationId)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foodItem INT REFERENCES items(itemId)
    ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE categories(
    categoryId INT PRIMARY KEY,
    categoryName TEXT,
    categoryItems INT REFERENCES items(itemId)
    ON UPDATE CASCADE ON DELETE CASCADE
   );
--Brakfast, lunch, dinner, snack, late night--
CREATE TABLE periods(
    periodId INT PRIMARY KEY,
    periodName TEXT,
    periodCategory INT REFERENCES categories(categoryId)
    ON UPDATE CASCADE ON DELETE CASCADE
   );
--user account--
CREATE TABLE users(
    userIdToken VARCHAR,
    accesToken VARCHAR,
    userName TEXT,
    userLastName TEXT,
    userEmail TEXT,
    isAdmin BOOLEAN,
    primary key (userEmail)
);
--users preferences--
CREATE TABLE storedPreferences(
    preferenceId INT PRIMARY KEY,
    preferenceCalories TEXT ,
    preferenceNutrients TEXT,
    preferenceFilters INT REFERENCES filters(filterId)
    ON UPDATE CASCADE ON DELETE CASCADE
    userId text REFERENCES users(userEmail) 
    ON UPDATE CASCADE ON DELETE CASCADE);
    );
--daily meal with max 3 items--
CREATE TABLE meal(
    mealId INT PRIMARY KEY,
    foodItem1 INT REFERENCES items (itemId)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foodItem2 INT REFERENCES items (itemId)
    ON UPDATE CASCADE ON DELETE CASCADE,
    foodItem3 INT REFERENCES items (itemId)
    ON UPDATE CASCADE ON DELETE CASCADE,
    mealPeriod INT REFERENCES periods(periodId)
    ON UPDATE CASCADE ON DELETE CASCADE,
    mealName TEXT
);
--users saved favourites--
CREATE TABLE favourites(
    favoriteid SERIAL PRIMARY KEY,
    favouriteRecommendation INT REFERENCES meal(mealId) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    favouriteMeal INT REFERENCES meal(mealId) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    favouriteItem INT REFERENCES items(itemId) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    userEmail text REFERENCES users(userEmail) 
    ON UPDATE CASCADE ON DELETE CASCADE
    );

CREATE TABLE favouriteItems(
    id SERIAL PRIMARY KEY,
    userEmail TEXT REFERENCES users(userEmail) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    favouriteItem INT REFERENCES items(itemId) 
    ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE favouriteMeals(
    id SERIAL PRIMARY KEY,
    userId TEXT REFERENCES users(userEmail) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    favouriteMeal INT REFERENCES meal(mealId) 
    ON UPDATE CASCADE ON DELETE CASCADE
);
