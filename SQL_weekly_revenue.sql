WITH registration AS (
  SELECT
    user_pseudo_id,
    DATE_TRUNC(MIN(PARSE_DATE('%Y%m%d', event_date)), WEEK) AS registration_week
  FROM `tc-da-1.turing_data_analytics.raw_events`
  GROUP BY user_pseudo_id
),

event_week_data AS (
  SELECT
    user_pseudo_id,
    DATE_TRUNC(PARSE_DATE('%Y%m%d', event_date), WEEK) AS event_week,
    purchase_revenue_in_usd
  FROM tc-da-1.turing_data_analytics.raw_events
)

SELECT 
  registration_week,
  ROUND(SUM(
    IF(reg.registration_week = events.event_week, events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4) 
    AS week_0,
  ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 1 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_1,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 2 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_2,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 3 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_3,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 4 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_4,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 5 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_5,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 6 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_6,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 7 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_7,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 8 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_8,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 9 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_9,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 10 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_10,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 11 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_11,
    ROUND(SUM(
    IF(events.event_week = DATE_ADD(reg.registration_week, INTERVAL 12 WEEK), events.purchase_revenue_in_usd, 0)) 
    / 
    COUNT(DISTINCT(events.user_pseudo_id)),4)  
    AS week_12,
FROM event_week_data AS events
  JOIN registration AS reg
  ON events.user_pseudo_id = reg.user_pseudo_id
WHERE 
  events.event_week < "2021-01-31"
GROUP BY registration_week
ORDER BY registration_week
