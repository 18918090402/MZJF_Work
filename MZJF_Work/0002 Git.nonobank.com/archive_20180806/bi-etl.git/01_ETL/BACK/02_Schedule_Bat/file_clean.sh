echo "---------------- run loaddata start time:"` date +'%Y-%m-%d %H:%M:%S'`" ----------------"

     if [ $# -ge 1 ] ; then
     m_tmp=$1;
     m_date2=m_tmp;
     m_date=${m_tmp:0:4}"-"${m_tmp:4:2}"-"${m_tmp:6:2};
else
     m_date=`date --date="1 days ago" +%Y%m%d`;
     m_date1=`date --date="1 days ago" +%Y%m%d`;
     m_date_t=`date --date="0 days ago" +%Y%m%d`;
fi
## 删除消金库的log
cd /home/localadmin/ETL/03_ETL_LOG
echo *$m_date1*
rm -f /home/localadmin/ETL/03_ETL_LOG/*$m_date1*

