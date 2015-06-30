select CATEGNAME,MonthAgo0,MonthAgo1,MonthAgo2,MonthAgo3,MonthAgo4,MonthAgo5,MonthAgo6,MonthAgo7,MonthAgo8,TOTAL
	from CATEGORY_V1 as c
	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as Total
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-8 month')
		group by t.CATEGID
		order by Total desc ) as total
	on c.CATEGID=total.CATEGID

	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo0
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-0 month')
		group by t.CATEGID
		order by MonthAgo0 desc ) as m0
	on c.CATEGID=m0.CATEGID
	
	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo1
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-1 month') and t.TRANSDATE < date('now', 'start of month', '-0 month')
		group by t.CATEGID
		order by MonthAgo1 desc ) as m1
	on c.CATEGID=m1.CATEGID

	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo2
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-2 month') and t.TRANSDATE < date('now', 'start of month', '-1 month')
		group by t.CATEGID
		order by MonthAgo2 desc ) as m2
	on c.CATEGID=m2.CATEGID

	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo3
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-3 month') and t.TRANSDATE < date('now', 'start of month', '-2 month')
		group by t.CATEGID
		order by MonthAgo3 desc ) as m3
	on c.CATEGID=m3.CATEGID

	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo4
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-4 month') and t.TRANSDATE < date('now', 'start of month', '-3 month')
		group by t.CATEGID
		order by MonthAgo4 desc ) as m4
	on c.CATEGID=m4.CATEGID

	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo5
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-5 month') and t.TRANSDATE < date('now', 'start of month', '-4 month')
		group by t.CATEGID
		order by MonthAgo5 desc ) as m5
	on c.CATEGID=m5.CATEGID

	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo6
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-6 month') and t.TRANSDATE < date('now', 'start of month', '-5 month')
		group by t.CATEGID
		order by MonthAgo6 desc ) as m6
	on c.CATEGID=m6.CATEGID


	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo7
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-7 month') and t.TRANSDATE < date('now', 'start of month', '-6 month')
		group by t.CATEGID
		order by MonthAgo7 desc ) as m7
	on c.CATEGID=m7.CATEGID


	left join (
		select t.CATEGID, sum(t.TRANSAMOUNT * cf.BaseConvRate) as MonthAgo8
		from CHECKINGACCOUNT_V1 as t
		left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = t.ACCOUNTID
		left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
		where t.TRANSCODE='Withdrawal' and t.TRANSDATE >= date('now', 'start of month', '-8 month') and t.TRANSDATE < date('now', 'start of month', '-7 month')
		group by t.CATEGID
		order by MonthAgo8 desc ) as m8
	on c.CATEGID=m8.CATEGID

	where total>0
	order by TOTAL desc limit 15
	;
