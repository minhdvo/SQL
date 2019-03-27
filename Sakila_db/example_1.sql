/* PostgreSQL syntax */

/* 1. Finds the actor with most films */

SELECT first_name, last_name, count(*) films
FROM actor AS a
JOIN film_actor AS fa USING (actor_id)
GROUP BY actor_id, first_name, last_name
ORDER BY films DESC
LIMIT 1;

/* 2. Calculate the cumulative revenue of all stores */

SELECT payment_date, amount, sum(amount) OVER (ORDER BY payment_date)
FROM (
  SELECT CAST(payment_date AS DATE) AS payment_date, SUM(amount) AS amount
  FROM payment
  GROUP BY CAST(payment_date AS DATE)
) p
ORDER BY payment_date;
