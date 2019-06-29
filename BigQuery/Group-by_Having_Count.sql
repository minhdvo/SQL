-- COUNT(), as you may have guessed from the name, returns a count of things. 
-- If you pass it the name of a column, it will return the number of entries in that column.
query = """
      SELECT COUNT(ID)
      FROM `bigquery-public-data.pet_records.pets`
      """
-- GROUP BY takes the name of one or more columns, and treats all rows with the same value 
-- in that column as a single group when you apply aggregate functions like COUNT().      
query = """
      SELECT Animal, COUNT(ID)
      FROM `bigquery-public-data.pet_records.pets`
      GROUP BY Animal
      """

-- Example
from google.cloud import bigquery

# Create a "Client" object
client = bigquery.Client()

# Construct a reference to the "hacker_news" dataset
dataset_ref = client.dataset("hacker_news", project="bigquery-public-data")

# API request - fetch the dataset
dataset = client.get_dataset(dataset_ref)

# Construct a reference to the "comments" table
table_ref = dataset_ref.table("comments")

# API request - fetch the table
table = client.get_table(table_ref)

# Preview the first five lines of the "comments" table
client.list_rows(table, max_results=5).to_dataframe()

# Query to select comments that received more than 10 replies
query_popular = """
                SELECT parent, COUNT(id)
                FROM `bigquery-public-data.hacker_news.comments`
                GROUP BY parent
                HAVING COUNT(id) > 10
                """

# Set up the query (cancel the query if it would use too much of 
# your quota, with the limit set to 10 GB)
safe_config = bigquery.QueryJobConfig(maximum_bytes_billed=10**10)
query_job = client.query(query_popular, job_config=safe_config)

# API request - run the query, and convert the results to a pandas DataFrame
popular_comments = query_job.to_dataframe()

# Print the first five rows of the DataFrame
popular_comments.head()

/* Aliasing and other improvements
A couple hints to make your queries even better:
The column resulting from COUNT(id) was called f0__. That's not a very descriptive name. 
You can change the name by adding AS NumPosts after you specify the aggregation. 
This is called aliasing.
If you are ever unsure what to put inside the COUNT() function, you can do COUNT(1) to count the rows in each group. 
Most people find it especially readable, because we know it's not focusing on other columns. 
It also scans less data than if supplied column names (making it faster and using less of your data access quota).*/

# Improved version of earlier query, now with aliasing & improved readability
query_improved = """
                 SELECT parent, COUNT(1) AS NumPosts
                 FROM `bigquery-public-data.hacker_news.comments`
                 GROUP BY parent
                 HAVING COUNT(1) > 10
                 """

safe_config = bigquery.QueryJobConfig(maximum_bytes_billed=10**10)
query_job = client.query(query_improved, job_config=safe_config)

# API request - run the query, and convert the results to a pandas DataFrame
improved_df = query_job.to_dataframe()

# Print the first five rows of the DataFrame
improved_df.head()

/* Note on using GROUP BY
Note that because it tells SQL how to apply aggregate functions (like COUNT()), it doesn't make 
sense to use GROUP BY without an aggregate function. 
Similarly, if you have any GROUP BY clause, then all variables must be passed to either a
-1- GROUP BY command, or
-2- an aggregation function.

query_good = """
             SELECT parent, COUNT(id)
             FROM `bigquery-public-data.hacker_news.comments`
             GROUP BY parent
             """
query_bad = """
            SELECT author, parent, COUNT(id)
            FROM `bigquery-public-data.hacker_news.comments`
            GROUP BY parent
            """             
-- this query won't work, because the author column isn't passed to an aggregate function or a GROUP BY clause.           
