-- ORDER BY is usually the last clause in your query, and it sorts the results returned by the rest of your query.
query = """
      SELECT ID, Name, Animal
      FROM `bigquery-public-data.pet_records.pets`
      ORDER BY ID
      """

-- The ORDER BY clause also works for columns containing text, where the results show up in alphabetical order.
query = """
      SELECT ID, Name, Animal
      FROM `bigquery-public-data.pet_records.pets`
      ORDER BY Animal
      """

-- You can reverse the order using the DESC argument (short for 'descending'). 
query = """
      SELECT ID, Name, Animal
      FROM `bigquery-public-data.pet_records.pets`
      ORDER BY Animal DESC
      """
      
/* Dates
There are two ways that dates can be stored in BigQuery: as a DATE or as a DATETIME.
The DATE format has the year first, then the month, and then the day. It looks like this:
YYYY-[M]M-[D]D
- YYYY: Four-digit year
- [M]M: One or two digit month
- [D]D: One or two digit day
So 2019-01-10 is interpreted as January 10, 2019.
The DATETIME format is like the date format ... but with time added at the end.
EXTRACT
The query below returns two columns, where column Day contains the day corresponding to 
each entry the Date column from the pets_with_date table: */

query = """
      SELECT Name, EXTRACT(DAY from Date) AS Day
      FROM `bigquery-public-data.pet_records.pets_with_date`      
      """

-- This query returns one column with just the week in the year (between 1 and 53) for each date in the Date column:
query = """
      SELECT Name, EXTRACT(WEEK from Date) AS Week
      FROM `bigquery-public-data.pet_records.pets_with_date`      
      """
      
-- https://cloud.google.com/bigquery/docs/reference/legacy-sql#datetimefunctions
