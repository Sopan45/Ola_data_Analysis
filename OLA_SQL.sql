-- creating a table "ola_data"
DROP TABLE IF EXISTS ola_data;
CREATE TABLE Ola_data
(
Ride_Date DATE,
Ride_Time TIME,
Booking_ID VARCHAR(20),
Booking_Status VARCHAR(30),
Customer_ID	VARCHAR(20),
Vehicle_Type VARCHAR(20),
Pickup_Location VARCHAR(30),
Drop_Location VARCHAR(30),
V_TAT INT,
C_TAT INT,
Canceled_Rides_by_Customer VARCHAR(80),
Canceled_Rides_by_Driver VARCHAR (80),
Incomplete_Rides VARCHAR(10),
Incomplete_Rides_Reason	VARCHAR(25),
Booking_Value INT,
Payment_Method VARCHAR (25),
Ride_Distance INT,
Driver_Ratings FLOAT,
Customer_Rating FLOAT
)
------------------------------
SELECT *FROM ola_data;
------------------------------
-- Questions to solve:
--1. Retrieve all successful bookings:
SELECT * FROM ola_data
WHERE booking_status= 'Success';
-- total 63967 rides booked successfully

--2. Find the average ride distance for each vehicle type:
SELECT vehicle_type, round(avg(ride_distance),3) FROM ola_data
group by vehicle_type
order by 2 desc;

--3. Get the total number of cancelled rides by customers:
SELECT count(*) FROM ola_data
WHERE booking_status='Canceled by Customer'
-- total 10499 customers cancelled their rides.

--4. List the top 5 customers who booked the highest number of rides:
SELECT customer_id, count(*) FROM ola_data
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;

--5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT COUNT(*) FROM ola_data
WHERE booking_status='Canceled by Driver' and 
Canceled_Rides_by_Driver='Personal & Car related issue'; -- 6542

--6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT vehicle_type,MAX(driver_ratings) as max_rating,MIN(driver_ratings) min_rating FROM ola_data
group by vehicle_type
HAVING vehicle_type='Prime Sedan'

--7. Retrieve all rides where payment was made using UPI:
SELECT * FROM ola_data
WHERE payment_method='UPI' --25881

--8. Find the average customer rating per vehicle type:
SELECT vehicle_type,CEIL(avg(customer_rating)) FROM ola_data
GROUP BY vehicle_type

--9. Calculate the total booking value of rides completed successfully:
SELECT SUM(booking_value) FROM ola_data 
WHERE booking_status='Success';
--35080467

--10. List all incomplete rides along with the reason
SELECT customer_id,canceled_rides_by_customer,canceled_rides_by_driver FROM ola_data
WHERE incomplete_rides='Yes';
