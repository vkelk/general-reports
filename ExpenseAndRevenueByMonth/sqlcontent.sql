select 
    'month' as periode_name,
    periode,
    sum(Deposit) as Deposit,
    sum(Withdrawal) as Withdrawal,
    round(sum(Deposit) + sum(Withdrawal),2) as Total,
    (
        (SELECT sum(initialbal) FROM accountlist_V1)
        +
	(
	    SELECT sum(totransamount) FROM checkingaccount_V1
	    where
                TRANSDATE <= date('now', 'start of month','-4 year','localtime')
	)
    ) as initialbal
from (  
    select 
        strftime('%Y-%m', c.TRANSDATE) as periode,
        case
            when c.transcode = 'Deposit' then c.transamount * cf.BaseConvRate
            else 0
        end as Deposit,
        case
          when c.transcode = 'Withdrawal' then -c.transamount * cf.BaseConvRate
          else 0
        end as Withdrawal
        --,*
    from
        checkingaccount_V1 c
	left join ACCOUNTLIST_V1 AC on AC.ACCOUNTID = c.ACCOUNTID
	left join currencyformats_v1 cf on cf.currencyid=AC.currencyid
    where
        c.TRANSDATE > date('now', 'start of month','-4 year','localtime')
        and c.status <>'V'
)
group by periode
order by periode asc
