# Ola Ride Data Analysis
#Objective: Analyze ride booking trends, cancellations, and revenue patterns.Identify top customers, vehicle performance, and payment behavior

create database Ola;
use Ola;

#Total number of rides
select count(Booking_ID)as total_number_of_Rides from olabookings;

#Total revenue
select sum(Booking_Value) as revenue from olabookings;

#Count rides by Booking_Status
select count(Booking_ID) as no_of_rides,Booking_Status from olabookings
group by Booking_Status ;

#Total customers
select count(distinct(Customer_ID))as total_customers from olabookings;

#Top 5 Repeat customers
select count(customer_id)as more_than_1_ride,customer_id from olabookings
group by customer_id
having count(customer_id)>1
order by more_than_1_ride desc
limit 5 ;

#Revenue per vehicle type
select sum(Booking_Value) as revenue,Vehicle_Type from olabookings
group by Vehicle_Type;

#Top 3 customers using window function
SELECT customer_id, SUM(Booking_Value) AS total_spent,
RANK() OVER (ORDER BY SUM(Booking_Value) DESC) AS rank_no
FROM olabookings
GROUP BY customer_id
order by total_spent desc
limit 3 ;

#Retrieve all successful bookings:
select Booking_ID,Booking_Status from olabookings
where Booking_Status ='Success';

#Find the average ride distance for each vehicle type:
select round(avg(Ride_Distance),2)as avg_distance,Vehicle_Type from olabookings
group by Vehicle_Type
order by avg_distance desc;

#Get the total number of cancelled rides by customers:
select count(Canceled_Rides_by_Customer) as cancelled_rides from olabookings;

#Get the number of rides cancelled by drivers due to personal and car-related issues:
select Booking_ID,Canceled_Rides_by_Driver from olabookings
where Canceled_Rides_by_Driver= 'Personal & Car related issue' ;

# Find the maximum and minimum driver ratings for Prime Sedan bookings:
select max(Driver_Ratings),min(Driver_Ratings),Vehicle_Type from olabookings
where Vehicle_Type= 'Prime Sedan';

#Retrieve all rides where payment was made using UPI:
select Booking_ID,Payment_Method from olabookings
where Payment_Method='UPI';

# Find the average customer rating per vehicle type:
select round(avg(Customer_Rating),2) as avg_customerRating,Vehicle_Type from olabookings
group by Vehicle_Type;

#Calculate the total booking value of rides completed successfully
select sum(Booking_Value) as total_booking_value,Booking_Status from olabookings
where Booking_Status='Success';

#List all incomplete rides along with the reason
SELECT Booking_ID, Incomplete_Rides_Reason FROM olabookings WHERE Incomplete_Rides =
'Yes';
