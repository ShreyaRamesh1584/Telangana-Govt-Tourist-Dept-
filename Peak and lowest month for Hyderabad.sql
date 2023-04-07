--Table shows the peak and low seasons for hyderabad for 2016-19 period
use [Codebasics_Telengana_Govt]
;
with data_16 as(
select dvs2016.month, dvs2016.visitors as dv16 ,fvs2016.visitors as fv16 from dbo.domestic_visitors_2016 as dvs2016
join dbo.foreign_visitors_2016 as fvs2016
on dvs2016.month=fvs2016.month
where dvs2016.district='Hyderabad' and fvs2016.district='Hyderabad'),

data_17 as (
select dvs2017.month, dvs2017.visitors as dv17, fvs2017.visitors as fv17 from dbo.domestic_visitors_2017 as dvs2017
join dbo.foreign_visitors_2017 as fvs2017
on dvs2017.month=fvs2017.month
where dvs2017.district='Hyderabad' and fvs2017.district='Hyderabad'),

data_18 as (
select dvs2018.month, dvs2018.visitors as dv18, fvs2018.visitors as fv18 from dbo.domestic_visitors_2018 as dvs2018
join dbo.foreign_visitors_2018 as fvs2018
on dvs2018.month=fvs2018.month
where dvs2018.district='Hyderabad' and fvs2018.district='Hyderabad'),

data_19 as(
select dvs2019.month, dvs2019.visitors as dv19, fvs2019.visitors as fv19 from dbo.domestic_visitors_2019 as dvs2019
join dbo.foreign_visitors_2019 as fvs2019
on dvs2019.month=fvs2019.month
where dvs2019.district='Hyderabad' and fvs2019.district='Hyderabad'),

a as(select month, dv16+fv16 as total_16 from data_16),
b as(select month, dv17+fv17 as total_17 from data_17),
c as(select month, dv18+fv18 as total_18 from data_18),
d as(select month, dv19+fv19 as total_19 from data_19)

select a.month, (total_16+total_17+total_18+total_19)/4 as average
from a
join b on a.month=b.month
join c on b.month=c.month
join d on c.month=d.month
order by average desc
-- June is the best month while February sees the least number of visitors on an average 
