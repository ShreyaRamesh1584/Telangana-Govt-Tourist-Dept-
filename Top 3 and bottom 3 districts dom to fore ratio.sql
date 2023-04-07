--To find the top 3 and bottom 3 districts based on domestic to foreign visitor ratio
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

domestic_visitors as (
select domestic_16.district as District, [sum_for_2016_domestic]+[sum_for_2017_domestic]+[sum_for_2018_domestic]+[sum_for_2019_domestic] as sum_domestic_visitors
from domestic_16 join domestic_17
on domestic_16.district=domestic_17.district
join domestic_18 on
domestic_17.district=domestic_18.district
join domestic_19 on
domestic_18.district=domestic_19.district),

foreign_visitors as (
select foreign_16.district as District, [sum_for_2016_foreign]+[sum_for_2017_foreign]+[sum_for_2018_foreign]+[sum_for_2019_foreign] as sum_foreign_visitors
from foreign_16 join foreign_17
on foreign_16.district=foreign_17.district
join foreign_18 on
foreign_17.district=foreign_18.district
join foreign_19 on
foreign_18.district=foreign_19.district)

select dvs.District, round(CAST(sum_domestic_visitors AS decimal)/sum_foreign_visitors,4) as ratio from domestic_visitors as dvs
join foreign_visitors as fvs on
dvs.District=fvs.District 
where sum_foreign_visitors not in (select sum_foreign_visitors from foreign_visitors where sum_foreign_visitors=0)
order by ratio desc





