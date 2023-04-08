--The table shows the top 5 and bottom 5 districts based on tourist footfall to population ratio
use [Codebasics_Telengana_Govt]
;
with tel_popu as (
select Districts, Males+Females as population from dbo.Demographics),

domestic_19 as 
(select district,sum(visitors) as sum_for_2019_domestic from dbo.domestic_visitors_2019
group by district),
foreign_19 as (
select district,sum(visitors) as sum_for_2019_foreign from dbo.foreign_visitors_2019
group by district ),

visit_19 as (
select domestic_19.district, [sum_for_2019_domestic]+[sum_for_2019_foreign] as sum_2019
from domestic_19 join foreign_19
on domestic_19.district=foreign_19.district)

select visit_19.district, CAST(sum_2019 as decimal)/population as ratio from visit_19
join tel_popu on visit_19.district=tel_popu.Districts
order by ratio desc

