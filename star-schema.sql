-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;

CREATE TABLE public."FactTrips"
(
    Tripid integer NOT NULL,
    Dateid integer NOT NULL,
    Stationid integer NOT NULL,
    Truckid integer NOT NULL,
    Wastecollected float NOT NULL,
    PRIMARY KEY (Tripid)
);
CREATE TABLE public."MyDimDate"
(
    Dateid integer NOT NULL,
    date DATE ,
    Year integer NOT NULL,
    Quarter integer NOT NULL,
    Quartername varchar(50) NOT NULL,
    Month integer NOT NULL,
    Monthname varchar(50) NOT NULL,
    Day integer NOT NULL,
    Weekday integer NOT NULL,
    WeekdayName varchar(50) NOT NULL,
    
    PRIMARY KEY (Dateid)
);

CREATE TABLE public."DimTruck"
(
    Truckid integer NOT NULL,
    TruckType varchar(50) NOT NULL,
    PRIMARY KEY (Truckid)
);

CREATE TABLE public."DimStation"
(
    Stationid integer NOT NULL,
    City varchar(50) NOT NULL,
    PRIMARY KEY (Stationid)
);

CREATE TABLE public."DimStation"
(
    Stationid integer NOT NULL,
    City varchar(50) NOT NULL,
    PRIMARY KEY (Stationid)
);

ALTER TABLE public."FactTrips"
    ADD FOREIGN KEY (Dateid)
    REFERENCES public."MyDimDate" (Dateid)
    NOT VALID;

ALTER TABLE public."FactTrips"
    ADD FOREIGN KEY (Truckid)
    REFERENCES public."DimTruck" (Truckid)
    NOT VALID;

ALTER TABLE public."FactTrips"
    ADD FOREIGN KEY (Stationid)
    REFERENCES public."DimStation" (Stationid)
    NOT VALID;

END;

select "FactTrips".Stationid,"DimTruck".TruckType,sum(Wastecollected) as totalWastecollected
from "FactTrips"
left join "DimStation"
on "FactTrips".Stationid = "DimStation".Stationid
left join "DimTruck"
on "FactTrips".Truckid="DimTruck".Truckid
group by grouping sets("FactTrips".Stationid,"DimTruck".TruckType)
order by "FactTrips".Stationid,"DimTruck".TruckType;

CREATE MATERIALIZED VIEW max_waste_stats1 (city, stationid, trucktype,max_waste_collected) AS
select "FactTrips".Stationid,"DimTruck".TruckType,city,max(Wastecollected) as max_waste_collected
from "FactTrips"
left join "DimStation"
on "FactTrips".Stationid = "DimStation".Stationid
left join "MyDimDate"
on "FactTrips".Dateid="MyDimDate".Dateid
left join "DimTruck"
on "FactTrips".Truckid="DimTruck".Truckid
group by ("FactTrips".Stationid,city,"DimTruck".TruckType)


CREATE TABLE public."MyDimWaste"
(
    Wasteid integer NOT NULL,
    Waste Type varchar(50) NOT NULL,
    wastecollected float NOT NULL,
    PRIMARY KEY (Wasteid)
);

CREATE TABLE public."MyDimZone"
(
    Zoneid integer NOT NULL,
    CollectedZone Type varchar(50) NOT NULL,
    City Type varchar(50) NOT NULL,
    PRIMARY KEY (Zoneid)
);