Select SDSD_NAME,BRKS_CALL_SYS_NAME,BRKS_SYS_RETURN_CODE,BRKS_APP_RETURN_CODE,
avg((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 avg_in_ms, 
min((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 MIN_in_ms,
MAX((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 MAX_in_ms,
count(*) Count
From facets.CER_BRKS_BROKER_STATS
where
BRKS_BRKR_BEG_DTM > (sysdate -.5) 
and ((CAST(BRKS_BRKR_END_DTM AS DATE) - CAST(BRKS_BRKR_BEG_DTM AS DATE))*24*60*60) > 10
group by SDSD_NAME,BRKS_CALL_SYS_NAME,BRKS_SYS_RETURN_CODE,BRKS_APP_RETURN_CODE;



Select SDSD_NAME,
avg((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 avg_in_ms, 
min((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 MIN_in_ms,
MAX((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 MAX_in_ms,
count(*) Count
From facets.CER_BRKS_BROKER_STATS
where
BRKS_BRKR_BEG_DTM > (sysdate -1) and 
group by SDSD_NAME


Select SDSD_NAME,BRKS_CALL_SYS_NAME,BRKS_SYS_RETURN_CODE,BRKS_APP_RETURN_CODE,
avg((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 avg_in_ms, 
min((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 MIN_in_ms,
MAX((extract(hour from BRKS_BRKR_END_DTM)-extract(hour from BRKS_BRKR_BEG_DTM))*3600+
(extract(minute from BRKS_BRKR_END_DTM)-extract(minute from BRKS_BRKR_BEG_DTM))*60+
extract(second from BRKS_BRKR_END_DTM)-extract(second from BRKS_BRKR_BEG_DTM))*1000 MAX_in_ms,
count(*) Count
From facets.CER_BRKS_BROKER_STATS
where
BRKS_BRKR_BEG_DTM > (sysdate -1)
group by SDSD_NAME,BRKS_CALL_SYS_NAME,BRKS_SYS_RETURN_CODE,BRKS_APP_RETURN_CODE

select count(*) Count
From facets.CER_BRKS_BROKER_STATS
where
BRKS_BRKR_BEG_DTM > (sysdate -1)