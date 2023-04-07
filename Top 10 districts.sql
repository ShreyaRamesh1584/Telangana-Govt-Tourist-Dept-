--The table shows the top 10 districts that have the highest number of domestic visitors between 2016 and 2019
use [Codebasics_Telengana_Govt]
;
with a as (
select district,sum(visitors) as sum_for_2016 from dbo.domestic_visitors_2016
group by district ),
b as (
select district,sum(visitors) as sum_for_2017 from dbo.domestic_visitors_2017
group by district),
c as (
select district,sum(visitors) as sum_for_2018 from dbo.domestic_visitors_2018
group by district),
d as 
(select district,sum(visitors) as sum_for_2019 from dbo.domestic_visitors_2019
group by district),


e as (
select a.district, a.sum_for_2016, b.sum_for_2017, c.sum_for_2018, d.sum_for_2019
from a
join b
on a.district=b.district
join c 
on b.district=c.district
join d 
on c.district=d.district)

select e.district, [sum_for_2016]+[sum_for_2017]+[sum_for_2018]+[sum_for_2019] as sum_total
from e
order by sum_total desc

