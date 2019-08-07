统计消费档次为低档、中档和高档人群点击广告的商品平均价格 (柱状图)

select case up.pvalue_level
        when '1' then '低档'
        when '2' then '中档'
        when '3' then '高档'
        else '其它' end as pvalue , avg(af.price) as avg_price
        from raw_sample_orc rs join user_profile up on rs.user_id = up.userid
        join ad_feature af on rs.adgroup_id = af.adgroup_id
        where rs.clk = 1  group by up.pvalue_level;



select time_stamp from behavior_log bl limit 10;
