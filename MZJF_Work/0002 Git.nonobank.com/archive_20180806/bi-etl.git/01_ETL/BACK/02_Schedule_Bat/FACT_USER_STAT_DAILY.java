// ORM class for table 'FACT_USER_STAT_DAILY'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Thu Jun 29 16:13:07 CST 2017
// For connector: org.apache.sqoop.manager.MySQLManager
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapred.lib.db.DBWritable;
import com.cloudera.sqoop.lib.JdbcWritableBridge;
import com.cloudera.sqoop.lib.DelimiterSet;
import com.cloudera.sqoop.lib.FieldFormatter;
import com.cloudera.sqoop.lib.RecordParser;
import com.cloudera.sqoop.lib.BooleanParser;
import com.cloudera.sqoop.lib.BlobRef;
import com.cloudera.sqoop.lib.ClobRef;
import com.cloudera.sqoop.lib.LargeObjectLoader;
import com.cloudera.sqoop.lib.SqoopRecord;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class FACT_USER_STAT_DAILY extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private Integer STAT_DATE;
  public Integer get_STAT_DATE() {
    return STAT_DATE;
  }
  public void set_STAT_DATE(Integer STAT_DATE) {
    this.STAT_DATE = STAT_DATE;
  }
  public FACT_USER_STAT_DAILY with_STAT_DATE(Integer STAT_DATE) {
    this.STAT_DATE = STAT_DATE;
    return this;
  }
  private Long USER_ID;
  public Long get_USER_ID() {
    return USER_ID;
  }
  public void set_USER_ID(Long USER_ID) {
    this.USER_ID = USER_ID;
  }
  public FACT_USER_STAT_DAILY with_USER_ID(Long USER_ID) {
    this.USER_ID = USER_ID;
    return this;
  }
  private String USER_NAME;
  public String get_USER_NAME() {
    return USER_NAME;
  }
  public void set_USER_NAME(String USER_NAME) {
    this.USER_NAME = USER_NAME;
  }
  public FACT_USER_STAT_DAILY with_USER_NAME(String USER_NAME) {
    this.USER_NAME = USER_NAME;
    return this;
  }
  private String REAL_NAME;
  public String get_REAL_NAME() {
    return REAL_NAME;
  }
  public void set_REAL_NAME(String REAL_NAME) {
    this.REAL_NAME = REAL_NAME;
  }
  public FACT_USER_STAT_DAILY with_REAL_NAME(String REAL_NAME) {
    this.REAL_NAME = REAL_NAME;
    return this;
  }
  private Integer IN_REPAYMENT_CNT;
  public Integer get_IN_REPAYMENT_CNT() {
    return IN_REPAYMENT_CNT;
  }
  public void set_IN_REPAYMENT_CNT(Integer IN_REPAYMENT_CNT) {
    this.IN_REPAYMENT_CNT = IN_REPAYMENT_CNT;
  }
  public FACT_USER_STAT_DAILY with_IN_REPAYMENT_CNT(Integer IN_REPAYMENT_CNT) {
    this.IN_REPAYMENT_CNT = IN_REPAYMENT_CNT;
    return this;
  }
  private Integer ALREADY_REPAYMENT_CNT;
  public Integer get_ALREADY_REPAYMENT_CNT() {
    return ALREADY_REPAYMENT_CNT;
  }
  public void set_ALREADY_REPAYMENT_CNT(Integer ALREADY_REPAYMENT_CNT) {
    this.ALREADY_REPAYMENT_CNT = ALREADY_REPAYMENT_CNT;
  }
  public FACT_USER_STAT_DAILY with_ALREADY_REPAYMENT_CNT(Integer ALREADY_REPAYMENT_CNT) {
    this.ALREADY_REPAYMENT_CNT = ALREADY_REPAYMENT_CNT;
    return this;
  }
  private String REJECT_CNT;
  public String get_REJECT_CNT() {
    return REJECT_CNT;
  }
  public void set_REJECT_CNT(String REJECT_CNT) {
    this.REJECT_CNT = REJECT_CNT;
  }
  public FACT_USER_STAT_DAILY with_REJECT_CNT(String REJECT_CNT) {
    this.REJECT_CNT = REJECT_CNT;
    return this;
  }
  private java.sql.Timestamp LAST_REJECT_TIME;
  public java.sql.Timestamp get_LAST_REJECT_TIME() {
    return LAST_REJECT_TIME;
  }
  public void set_LAST_REJECT_TIME(java.sql.Timestamp LAST_REJECT_TIME) {
    this.LAST_REJECT_TIME = LAST_REJECT_TIME;
  }
  public FACT_USER_STAT_DAILY with_LAST_REJECT_TIME(java.sql.Timestamp LAST_REJECT_TIME) {
    this.LAST_REJECT_TIME = LAST_REJECT_TIME;
    return this;
  }
  private Integer OVERDUE_LESS_7_DAY_CNT;
  public Integer get_OVERDUE_LESS_7_DAY_CNT() {
    return OVERDUE_LESS_7_DAY_CNT;
  }
  public void set_OVERDUE_LESS_7_DAY_CNT(Integer OVERDUE_LESS_7_DAY_CNT) {
    this.OVERDUE_LESS_7_DAY_CNT = OVERDUE_LESS_7_DAY_CNT;
  }
  public FACT_USER_STAT_DAILY with_OVERDUE_LESS_7_DAY_CNT(Integer OVERDUE_LESS_7_DAY_CNT) {
    this.OVERDUE_LESS_7_DAY_CNT = OVERDUE_LESS_7_DAY_CNT;
    return this;
  }
  private Integer OVERDUE_LESS_30_DAY_CNT;
  public Integer get_OVERDUE_LESS_30_DAY_CNT() {
    return OVERDUE_LESS_30_DAY_CNT;
  }
  public void set_OVERDUE_LESS_30_DAY_CNT(Integer OVERDUE_LESS_30_DAY_CNT) {
    this.OVERDUE_LESS_30_DAY_CNT = OVERDUE_LESS_30_DAY_CNT;
  }
  public FACT_USER_STAT_DAILY with_OVERDUE_LESS_30_DAY_CNT(Integer OVERDUE_LESS_30_DAY_CNT) {
    this.OVERDUE_LESS_30_DAY_CNT = OVERDUE_LESS_30_DAY_CNT;
    return this;
  }
  private Integer OVERDUE_LESS_60_DAY_CNT;
  public Integer get_OVERDUE_LESS_60_DAY_CNT() {
    return OVERDUE_LESS_60_DAY_CNT;
  }
  public void set_OVERDUE_LESS_60_DAY_CNT(Integer OVERDUE_LESS_60_DAY_CNT) {
    this.OVERDUE_LESS_60_DAY_CNT = OVERDUE_LESS_60_DAY_CNT;
  }
  public FACT_USER_STAT_DAILY with_OVERDUE_LESS_60_DAY_CNT(Integer OVERDUE_LESS_60_DAY_CNT) {
    this.OVERDUE_LESS_60_DAY_CNT = OVERDUE_LESS_60_DAY_CNT;
    return this;
  }
  private Integer OVERDUE_MORE_60_DAY_CNT;
  public Integer get_OVERDUE_MORE_60_DAY_CNT() {
    return OVERDUE_MORE_60_DAY_CNT;
  }
  public void set_OVERDUE_MORE_60_DAY_CNT(Integer OVERDUE_MORE_60_DAY_CNT) {
    this.OVERDUE_MORE_60_DAY_CNT = OVERDUE_MORE_60_DAY_CNT;
  }
  public FACT_USER_STAT_DAILY with_OVERDUE_MORE_60_DAY_CNT(Integer OVERDUE_MORE_60_DAY_CNT) {
    this.OVERDUE_MORE_60_DAY_CNT = OVERDUE_MORE_60_DAY_CNT;
    return this;
  }
  private java.math.BigDecimal MAX_BO_BRICE;
  public java.math.BigDecimal get_MAX_BO_BRICE() {
    return MAX_BO_BRICE;
  }
  public void set_MAX_BO_BRICE(java.math.BigDecimal MAX_BO_BRICE) {
    this.MAX_BO_BRICE = MAX_BO_BRICE;
  }
  public FACT_USER_STAT_DAILY with_MAX_BO_BRICE(java.math.BigDecimal MAX_BO_BRICE) {
    this.MAX_BO_BRICE = MAX_BO_BRICE;
    return this;
  }
  private Integer LOAN_MXD_BKB_CNT;
  public Integer get_LOAN_MXD_BKB_CNT() {
    return LOAN_MXD_BKB_CNT;
  }
  public void set_LOAN_MXD_BKB_CNT(Integer LOAN_MXD_BKB_CNT) {
    this.LOAN_MXD_BKB_CNT = LOAN_MXD_BKB_CNT;
  }
  public FACT_USER_STAT_DAILY with_LOAN_MXD_BKB_CNT(Integer LOAN_MXD_BKB_CNT) {
    this.LOAN_MXD_BKB_CNT = LOAN_MXD_BKB_CNT;
    return this;
  }
  private Integer LOAN_MXD_ZKB_CNT;
  public Integer get_LOAN_MXD_ZKB_CNT() {
    return LOAN_MXD_ZKB_CNT;
  }
  public void set_LOAN_MXD_ZKB_CNT(Integer LOAN_MXD_ZKB_CNT) {
    this.LOAN_MXD_ZKB_CNT = LOAN_MXD_ZKB_CNT;
  }
  public FACT_USER_STAT_DAILY with_LOAN_MXD_ZKB_CNT(Integer LOAN_MXD_ZKB_CNT) {
    this.LOAN_MXD_ZKB_CNT = LOAN_MXD_ZKB_CNT;
    return this;
  }
  private Integer LOAN_MXD_YJB_CNT;
  public Integer get_LOAN_MXD_YJB_CNT() {
    return LOAN_MXD_YJB_CNT;
  }
  public void set_LOAN_MXD_YJB_CNT(Integer LOAN_MXD_YJB_CNT) {
    this.LOAN_MXD_YJB_CNT = LOAN_MXD_YJB_CNT;
  }
  public FACT_USER_STAT_DAILY with_LOAN_MXD_YJB_CNT(Integer LOAN_MXD_YJB_CNT) {
    this.LOAN_MXD_YJB_CNT = LOAN_MXD_YJB_CNT;
    return this;
  }
  private Integer LOAN_MXD_BLB_CNT;
  public Integer get_LOAN_MXD_BLB_CNT() {
    return LOAN_MXD_BLB_CNT;
  }
  public void set_LOAN_MXD_BLB_CNT(Integer LOAN_MXD_BLB_CNT) {
    this.LOAN_MXD_BLB_CNT = LOAN_MXD_BLB_CNT;
  }
  public FACT_USER_STAT_DAILY with_LOAN_MXD_BLB_CNT(Integer LOAN_MXD_BLB_CNT) {
    this.LOAN_MXD_BLB_CNT = LOAN_MXD_BLB_CNT;
    return this;
  }
  private Integer LOAN_MYFQ_CNT;
  public Integer get_LOAN_MYFQ_CNT() {
    return LOAN_MYFQ_CNT;
  }
  public void set_LOAN_MYFQ_CNT(Integer LOAN_MYFQ_CNT) {
    this.LOAN_MYFQ_CNT = LOAN_MYFQ_CNT;
  }
  public FACT_USER_STAT_DAILY with_LOAN_MYFQ_CNT(Integer LOAN_MYFQ_CNT) {
    this.LOAN_MYFQ_CNT = LOAN_MYFQ_CNT;
    return this;
  }
  private Integer LOAN_USA_MXD_CNT;
  public Integer get_LOAN_USA_MXD_CNT() {
    return LOAN_USA_MXD_CNT;
  }
  public void set_LOAN_USA_MXD_CNT(Integer LOAN_USA_MXD_CNT) {
    this.LOAN_USA_MXD_CNT = LOAN_USA_MXD_CNT;
  }
  public FACT_USER_STAT_DAILY with_LOAN_USA_MXD_CNT(Integer LOAN_USA_MXD_CNT) {
    this.LOAN_USA_MXD_CNT = LOAN_USA_MXD_CNT;
    return this;
  }
  private Integer LOAN_UNIFI_XED_CNT;
  public Integer get_LOAN_UNIFI_XED_CNT() {
    return LOAN_UNIFI_XED_CNT;
  }
  public void set_LOAN_UNIFI_XED_CNT(Integer LOAN_UNIFI_XED_CNT) {
    this.LOAN_UNIFI_XED_CNT = LOAN_UNIFI_XED_CNT;
  }
  public FACT_USER_STAT_DAILY with_LOAN_UNIFI_XED_CNT(Integer LOAN_UNIFI_XED_CNT) {
    this.LOAN_UNIFI_XED_CNT = LOAN_UNIFI_XED_CNT;
    return this;
  }
  private Integer MLD_CREDIT_APPLY_CNT;
  public Integer get_MLD_CREDIT_APPLY_CNT() {
    return MLD_CREDIT_APPLY_CNT;
  }
  public void set_MLD_CREDIT_APPLY_CNT(Integer MLD_CREDIT_APPLY_CNT) {
    this.MLD_CREDIT_APPLY_CNT = MLD_CREDIT_APPLY_CNT;
  }
  public FACT_USER_STAT_DAILY with_MLD_CREDIT_APPLY_CNT(Integer MLD_CREDIT_APPLY_CNT) {
    this.MLD_CREDIT_APPLY_CNT = MLD_CREDIT_APPLY_CNT;
    return this;
  }
  private Integer MLD_BO_SUCCESS_CNT;
  public Integer get_MLD_BO_SUCCESS_CNT() {
    return MLD_BO_SUCCESS_CNT;
  }
  public void set_MLD_BO_SUCCESS_CNT(Integer MLD_BO_SUCCESS_CNT) {
    this.MLD_BO_SUCCESS_CNT = MLD_BO_SUCCESS_CNT;
  }
  public FACT_USER_STAT_DAILY with_MLD_BO_SUCCESS_CNT(Integer MLD_BO_SUCCESS_CNT) {
    this.MLD_BO_SUCCESS_CNT = MLD_BO_SUCCESS_CNT;
    return this;
  }
  private String REGISTER_TIME;
  public String get_REGISTER_TIME() {
    return REGISTER_TIME;
  }
  public void set_REGISTER_TIME(String REGISTER_TIME) {
    this.REGISTER_TIME = REGISTER_TIME;
  }
  public FACT_USER_STAT_DAILY with_REGISTER_TIME(String REGISTER_TIME) {
    this.REGISTER_TIME = REGISTER_TIME;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof FACT_USER_STAT_DAILY)) {
      return false;
    }
    FACT_USER_STAT_DAILY that = (FACT_USER_STAT_DAILY) o;
    boolean equal = true;
    equal = equal && (this.STAT_DATE == null ? that.STAT_DATE == null : this.STAT_DATE.equals(that.STAT_DATE));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.USER_NAME == null ? that.USER_NAME == null : this.USER_NAME.equals(that.USER_NAME));
    equal = equal && (this.REAL_NAME == null ? that.REAL_NAME == null : this.REAL_NAME.equals(that.REAL_NAME));
    equal = equal && (this.IN_REPAYMENT_CNT == null ? that.IN_REPAYMENT_CNT == null : this.IN_REPAYMENT_CNT.equals(that.IN_REPAYMENT_CNT));
    equal = equal && (this.ALREADY_REPAYMENT_CNT == null ? that.ALREADY_REPAYMENT_CNT == null : this.ALREADY_REPAYMENT_CNT.equals(that.ALREADY_REPAYMENT_CNT));
    equal = equal && (this.REJECT_CNT == null ? that.REJECT_CNT == null : this.REJECT_CNT.equals(that.REJECT_CNT));
    equal = equal && (this.LAST_REJECT_TIME == null ? that.LAST_REJECT_TIME == null : this.LAST_REJECT_TIME.equals(that.LAST_REJECT_TIME));
    equal = equal && (this.OVERDUE_LESS_7_DAY_CNT == null ? that.OVERDUE_LESS_7_DAY_CNT == null : this.OVERDUE_LESS_7_DAY_CNT.equals(that.OVERDUE_LESS_7_DAY_CNT));
    equal = equal && (this.OVERDUE_LESS_30_DAY_CNT == null ? that.OVERDUE_LESS_30_DAY_CNT == null : this.OVERDUE_LESS_30_DAY_CNT.equals(that.OVERDUE_LESS_30_DAY_CNT));
    equal = equal && (this.OVERDUE_LESS_60_DAY_CNT == null ? that.OVERDUE_LESS_60_DAY_CNT == null : this.OVERDUE_LESS_60_DAY_CNT.equals(that.OVERDUE_LESS_60_DAY_CNT));
    equal = equal && (this.OVERDUE_MORE_60_DAY_CNT == null ? that.OVERDUE_MORE_60_DAY_CNT == null : this.OVERDUE_MORE_60_DAY_CNT.equals(that.OVERDUE_MORE_60_DAY_CNT));
    equal = equal && (this.MAX_BO_BRICE == null ? that.MAX_BO_BRICE == null : this.MAX_BO_BRICE.equals(that.MAX_BO_BRICE));
    equal = equal && (this.LOAN_MXD_BKB_CNT == null ? that.LOAN_MXD_BKB_CNT == null : this.LOAN_MXD_BKB_CNT.equals(that.LOAN_MXD_BKB_CNT));
    equal = equal && (this.LOAN_MXD_ZKB_CNT == null ? that.LOAN_MXD_ZKB_CNT == null : this.LOAN_MXD_ZKB_CNT.equals(that.LOAN_MXD_ZKB_CNT));
    equal = equal && (this.LOAN_MXD_YJB_CNT == null ? that.LOAN_MXD_YJB_CNT == null : this.LOAN_MXD_YJB_CNT.equals(that.LOAN_MXD_YJB_CNT));
    equal = equal && (this.LOAN_MXD_BLB_CNT == null ? that.LOAN_MXD_BLB_CNT == null : this.LOAN_MXD_BLB_CNT.equals(that.LOAN_MXD_BLB_CNT));
    equal = equal && (this.LOAN_MYFQ_CNT == null ? that.LOAN_MYFQ_CNT == null : this.LOAN_MYFQ_CNT.equals(that.LOAN_MYFQ_CNT));
    equal = equal && (this.LOAN_USA_MXD_CNT == null ? that.LOAN_USA_MXD_CNT == null : this.LOAN_USA_MXD_CNT.equals(that.LOAN_USA_MXD_CNT));
    equal = equal && (this.LOAN_UNIFI_XED_CNT == null ? that.LOAN_UNIFI_XED_CNT == null : this.LOAN_UNIFI_XED_CNT.equals(that.LOAN_UNIFI_XED_CNT));
    equal = equal && (this.MLD_CREDIT_APPLY_CNT == null ? that.MLD_CREDIT_APPLY_CNT == null : this.MLD_CREDIT_APPLY_CNT.equals(that.MLD_CREDIT_APPLY_CNT));
    equal = equal && (this.MLD_BO_SUCCESS_CNT == null ? that.MLD_BO_SUCCESS_CNT == null : this.MLD_BO_SUCCESS_CNT.equals(that.MLD_BO_SUCCESS_CNT));
    equal = equal && (this.REGISTER_TIME == null ? that.REGISTER_TIME == null : this.REGISTER_TIME.equals(that.REGISTER_TIME));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof FACT_USER_STAT_DAILY)) {
      return false;
    }
    FACT_USER_STAT_DAILY that = (FACT_USER_STAT_DAILY) o;
    boolean equal = true;
    equal = equal && (this.STAT_DATE == null ? that.STAT_DATE == null : this.STAT_DATE.equals(that.STAT_DATE));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.USER_NAME == null ? that.USER_NAME == null : this.USER_NAME.equals(that.USER_NAME));
    equal = equal && (this.REAL_NAME == null ? that.REAL_NAME == null : this.REAL_NAME.equals(that.REAL_NAME));
    equal = equal && (this.IN_REPAYMENT_CNT == null ? that.IN_REPAYMENT_CNT == null : this.IN_REPAYMENT_CNT.equals(that.IN_REPAYMENT_CNT));
    equal = equal && (this.ALREADY_REPAYMENT_CNT == null ? that.ALREADY_REPAYMENT_CNT == null : this.ALREADY_REPAYMENT_CNT.equals(that.ALREADY_REPAYMENT_CNT));
    equal = equal && (this.REJECT_CNT == null ? that.REJECT_CNT == null : this.REJECT_CNT.equals(that.REJECT_CNT));
    equal = equal && (this.LAST_REJECT_TIME == null ? that.LAST_REJECT_TIME == null : this.LAST_REJECT_TIME.equals(that.LAST_REJECT_TIME));
    equal = equal && (this.OVERDUE_LESS_7_DAY_CNT == null ? that.OVERDUE_LESS_7_DAY_CNT == null : this.OVERDUE_LESS_7_DAY_CNT.equals(that.OVERDUE_LESS_7_DAY_CNT));
    equal = equal && (this.OVERDUE_LESS_30_DAY_CNT == null ? that.OVERDUE_LESS_30_DAY_CNT == null : this.OVERDUE_LESS_30_DAY_CNT.equals(that.OVERDUE_LESS_30_DAY_CNT));
    equal = equal && (this.OVERDUE_LESS_60_DAY_CNT == null ? that.OVERDUE_LESS_60_DAY_CNT == null : this.OVERDUE_LESS_60_DAY_CNT.equals(that.OVERDUE_LESS_60_DAY_CNT));
    equal = equal && (this.OVERDUE_MORE_60_DAY_CNT == null ? that.OVERDUE_MORE_60_DAY_CNT == null : this.OVERDUE_MORE_60_DAY_CNT.equals(that.OVERDUE_MORE_60_DAY_CNT));
    equal = equal && (this.MAX_BO_BRICE == null ? that.MAX_BO_BRICE == null : this.MAX_BO_BRICE.equals(that.MAX_BO_BRICE));
    equal = equal && (this.LOAN_MXD_BKB_CNT == null ? that.LOAN_MXD_BKB_CNT == null : this.LOAN_MXD_BKB_CNT.equals(that.LOAN_MXD_BKB_CNT));
    equal = equal && (this.LOAN_MXD_ZKB_CNT == null ? that.LOAN_MXD_ZKB_CNT == null : this.LOAN_MXD_ZKB_CNT.equals(that.LOAN_MXD_ZKB_CNT));
    equal = equal && (this.LOAN_MXD_YJB_CNT == null ? that.LOAN_MXD_YJB_CNT == null : this.LOAN_MXD_YJB_CNT.equals(that.LOAN_MXD_YJB_CNT));
    equal = equal && (this.LOAN_MXD_BLB_CNT == null ? that.LOAN_MXD_BLB_CNT == null : this.LOAN_MXD_BLB_CNT.equals(that.LOAN_MXD_BLB_CNT));
    equal = equal && (this.LOAN_MYFQ_CNT == null ? that.LOAN_MYFQ_CNT == null : this.LOAN_MYFQ_CNT.equals(that.LOAN_MYFQ_CNT));
    equal = equal && (this.LOAN_USA_MXD_CNT == null ? that.LOAN_USA_MXD_CNT == null : this.LOAN_USA_MXD_CNT.equals(that.LOAN_USA_MXD_CNT));
    equal = equal && (this.LOAN_UNIFI_XED_CNT == null ? that.LOAN_UNIFI_XED_CNT == null : this.LOAN_UNIFI_XED_CNT.equals(that.LOAN_UNIFI_XED_CNT));
    equal = equal && (this.MLD_CREDIT_APPLY_CNT == null ? that.MLD_CREDIT_APPLY_CNT == null : this.MLD_CREDIT_APPLY_CNT.equals(that.MLD_CREDIT_APPLY_CNT));
    equal = equal && (this.MLD_BO_SUCCESS_CNT == null ? that.MLD_BO_SUCCESS_CNT == null : this.MLD_BO_SUCCESS_CNT.equals(that.MLD_BO_SUCCESS_CNT));
    equal = equal && (this.REGISTER_TIME == null ? that.REGISTER_TIME == null : this.REGISTER_TIME.equals(that.REGISTER_TIME));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.STAT_DATE = JdbcWritableBridge.readInteger(1, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(2, __dbResults);
    this.USER_NAME = JdbcWritableBridge.readString(3, __dbResults);
    this.REAL_NAME = JdbcWritableBridge.readString(4, __dbResults);
    this.IN_REPAYMENT_CNT = JdbcWritableBridge.readInteger(5, __dbResults);
    this.ALREADY_REPAYMENT_CNT = JdbcWritableBridge.readInteger(6, __dbResults);
    this.REJECT_CNT = JdbcWritableBridge.readString(7, __dbResults);
    this.LAST_REJECT_TIME = JdbcWritableBridge.readTimestamp(8, __dbResults);
    this.OVERDUE_LESS_7_DAY_CNT = JdbcWritableBridge.readInteger(9, __dbResults);
    this.OVERDUE_LESS_30_DAY_CNT = JdbcWritableBridge.readInteger(10, __dbResults);
    this.OVERDUE_LESS_60_DAY_CNT = JdbcWritableBridge.readInteger(11, __dbResults);
    this.OVERDUE_MORE_60_DAY_CNT = JdbcWritableBridge.readInteger(12, __dbResults);
    this.MAX_BO_BRICE = JdbcWritableBridge.readBigDecimal(13, __dbResults);
    this.LOAN_MXD_BKB_CNT = JdbcWritableBridge.readInteger(14, __dbResults);
    this.LOAN_MXD_ZKB_CNT = JdbcWritableBridge.readInteger(15, __dbResults);
    this.LOAN_MXD_YJB_CNT = JdbcWritableBridge.readInteger(16, __dbResults);
    this.LOAN_MXD_BLB_CNT = JdbcWritableBridge.readInteger(17, __dbResults);
    this.LOAN_MYFQ_CNT = JdbcWritableBridge.readInteger(18, __dbResults);
    this.LOAN_USA_MXD_CNT = JdbcWritableBridge.readInteger(19, __dbResults);
    this.LOAN_UNIFI_XED_CNT = JdbcWritableBridge.readInteger(20, __dbResults);
    this.MLD_CREDIT_APPLY_CNT = JdbcWritableBridge.readInteger(21, __dbResults);
    this.MLD_BO_SUCCESS_CNT = JdbcWritableBridge.readInteger(22, __dbResults);
    this.REGISTER_TIME = JdbcWritableBridge.readString(23, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.STAT_DATE = JdbcWritableBridge.readInteger(1, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(2, __dbResults);
    this.USER_NAME = JdbcWritableBridge.readString(3, __dbResults);
    this.REAL_NAME = JdbcWritableBridge.readString(4, __dbResults);
    this.IN_REPAYMENT_CNT = JdbcWritableBridge.readInteger(5, __dbResults);
    this.ALREADY_REPAYMENT_CNT = JdbcWritableBridge.readInteger(6, __dbResults);
    this.REJECT_CNT = JdbcWritableBridge.readString(7, __dbResults);
    this.LAST_REJECT_TIME = JdbcWritableBridge.readTimestamp(8, __dbResults);
    this.OVERDUE_LESS_7_DAY_CNT = JdbcWritableBridge.readInteger(9, __dbResults);
    this.OVERDUE_LESS_30_DAY_CNT = JdbcWritableBridge.readInteger(10, __dbResults);
    this.OVERDUE_LESS_60_DAY_CNT = JdbcWritableBridge.readInteger(11, __dbResults);
    this.OVERDUE_MORE_60_DAY_CNT = JdbcWritableBridge.readInteger(12, __dbResults);
    this.MAX_BO_BRICE = JdbcWritableBridge.readBigDecimal(13, __dbResults);
    this.LOAN_MXD_BKB_CNT = JdbcWritableBridge.readInteger(14, __dbResults);
    this.LOAN_MXD_ZKB_CNT = JdbcWritableBridge.readInteger(15, __dbResults);
    this.LOAN_MXD_YJB_CNT = JdbcWritableBridge.readInteger(16, __dbResults);
    this.LOAN_MXD_BLB_CNT = JdbcWritableBridge.readInteger(17, __dbResults);
    this.LOAN_MYFQ_CNT = JdbcWritableBridge.readInteger(18, __dbResults);
    this.LOAN_USA_MXD_CNT = JdbcWritableBridge.readInteger(19, __dbResults);
    this.LOAN_UNIFI_XED_CNT = JdbcWritableBridge.readInteger(20, __dbResults);
    this.MLD_CREDIT_APPLY_CNT = JdbcWritableBridge.readInteger(21, __dbResults);
    this.MLD_BO_SUCCESS_CNT = JdbcWritableBridge.readInteger(22, __dbResults);
    this.REGISTER_TIME = JdbcWritableBridge.readString(23, __dbResults);
  }
  public void loadLargeObjects(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void loadLargeObjects0(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void write(PreparedStatement __dbStmt) throws SQLException {
    write(__dbStmt, 0);
  }

  public int write(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeInteger(STAT_DATE, 1 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeLong(USER_ID, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(USER_NAME, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(REAL_NAME, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(IN_REPAYMENT_CNT, 5 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(ALREADY_REPAYMENT_CNT, 6 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(REJECT_CNT, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(LAST_REJECT_TIME, 8 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_LESS_7_DAY_CNT, 9 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_LESS_30_DAY_CNT, 10 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_LESS_60_DAY_CNT, 11 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_MORE_60_DAY_CNT, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(MAX_BO_BRICE, 13 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MXD_BKB_CNT, 14 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MXD_ZKB_CNT, 15 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MXD_YJB_CNT, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MXD_BLB_CNT, 17 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MYFQ_CNT, 18 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_USA_MXD_CNT, 19 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_UNIFI_XED_CNT, 20 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(MLD_CREDIT_APPLY_CNT, 21 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(MLD_BO_SUCCESS_CNT, 22 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(REGISTER_TIME, 23 + __off, 12, __dbStmt);
    return 23;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeInteger(STAT_DATE, 1 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeLong(USER_ID, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(USER_NAME, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(REAL_NAME, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(IN_REPAYMENT_CNT, 5 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(ALREADY_REPAYMENT_CNT, 6 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(REJECT_CNT, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(LAST_REJECT_TIME, 8 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_LESS_7_DAY_CNT, 9 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_LESS_30_DAY_CNT, 10 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_LESS_60_DAY_CNT, 11 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_MORE_60_DAY_CNT, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(MAX_BO_BRICE, 13 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MXD_BKB_CNT, 14 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MXD_ZKB_CNT, 15 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MXD_YJB_CNT, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MXD_BLB_CNT, 17 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_MYFQ_CNT, 18 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_USA_MXD_CNT, 19 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(LOAN_UNIFI_XED_CNT, 20 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(MLD_CREDIT_APPLY_CNT, 21 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(MLD_BO_SUCCESS_CNT, 22 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(REGISTER_TIME, 23 + __off, 12, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.STAT_DATE = null;
    } else {
    this.STAT_DATE = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.USER_ID = null;
    } else {
    this.USER_ID = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.USER_NAME = null;
    } else {
    this.USER_NAME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REAL_NAME = null;
    } else {
    this.REAL_NAME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.IN_REPAYMENT_CNT = null;
    } else {
    this.IN_REPAYMENT_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.ALREADY_REPAYMENT_CNT = null;
    } else {
    this.ALREADY_REPAYMENT_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.REJECT_CNT = null;
    } else {
    this.REJECT_CNT = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.LAST_REJECT_TIME = null;
    } else {
    this.LAST_REJECT_TIME = new Timestamp(__dataIn.readLong());
    this.LAST_REJECT_TIME.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_LESS_7_DAY_CNT = null;
    } else {
    this.OVERDUE_LESS_7_DAY_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_LESS_30_DAY_CNT = null;
    } else {
    this.OVERDUE_LESS_30_DAY_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_LESS_60_DAY_CNT = null;
    } else {
    this.OVERDUE_LESS_60_DAY_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_MORE_60_DAY_CNT = null;
    } else {
    this.OVERDUE_MORE_60_DAY_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.MAX_BO_BRICE = null;
    } else {
    this.MAX_BO_BRICE = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.LOAN_MXD_BKB_CNT = null;
    } else {
    this.LOAN_MXD_BKB_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.LOAN_MXD_ZKB_CNT = null;
    } else {
    this.LOAN_MXD_ZKB_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.LOAN_MXD_YJB_CNT = null;
    } else {
    this.LOAN_MXD_YJB_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.LOAN_MXD_BLB_CNT = null;
    } else {
    this.LOAN_MXD_BLB_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.LOAN_MYFQ_CNT = null;
    } else {
    this.LOAN_MYFQ_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.LOAN_USA_MXD_CNT = null;
    } else {
    this.LOAN_USA_MXD_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.LOAN_UNIFI_XED_CNT = null;
    } else {
    this.LOAN_UNIFI_XED_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.MLD_CREDIT_APPLY_CNT = null;
    } else {
    this.MLD_CREDIT_APPLY_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.MLD_BO_SUCCESS_CNT = null;
    } else {
    this.MLD_BO_SUCCESS_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.REGISTER_TIME = null;
    } else {
    this.REGISTER_TIME = Text.readString(__dataIn);
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.STAT_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.STAT_DATE);
    }
    if (null == this.USER_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.USER_ID);
    }
    if (null == this.USER_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, USER_NAME);
    }
    if (null == this.REAL_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REAL_NAME);
    }
    if (null == this.IN_REPAYMENT_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.IN_REPAYMENT_CNT);
    }
    if (null == this.ALREADY_REPAYMENT_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ALREADY_REPAYMENT_CNT);
    }
    if (null == this.REJECT_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REJECT_CNT);
    }
    if (null == this.LAST_REJECT_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.LAST_REJECT_TIME.getTime());
    __dataOut.writeInt(this.LAST_REJECT_TIME.getNanos());
    }
    if (null == this.OVERDUE_LESS_7_DAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_LESS_7_DAY_CNT);
    }
    if (null == this.OVERDUE_LESS_30_DAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_LESS_30_DAY_CNT);
    }
    if (null == this.OVERDUE_LESS_60_DAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_LESS_60_DAY_CNT);
    }
    if (null == this.OVERDUE_MORE_60_DAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_MORE_60_DAY_CNT);
    }
    if (null == this.MAX_BO_BRICE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.MAX_BO_BRICE, __dataOut);
    }
    if (null == this.LOAN_MXD_BKB_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MXD_BKB_CNT);
    }
    if (null == this.LOAN_MXD_ZKB_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MXD_ZKB_CNT);
    }
    if (null == this.LOAN_MXD_YJB_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MXD_YJB_CNT);
    }
    if (null == this.LOAN_MXD_BLB_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MXD_BLB_CNT);
    }
    if (null == this.LOAN_MYFQ_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MYFQ_CNT);
    }
    if (null == this.LOAN_USA_MXD_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_USA_MXD_CNT);
    }
    if (null == this.LOAN_UNIFI_XED_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_UNIFI_XED_CNT);
    }
    if (null == this.MLD_CREDIT_APPLY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.MLD_CREDIT_APPLY_CNT);
    }
    if (null == this.MLD_BO_SUCCESS_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.MLD_BO_SUCCESS_CNT);
    }
    if (null == this.REGISTER_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REGISTER_TIME);
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.STAT_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.STAT_DATE);
    }
    if (null == this.USER_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.USER_ID);
    }
    if (null == this.USER_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, USER_NAME);
    }
    if (null == this.REAL_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REAL_NAME);
    }
    if (null == this.IN_REPAYMENT_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.IN_REPAYMENT_CNT);
    }
    if (null == this.ALREADY_REPAYMENT_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ALREADY_REPAYMENT_CNT);
    }
    if (null == this.REJECT_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REJECT_CNT);
    }
    if (null == this.LAST_REJECT_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.LAST_REJECT_TIME.getTime());
    __dataOut.writeInt(this.LAST_REJECT_TIME.getNanos());
    }
    if (null == this.OVERDUE_LESS_7_DAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_LESS_7_DAY_CNT);
    }
    if (null == this.OVERDUE_LESS_30_DAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_LESS_30_DAY_CNT);
    }
    if (null == this.OVERDUE_LESS_60_DAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_LESS_60_DAY_CNT);
    }
    if (null == this.OVERDUE_MORE_60_DAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_MORE_60_DAY_CNT);
    }
    if (null == this.MAX_BO_BRICE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.MAX_BO_BRICE, __dataOut);
    }
    if (null == this.LOAN_MXD_BKB_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MXD_BKB_CNT);
    }
    if (null == this.LOAN_MXD_ZKB_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MXD_ZKB_CNT);
    }
    if (null == this.LOAN_MXD_YJB_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MXD_YJB_CNT);
    }
    if (null == this.LOAN_MXD_BLB_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MXD_BLB_CNT);
    }
    if (null == this.LOAN_MYFQ_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_MYFQ_CNT);
    }
    if (null == this.LOAN_USA_MXD_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_USA_MXD_CNT);
    }
    if (null == this.LOAN_UNIFI_XED_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.LOAN_UNIFI_XED_CNT);
    }
    if (null == this.MLD_CREDIT_APPLY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.MLD_CREDIT_APPLY_CNT);
    }
    if (null == this.MLD_BO_SUCCESS_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.MLD_BO_SUCCESS_CNT);
    }
    if (null == this.REGISTER_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REGISTER_TIME);
    }
  }
  private static final DelimiterSet __outputDelimiters = new DelimiterSet((char) 44, (char) 10, (char) 0, (char) 0, false);
  public String toString() {
    return toString(__outputDelimiters, true);
  }
  public String toString(DelimiterSet delimiters) {
    return toString(delimiters, true);
  }
  public String toString(boolean useRecordDelim) {
    return toString(__outputDelimiters, useRecordDelim);
  }
  public String toString(DelimiterSet delimiters, boolean useRecordDelim) {
    StringBuilder __sb = new StringBuilder();
    char fieldDelim = delimiters.getFieldsTerminatedBy();
    __sb.append(FieldFormatter.escapeAndEnclose(STAT_DATE==null?"null":"" + STAT_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"null":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_NAME==null?"null":USER_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REAL_NAME==null?"null":REAL_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IN_REPAYMENT_CNT==null?"null":"" + IN_REPAYMENT_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ALREADY_REPAYMENT_CNT==null?"null":"" + ALREADY_REPAYMENT_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REJECT_CNT==null?"null":REJECT_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LAST_REJECT_TIME==null?"null":"" + LAST_REJECT_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_LESS_7_DAY_CNT==null?"null":"" + OVERDUE_LESS_7_DAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_LESS_30_DAY_CNT==null?"null":"" + OVERDUE_LESS_30_DAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_LESS_60_DAY_CNT==null?"null":"" + OVERDUE_LESS_60_DAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_MORE_60_DAY_CNT==null?"null":"" + OVERDUE_MORE_60_DAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MAX_BO_BRICE==null?"null":MAX_BO_BRICE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MXD_BKB_CNT==null?"null":"" + LOAN_MXD_BKB_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MXD_ZKB_CNT==null?"null":"" + LOAN_MXD_ZKB_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MXD_YJB_CNT==null?"null":"" + LOAN_MXD_YJB_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MXD_BLB_CNT==null?"null":"" + LOAN_MXD_BLB_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MYFQ_CNT==null?"null":"" + LOAN_MYFQ_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_USA_MXD_CNT==null?"null":"" + LOAN_USA_MXD_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_UNIFI_XED_CNT==null?"null":"" + LOAN_UNIFI_XED_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MLD_CREDIT_APPLY_CNT==null?"null":"" + MLD_CREDIT_APPLY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MLD_BO_SUCCESS_CNT==null?"null":"" + MLD_BO_SUCCESS_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REGISTER_TIME==null?"null":REGISTER_TIME, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(STAT_DATE==null?"null":"" + STAT_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"null":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_NAME==null?"null":USER_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REAL_NAME==null?"null":REAL_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IN_REPAYMENT_CNT==null?"null":"" + IN_REPAYMENT_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ALREADY_REPAYMENT_CNT==null?"null":"" + ALREADY_REPAYMENT_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REJECT_CNT==null?"null":REJECT_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LAST_REJECT_TIME==null?"null":"" + LAST_REJECT_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_LESS_7_DAY_CNT==null?"null":"" + OVERDUE_LESS_7_DAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_LESS_30_DAY_CNT==null?"null":"" + OVERDUE_LESS_30_DAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_LESS_60_DAY_CNT==null?"null":"" + OVERDUE_LESS_60_DAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_MORE_60_DAY_CNT==null?"null":"" + OVERDUE_MORE_60_DAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MAX_BO_BRICE==null?"null":MAX_BO_BRICE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MXD_BKB_CNT==null?"null":"" + LOAN_MXD_BKB_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MXD_ZKB_CNT==null?"null":"" + LOAN_MXD_ZKB_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MXD_YJB_CNT==null?"null":"" + LOAN_MXD_YJB_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MXD_BLB_CNT==null?"null":"" + LOAN_MXD_BLB_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_MYFQ_CNT==null?"null":"" + LOAN_MYFQ_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_USA_MXD_CNT==null?"null":"" + LOAN_USA_MXD_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LOAN_UNIFI_XED_CNT==null?"null":"" + LOAN_UNIFI_XED_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MLD_CREDIT_APPLY_CNT==null?"null":"" + MLD_CREDIT_APPLY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MLD_BO_SUCCESS_CNT==null?"null":"" + MLD_BO_SUCCESS_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REGISTER_TIME==null?"null":REGISTER_TIME, delimiters));
  }
  private static final DelimiterSet __inputDelimiters = new DelimiterSet((char) 1, (char) 10, (char) 0, (char) 0, false);
  private RecordParser __parser;
  public void parse(Text __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharSequence __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(byte [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(char [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(ByteBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  private void __loadFromFields(List<String> fields) {
    Iterator<String> __it = fields.listIterator();
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.STAT_DATE = null; } else {
      this.STAT_DATE = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.USER_NAME = null; } else {
      this.USER_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REAL_NAME = null; } else {
      this.REAL_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IN_REPAYMENT_CNT = null; } else {
      this.IN_REPAYMENT_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ALREADY_REPAYMENT_CNT = null; } else {
      this.ALREADY_REPAYMENT_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REJECT_CNT = null; } else {
      this.REJECT_CNT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LAST_REJECT_TIME = null; } else {
      this.LAST_REJECT_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_LESS_7_DAY_CNT = null; } else {
      this.OVERDUE_LESS_7_DAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_LESS_30_DAY_CNT = null; } else {
      this.OVERDUE_LESS_30_DAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_LESS_60_DAY_CNT = null; } else {
      this.OVERDUE_LESS_60_DAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_MORE_60_DAY_CNT = null; } else {
      this.OVERDUE_MORE_60_DAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.MAX_BO_BRICE = null; } else {
      this.MAX_BO_BRICE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MXD_BKB_CNT = null; } else {
      this.LOAN_MXD_BKB_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MXD_ZKB_CNT = null; } else {
      this.LOAN_MXD_ZKB_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MXD_YJB_CNT = null; } else {
      this.LOAN_MXD_YJB_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MXD_BLB_CNT = null; } else {
      this.LOAN_MXD_BLB_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MYFQ_CNT = null; } else {
      this.LOAN_MYFQ_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_USA_MXD_CNT = null; } else {
      this.LOAN_USA_MXD_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_UNIFI_XED_CNT = null; } else {
      this.LOAN_UNIFI_XED_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.MLD_CREDIT_APPLY_CNT = null; } else {
      this.MLD_CREDIT_APPLY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.MLD_BO_SUCCESS_CNT = null; } else {
      this.MLD_BO_SUCCESS_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REGISTER_TIME = null; } else {
      this.REGISTER_TIME = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.STAT_DATE = null; } else {
      this.STAT_DATE = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.USER_NAME = null; } else {
      this.USER_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REAL_NAME = null; } else {
      this.REAL_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IN_REPAYMENT_CNT = null; } else {
      this.IN_REPAYMENT_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ALREADY_REPAYMENT_CNT = null; } else {
      this.ALREADY_REPAYMENT_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REJECT_CNT = null; } else {
      this.REJECT_CNT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LAST_REJECT_TIME = null; } else {
      this.LAST_REJECT_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_LESS_7_DAY_CNT = null; } else {
      this.OVERDUE_LESS_7_DAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_LESS_30_DAY_CNT = null; } else {
      this.OVERDUE_LESS_30_DAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_LESS_60_DAY_CNT = null; } else {
      this.OVERDUE_LESS_60_DAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_MORE_60_DAY_CNT = null; } else {
      this.OVERDUE_MORE_60_DAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.MAX_BO_BRICE = null; } else {
      this.MAX_BO_BRICE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MXD_BKB_CNT = null; } else {
      this.LOAN_MXD_BKB_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MXD_ZKB_CNT = null; } else {
      this.LOAN_MXD_ZKB_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MXD_YJB_CNT = null; } else {
      this.LOAN_MXD_YJB_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MXD_BLB_CNT = null; } else {
      this.LOAN_MXD_BLB_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_MYFQ_CNT = null; } else {
      this.LOAN_MYFQ_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_USA_MXD_CNT = null; } else {
      this.LOAN_USA_MXD_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.LOAN_UNIFI_XED_CNT = null; } else {
      this.LOAN_UNIFI_XED_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.MLD_CREDIT_APPLY_CNT = null; } else {
      this.MLD_CREDIT_APPLY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.MLD_BO_SUCCESS_CNT = null; } else {
      this.MLD_BO_SUCCESS_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REGISTER_TIME = null; } else {
      this.REGISTER_TIME = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    FACT_USER_STAT_DAILY o = (FACT_USER_STAT_DAILY) super.clone();
    o.LAST_REJECT_TIME = (o.LAST_REJECT_TIME != null) ? (java.sql.Timestamp) o.LAST_REJECT_TIME.clone() : null;
    return o;
  }

  public void clone0(FACT_USER_STAT_DAILY o) throws CloneNotSupportedException {
    o.LAST_REJECT_TIME = (o.LAST_REJECT_TIME != null) ? (java.sql.Timestamp) o.LAST_REJECT_TIME.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("STAT_DATE", this.STAT_DATE);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("USER_NAME", this.USER_NAME);
    __sqoop$field_map.put("REAL_NAME", this.REAL_NAME);
    __sqoop$field_map.put("IN_REPAYMENT_CNT", this.IN_REPAYMENT_CNT);
    __sqoop$field_map.put("ALREADY_REPAYMENT_CNT", this.ALREADY_REPAYMENT_CNT);
    __sqoop$field_map.put("REJECT_CNT", this.REJECT_CNT);
    __sqoop$field_map.put("LAST_REJECT_TIME", this.LAST_REJECT_TIME);
    __sqoop$field_map.put("OVERDUE_LESS_7_DAY_CNT", this.OVERDUE_LESS_7_DAY_CNT);
    __sqoop$field_map.put("OVERDUE_LESS_30_DAY_CNT", this.OVERDUE_LESS_30_DAY_CNT);
    __sqoop$field_map.put("OVERDUE_LESS_60_DAY_CNT", this.OVERDUE_LESS_60_DAY_CNT);
    __sqoop$field_map.put("OVERDUE_MORE_60_DAY_CNT", this.OVERDUE_MORE_60_DAY_CNT);
    __sqoop$field_map.put("MAX_BO_BRICE", this.MAX_BO_BRICE);
    __sqoop$field_map.put("LOAN_MXD_BKB_CNT", this.LOAN_MXD_BKB_CNT);
    __sqoop$field_map.put("LOAN_MXD_ZKB_CNT", this.LOAN_MXD_ZKB_CNT);
    __sqoop$field_map.put("LOAN_MXD_YJB_CNT", this.LOAN_MXD_YJB_CNT);
    __sqoop$field_map.put("LOAN_MXD_BLB_CNT", this.LOAN_MXD_BLB_CNT);
    __sqoop$field_map.put("LOAN_MYFQ_CNT", this.LOAN_MYFQ_CNT);
    __sqoop$field_map.put("LOAN_USA_MXD_CNT", this.LOAN_USA_MXD_CNT);
    __sqoop$field_map.put("LOAN_UNIFI_XED_CNT", this.LOAN_UNIFI_XED_CNT);
    __sqoop$field_map.put("MLD_CREDIT_APPLY_CNT", this.MLD_CREDIT_APPLY_CNT);
    __sqoop$field_map.put("MLD_BO_SUCCESS_CNT", this.MLD_BO_SUCCESS_CNT);
    __sqoop$field_map.put("REGISTER_TIME", this.REGISTER_TIME);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("STAT_DATE", this.STAT_DATE);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("USER_NAME", this.USER_NAME);
    __sqoop$field_map.put("REAL_NAME", this.REAL_NAME);
    __sqoop$field_map.put("IN_REPAYMENT_CNT", this.IN_REPAYMENT_CNT);
    __sqoop$field_map.put("ALREADY_REPAYMENT_CNT", this.ALREADY_REPAYMENT_CNT);
    __sqoop$field_map.put("REJECT_CNT", this.REJECT_CNT);
    __sqoop$field_map.put("LAST_REJECT_TIME", this.LAST_REJECT_TIME);
    __sqoop$field_map.put("OVERDUE_LESS_7_DAY_CNT", this.OVERDUE_LESS_7_DAY_CNT);
    __sqoop$field_map.put("OVERDUE_LESS_30_DAY_CNT", this.OVERDUE_LESS_30_DAY_CNT);
    __sqoop$field_map.put("OVERDUE_LESS_60_DAY_CNT", this.OVERDUE_LESS_60_DAY_CNT);
    __sqoop$field_map.put("OVERDUE_MORE_60_DAY_CNT", this.OVERDUE_MORE_60_DAY_CNT);
    __sqoop$field_map.put("MAX_BO_BRICE", this.MAX_BO_BRICE);
    __sqoop$field_map.put("LOAN_MXD_BKB_CNT", this.LOAN_MXD_BKB_CNT);
    __sqoop$field_map.put("LOAN_MXD_ZKB_CNT", this.LOAN_MXD_ZKB_CNT);
    __sqoop$field_map.put("LOAN_MXD_YJB_CNT", this.LOAN_MXD_YJB_CNT);
    __sqoop$field_map.put("LOAN_MXD_BLB_CNT", this.LOAN_MXD_BLB_CNT);
    __sqoop$field_map.put("LOAN_MYFQ_CNT", this.LOAN_MYFQ_CNT);
    __sqoop$field_map.put("LOAN_USA_MXD_CNT", this.LOAN_USA_MXD_CNT);
    __sqoop$field_map.put("LOAN_UNIFI_XED_CNT", this.LOAN_UNIFI_XED_CNT);
    __sqoop$field_map.put("MLD_CREDIT_APPLY_CNT", this.MLD_CREDIT_APPLY_CNT);
    __sqoop$field_map.put("MLD_BO_SUCCESS_CNT", this.MLD_BO_SUCCESS_CNT);
    __sqoop$field_map.put("REGISTER_TIME", this.REGISTER_TIME);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("STAT_DATE".equals(__fieldName)) {
      this.STAT_DATE = (Integer) __fieldVal;
    }
    else    if ("USER_ID".equals(__fieldName)) {
      this.USER_ID = (Long) __fieldVal;
    }
    else    if ("USER_NAME".equals(__fieldName)) {
      this.USER_NAME = (String) __fieldVal;
    }
    else    if ("REAL_NAME".equals(__fieldName)) {
      this.REAL_NAME = (String) __fieldVal;
    }
    else    if ("IN_REPAYMENT_CNT".equals(__fieldName)) {
      this.IN_REPAYMENT_CNT = (Integer) __fieldVal;
    }
    else    if ("ALREADY_REPAYMENT_CNT".equals(__fieldName)) {
      this.ALREADY_REPAYMENT_CNT = (Integer) __fieldVal;
    }
    else    if ("REJECT_CNT".equals(__fieldName)) {
      this.REJECT_CNT = (String) __fieldVal;
    }
    else    if ("LAST_REJECT_TIME".equals(__fieldName)) {
      this.LAST_REJECT_TIME = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("OVERDUE_LESS_7_DAY_CNT".equals(__fieldName)) {
      this.OVERDUE_LESS_7_DAY_CNT = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_LESS_30_DAY_CNT".equals(__fieldName)) {
      this.OVERDUE_LESS_30_DAY_CNT = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_LESS_60_DAY_CNT".equals(__fieldName)) {
      this.OVERDUE_LESS_60_DAY_CNT = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_MORE_60_DAY_CNT".equals(__fieldName)) {
      this.OVERDUE_MORE_60_DAY_CNT = (Integer) __fieldVal;
    }
    else    if ("MAX_BO_BRICE".equals(__fieldName)) {
      this.MAX_BO_BRICE = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("LOAN_MXD_BKB_CNT".equals(__fieldName)) {
      this.LOAN_MXD_BKB_CNT = (Integer) __fieldVal;
    }
    else    if ("LOAN_MXD_ZKB_CNT".equals(__fieldName)) {
      this.LOAN_MXD_ZKB_CNT = (Integer) __fieldVal;
    }
    else    if ("LOAN_MXD_YJB_CNT".equals(__fieldName)) {
      this.LOAN_MXD_YJB_CNT = (Integer) __fieldVal;
    }
    else    if ("LOAN_MXD_BLB_CNT".equals(__fieldName)) {
      this.LOAN_MXD_BLB_CNT = (Integer) __fieldVal;
    }
    else    if ("LOAN_MYFQ_CNT".equals(__fieldName)) {
      this.LOAN_MYFQ_CNT = (Integer) __fieldVal;
    }
    else    if ("LOAN_USA_MXD_CNT".equals(__fieldName)) {
      this.LOAN_USA_MXD_CNT = (Integer) __fieldVal;
    }
    else    if ("LOAN_UNIFI_XED_CNT".equals(__fieldName)) {
      this.LOAN_UNIFI_XED_CNT = (Integer) __fieldVal;
    }
    else    if ("MLD_CREDIT_APPLY_CNT".equals(__fieldName)) {
      this.MLD_CREDIT_APPLY_CNT = (Integer) __fieldVal;
    }
    else    if ("MLD_BO_SUCCESS_CNT".equals(__fieldName)) {
      this.MLD_BO_SUCCESS_CNT = (Integer) __fieldVal;
    }
    else    if ("REGISTER_TIME".equals(__fieldName)) {
      this.REGISTER_TIME = (String) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("STAT_DATE".equals(__fieldName)) {
      this.STAT_DATE = (Integer) __fieldVal;
      return true;
    }
    else    if ("USER_ID".equals(__fieldName)) {
      this.USER_ID = (Long) __fieldVal;
      return true;
    }
    else    if ("USER_NAME".equals(__fieldName)) {
      this.USER_NAME = (String) __fieldVal;
      return true;
    }
    else    if ("REAL_NAME".equals(__fieldName)) {
      this.REAL_NAME = (String) __fieldVal;
      return true;
    }
    else    if ("IN_REPAYMENT_CNT".equals(__fieldName)) {
      this.IN_REPAYMENT_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("ALREADY_REPAYMENT_CNT".equals(__fieldName)) {
      this.ALREADY_REPAYMENT_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("REJECT_CNT".equals(__fieldName)) {
      this.REJECT_CNT = (String) __fieldVal;
      return true;
    }
    else    if ("LAST_REJECT_TIME".equals(__fieldName)) {
      this.LAST_REJECT_TIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_LESS_7_DAY_CNT".equals(__fieldName)) {
      this.OVERDUE_LESS_7_DAY_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_LESS_30_DAY_CNT".equals(__fieldName)) {
      this.OVERDUE_LESS_30_DAY_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_LESS_60_DAY_CNT".equals(__fieldName)) {
      this.OVERDUE_LESS_60_DAY_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_MORE_60_DAY_CNT".equals(__fieldName)) {
      this.OVERDUE_MORE_60_DAY_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("MAX_BO_BRICE".equals(__fieldName)) {
      this.MAX_BO_BRICE = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("LOAN_MXD_BKB_CNT".equals(__fieldName)) {
      this.LOAN_MXD_BKB_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("LOAN_MXD_ZKB_CNT".equals(__fieldName)) {
      this.LOAN_MXD_ZKB_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("LOAN_MXD_YJB_CNT".equals(__fieldName)) {
      this.LOAN_MXD_YJB_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("LOAN_MXD_BLB_CNT".equals(__fieldName)) {
      this.LOAN_MXD_BLB_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("LOAN_MYFQ_CNT".equals(__fieldName)) {
      this.LOAN_MYFQ_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("LOAN_USA_MXD_CNT".equals(__fieldName)) {
      this.LOAN_USA_MXD_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("LOAN_UNIFI_XED_CNT".equals(__fieldName)) {
      this.LOAN_UNIFI_XED_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("MLD_CREDIT_APPLY_CNT".equals(__fieldName)) {
      this.MLD_CREDIT_APPLY_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("MLD_BO_SUCCESS_CNT".equals(__fieldName)) {
      this.MLD_BO_SUCCESS_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("REGISTER_TIME".equals(__fieldName)) {
      this.REGISTER_TIME = (String) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
