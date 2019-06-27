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
