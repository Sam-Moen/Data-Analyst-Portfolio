select * 
from SQLPortfolio.dbo.sephora_product_info

-- Single out skincare products, look into mousterizers and cleansers

select * 
from SQLPortfolio.dbo.sephora_product_info
where primary_category = 'Skincare';

-- Only select useful columns (for now)

select product_name, brand_name, loves_count, rating, reviews, size, ingredients, price_usd, highlights, primary_category, secondary_category, tertiary_category
from SQLPortfolio.dbo.sephora_product_info
where primary_category = 'Skincare';

-- convert size column to size_oz, and remove all non-skincare products

alter table SQLPortfolio.dbo.sephora_product_info
add size_oz float;

select size
from SQLPortfolio.dbo.sephora_product_info

select product_id ,product_name, brand_name, loves_count, rating, reviews, size, ingredients, price_usd, highlights, primary_category, secondary_category, tertiary_category
from SQLPortfolio.dbo.sephora_product_info
where size not like '%oz%' and  primary_category = 'Skincare' and secondary_category in ('Moisturizers','Cleansers')

--clean up to remove non-numeric symbols 

update SQLPortfolio.dbo.sephora_product_info
set size = '1.7 oz / 50 mL'
where product_id = 'P480301';

select * 
from SQLPortfolio.dbo.sephora_product_info
where product_id = 'P480301';

delete from SQLPortfolio.dbo.sephora_product_info
where size not like '%oz%' or size is NULL or primary_category <> 'Skincare';

select product_id ,product_name, brand_name, loves_count, rating, reviews, size, ingredients, price_usd, highlights, primary_category, secondary_category, tertiary_category
from SQLPortfolio.dbo.sephora_product_info

select SUBSTRING(size,1,CHARINDEX('o',size) -1), product_id ,product_name, brand_name, loves_count, rating, reviews, size, ingredients, price_usd, highlights, primary_category, secondary_category, tertiary_category
from SQLPortfolio.dbo.sephora_product_info
where size like '%fl%';

select distinct secondary_category
from SQLPortfolio.dbo.sephora_product_info;

select SUBSTRING(size,1,CHARINDEX('o',size) -1), product_id ,product_name, brand_name, loves_count, rating, reviews, size, ingredients, price_usd, highlights, primary_category, secondary_category, tertiary_category
from SQLPortfolio.dbo.sephora_product_info
where size like '%a%';

--remove unnecessary products

delete from SQLPortfolio.dbo.sephora_product_info
where secondary_category in ('Mini Size', 'Shop by Concern', 'Lip Balms & Treatments', 'Masks','Self Tanners', 'High Tech Tools', 'Value & Gift Sets', 'Wellness');

delete from SQLPortfolio.dbo.sephora_product_info
where limited_edition = 1;

--remove ending oz and fl oz, formatted like 'x ml/ y fl oz' instead of 'y fl oz/x ml'

select * from SQLPortfolio.dbo.sephora_product_info
where size like '%oz';

update SQLPortfolio.dbo.sephora_product_info
set size = SUBSTRING(size,1,CHARINDEX('o',size) -1)

select size, SUBSTRING(size,1,CHARINDEX('f',size) -1) from SQLPortfolio.dbo.sephora_product_info
where size like '%f%';

update SQLPortfolio.dbo.sephora_product_info
set size = SUBSTRING(size,CHARINDEX('/',size) +1,LEN(size))

update SQLPortfolio.dbo.sephora_product_info
set size = SUBSTRING(size,1,CHARINDEX('f',size) -1)
where size like '%f%';

select *
from SQLPortfolio.dbo.sephora_product_info
where size like '%%'

delete from SQLPortfolio.dbo.sephora_product_info
where size like '%a%' or size like '%x%'

update SQLPortfolio.dbo.sephora_product_info
set size = cast(size as float)
where size like '.%';

delete
from SQLPortfolio.dbo.sephora_product_info
where product_id = 'P416824';


update SQLPortfolio.dbo.sephora_product_info
set size_oz = size;

--drop unnecessary columns

select * 
from SQLPortfolio.dbo.sephora_product_info;

alter table SQLPortfolio.dbo.sephora_product_info
drop column size, variation_value, variation_desc, value_price_usd, sale_price_usd, limited_edition, new, out_of_stock, sephora_exclusive, child_count, child_min_price, child_max_price

alter table SQLPortfolio.dbo.sephora_product_info
drop column variation_type, primary_category

--some simple analysis, starting, what is the best bang for buck moisturizer (moisturizer with best dollar per ounce rating)

select product_name, brand_name, rating, reviews, loves_count, secondary_category, tertiary_category, price_usd, size_oz, (price_usd / size_oz) as dollars_per_oz
from SQLPortfolio.dbo.sephora_product_info
where secondary_category = 'Moisturizers' and tertiary_category <> 'Mists & Essences'
order by dollars_per_oz asc;

select product_name, brand_name, rating, reviews, loves_count, secondary_category, tertiary_category, price_usd, size_oz, (price_usd / size_oz) as dollars_per_oz, highlights
from SQLPortfolio.dbo.sephora_product_info
where secondary_category = 'Moisturizers' and tertiary_category = 'Face Oils' and reviews >= 50
order by rating desc;

--Best value brands?

select *
from SQLPortfolio.dbo.sephora_product_info


