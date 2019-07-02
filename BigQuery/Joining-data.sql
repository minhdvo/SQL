/* Example
pets table, which has three columns:
- ID : ID number for the pet
- Name : name of the pet
- Animal : type of animal

Another table, called owners. This table also has three columns:
- ID : ID number for the owner (different from the ID number for the pet)
- Name : name of the owner
- Pet_ID : ID number for the pet that belongs to the owner (which matches the ID number for the pet in the pets table)

To get information that applies to a certain pet, we match the ID column in the pets table to the Pet_ID column in the owners table. */

query = """
      SELECT  p.Name AS Pet_Name, o.Name AS Owner_Name
      FROM `bigquery-public-data.pet_records.pets` AS p
      INNER JOIN `bigquery-public-data.pet_records.owners` AS o
            ON p.ID = o.ID
      """

/* Information was combined from both tables by matching rows where the ID column in the pets table matches the Pet_ID column in the owners table.
In the query, ON determines which column in each table to use to combine the tables. Notice that since the ID column exists in both tables,
we have to clarify which one to use. 
We use p.ID to refer to the ID column from the pets table, and o.Pet_ID refers to the Pet_ID column from the owners table.

In general, when you're joining tables, it's a good habit to specify which table each of your columns comes from. 
That way, you don't have to pull up the schema every time you go back to read the query.

INNER JOIN: means that a row will only be put in the final output table if the value in the columns you're using to combine 
them shows up in both the tables you're joining. 
There are other types of JOIN, but an INNER JOIN is very widely used.
