--To find the top 3 and bottom 3 districts intern of CAGR for the 4 years
use [Codebasics_Telengana_Govt]
;
with domestic_16 as (
select district,sum(visitors) as sum_for_2016_domestic from dbo.domestic_visitors_2016
group by district ),
domestic_17 as (
select district,sum(visitors) as sum_for_2017_domestic from dbo.domestic_visitors_2017
group by district),
domestic_18 as (
select district,sum(visitors) as sum_for_2018_domestic from dbo.domestic_visitors_2018
group by district),
domestic_19 as 
(select district,sum(visitors) as sum_for_2019_domestic from dbo.domestic_visitors_2019
group by district),

foreign_16 as (
select district,sum(visitors) as sum_for_2016_foreign from dbo.foreign_visitors_2016
group by district ),
foreign_17 as (
select district,sum(visitors) as sum_for_2017_foreign from dbo.foreign_visitors_2017
group by district ),
foreign_18 as (
select district,sum(visitors) as sum_for_2018_foreign from dbo.foreign_visitors_2018
group by district ),
foreign_19 as (
select district,sum(visitors) as sum_for_2019_foreign from dbo.foreign_visitors_2019
group by district ),

visit_16 as (
select domestic_16.district, [sum_for_2016_domestic]+[sum_for_2016_foreign] as sum_2016
from domestic_16 join foreign_16
on domestic_16.district=foreign_16.district),
visit_17 as (
select domestic_17.district, [sum_for_2017_domestic]+[sum_for_2017_foreign] as sum_2017
from domestic_17 join foreign_17
on domestic_17.district=foreign_17.district),
visit_18 as (
select domestic_18.district, [sum_for_2018_domestic]+[sum_for_2018_foreign] as sum_2018
from domestic_18 join foreign_18
on domestic_18.district=foreign_18.district),
visit_19 as (
select domestic_19.district, [sum_for_2019_domestic]+[sum_for_2019_foreign] as sum_2019
from domestic_19 join foreign_19
on domestic_19.district=foreign_19.district),


CAGR AS(
select visit_16.district, visit_16.sum_2016, visit_17.sum_2017, visit_18.sum_2018, visit_19.sum_2019
from visit_16 join visit_17
on visit_16.district=visit_17.district
join visit_18 on
visit_17.district=visit_18.district
join visit_19 on
visit_18.district=visit_19.district)

select district, 
round((-1+(sqrt(sqrt(CAST(sum_2019 AS decimal)/sum_2016)))),5)* 100 as CAGR_percent
from CAGR
where sum_2016 not in (select sum_2016 from visit_16 where sum_2016=0)
order by CAGR_percent desc
--Therefore the table shows Mancherial, Warangal(Rural) and Bhadradri Kothagudem as top 3 districs CAGR 
--The bottom 3 districts CAGR wise are: Warangal(Urban), Nalgonda, Karimnagar






