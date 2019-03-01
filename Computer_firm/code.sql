/* 1. Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
Result set: model, speed, hd. */

select model, speed, hd 
from PC
where price < 500;


/* 2. List all printer makers. Result set: maker. */

select distinct maker 
from Product
where type='Printer';

/* 3. Find the model number, RAM and screen size of the laptops with prices over $1000.*/

Select model, ram, screen
from Laptop
where price > 1000


/* 4. Find all records from the Printer table containing data about color printers.*/

select *
from Printer
where color ='y'


/* Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.*/

select model, speed, hd
from PC
where price <600
and cd in ('12x','24x')


/* */
/* */
/* */
/* */
/* */
