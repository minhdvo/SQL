-- import BigQuery into Python
from google.cloud import bigquery

-- Create a 'Client' object. This Client object will play a central role in retrieving information from BigQuery datasets.
client = bigquery.Client()

/* Dataset of posts on Hacker News, a website focusing on computer science and cybersecurity news.
It is contained in the bigquery-public-data project
Construct a reference to the "hacker_news" dataset */
dataset_ref = client.dataset("hacker_news", project="bigquery-public-data")

-- API request - fetch the dataset
dataset = client.get_dataset(dataset_ref)

-- List all the tables in the "hacker_news" dataset
tables = list(client.list_tables(dataset))

-- Print names of all tables in the dataset (there are four!)
for table in tables:  
    print(table.table_id)

/* There are 4 tables in the dataset
comments
full
full_201510
stories*/

-- Construct a reference to the "full" table
table_ref = dataset_ref.table("full")

-- API request - fetch the table
table = client.get_table(table_ref)

/* Structure:
- Client objects hold projects and a connection to the BigQuery service.
- bigquery-public-data is a project (a collection of datasets).
- hacker_news is a dataset (a collection of tables - i.e. comments, full, full_201510 and stories are tables). 

Table schema (structure of a table) 
Print information on all the columns in the "full" table in the "hacker_news" dataset */
table.schema

/* Each SchemaField tells us about a specific column (which we also refer to as a field). In order, the information is:
- The name of the column
- The field type (or datatype) in the column
- The mode of the column ('NULLABLE' means that a column allows NULL values, and is the default)
- A description of the data in that column.

EX: SchemaField('by', 'string', 'NULLABLE', "The username of the item's author.",())
This tells us:
- the field (or column) is called by,
- the data in this field is strings,
- NULL values are allowed, and
- it contains the usernames corresponding to each item's author.

Preview the first five lines of the "full" table
- list_rows method: check first lines of a table
- to_dataframe: convert into pandas DataFrame */
client.list_rows(table, max_results=5).to_dataframe()

-- Preview the first five entries in the "by" column of the "full" table
client.list_rows(table, selected_fields=table.schema[:1], max_results=5).to_dataframe()
