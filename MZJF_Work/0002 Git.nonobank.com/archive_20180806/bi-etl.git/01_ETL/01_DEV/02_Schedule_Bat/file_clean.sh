echo "---------------- run loaddata start time:"` date +'%Y-%m-%d %H:%M:%S'`" ----------------"

     if [ $# -ge 1 ] ; then
     m_tmp=$1;
     m_date2=m_tmp;
     m_date=${m_tmp:0:4}"-"${m_tmp:4:2}"-"${m_tmp:6:2};
else
     m_date=`date --date="1 days ago" +%Y-%m-%d`;
     m_date1=`date --date="2 days ago" +%Y-%m-%d`;
     m_date_t=`date --date="0 days ago" +%Y-%m-%d`;
fi
## 删除消金库的log
cd /opt/data-integration/log

rm -rf *$m_date1*

echo "---------------- run loaddata start time:"` date +'%Y-%m-%d %H:%M:%S'`" ----------------"

     if [ $# -ge 1 ] ; then
     m_tmp=$1;
     m_date2=m_tmp;
     m_date=${m_tmp:0:4}"-"${m_tmp:4:2}"-"${m_tmp:6:2};
else
     m_date=`date --date="1 days ago" +%Y-%m-%d`;
     m_date1=`date --date="2 days ago" +%Y-%m-%d`;
     m_date_t=`date --date="0 days ago" +%Y-%m-%d`;
fi
## 删除db_nono库的log
cd /opt/data-integration/db_nono_log

rm -rf *$m_date1*

