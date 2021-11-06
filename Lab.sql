--task1
--a
select *
from dealer, client
where dealer.id=client.dealer_id;
--b
select dealer.id, client.name, client.priority, client.city, sell.id, sell.amount, sell.date
from (dealer join sell on dealer.id=sell.dealer_id) join client on dealer.id=client.dealer_id and sell.client_id=client.id ;
--с
select dealer.name, client.name, dealer.location, client.city
from dealer join client on dealer.location=client.city;
--d
select sell.id, sell.amount,client.name, client.city
from sell join client on sell.amount between 100 and 500;
--f
select client.name, client.city, dealer.name, dealer.charge
from dealer join client on dealer.id=client.dealer_id;
--g
select client.name, client.city, dealer.name, dealer.charge
from dealer join client on dealer.id=client.dealer_id and dealer.charge>0.12;
--task2
--a
create view v as
    select count( distinct client.id), avg(sell.amount), sum(sell.amount)
    from client,sell
    group by sell.date;
--b
create view v1 as
    select sum(sell.amount), sell.date
    from sell
    group by sell.date
    order by sum(sell.amount) desc limit 5;
--c
create view v2 as
    select dealer_id,count(id),sum(amount) as sum,avg(amount)
    from sell
    group by dealer_id;
--d
create view v3 as
    select dealer.name, dealer.location, sum(sell.amount*dealer.charge)
    from dealer,sell
    group by dealer.location, dealer.name;
--e
create view v4 as
    select count(sell.id),sum(sell.amount) as sum_sell,avg(sell.amount), dealer.location as dealer_loc
    from sell,dealer
    where sell.dealer_id=dealer.id
    group by dealer_loc;
--f
create view v5 as
    select count(sell.id),sum(sell.amount) as sum_exp,avg(sell.amount), client.city as client_city
    from sell,client
    where sell.client_id=client.id
    group by client_city;
--g
create view v6 as
    select client_city, sum_exp, sum_sell
    from v4,v5
    where dealer_loc=client_city and sum_exp>sum_sell;
