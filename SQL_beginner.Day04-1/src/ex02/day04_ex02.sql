CREATE VIEW v_generated_dates AS
SELECT date(generate_series('2022-01-01', '2022-01-31', '1 day'::interval)) 
AS generated_date
ORDER BY generated_date;

