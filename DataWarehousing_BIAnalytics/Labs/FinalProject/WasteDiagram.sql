CREATE TABLE "myDimDate" (
  "dateId" integer PRIMARY KEY,
  "date" date,
  "day" integer,
  "month" integer,
  "year" integer,
  "weekdayInt" integer,
  "weekdayName" varchar,
  "monthInt" Integer,
  "monthName" varchar,
  "quarter" integer
);

CREATE TABLE "myDimWaste" (
  "wasteId" integer PRIMARY KEY,
  "wastetype" varchar
);

CREATE TABLE "myDimZone" (
  "zoneId" integer PRIMARY KEY,
  "collectionZone" varchar,
  "city" varchar
);

CREATE TABLE "myFactTrips" (
  "tripId" integer PRIMARY KEY,
  "wasteCollectedTons" "decimal(6, 2)",
  "dateId" integer,
  "wasteId" integer,
  "zoneId" integer,
  CONSTRAINT fk_dateId
    FOREIGN KEY(dateId)
    REFERENCES myDimDate(dateId),
  CONSTRAINT fk_wasteId
    FOREIGN KEY(wasteId)
    REFERENCES myDimWaste(wasteId),
  CONSTRAINT fk_zoneId
    FOREIGN KEY(zoneId)
    REFERENCES myDimZone(zoneId)
);

ALTER TABLE "myFactTrips" ADD FOREIGN KEY ("dateId") REFERENCES "myDimDate" ("dateId");

ALTER TABLE "myFactTrips" ADD FOREIGN KEY ("wasteId") REFERENCES "myDimWaste" ("wasteId");

ALTER TABLE "myFactTrips" ADD FOREIGN KEY ("zoneId") REFERENCES "myDimZone" ("zoneId");



-- The FOREIGN KEY (aka parent) column has to already exist in order to make it an FK. (So Dimensions before Facts)