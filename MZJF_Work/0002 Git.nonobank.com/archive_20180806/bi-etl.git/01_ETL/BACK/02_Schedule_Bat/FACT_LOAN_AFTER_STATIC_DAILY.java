// ORM class for table 'FACT_LOAN_AFTER_STATIC_DAILY'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Fri Jun 30 11:35:49 CST 2017
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

public class FACT_LOAN_AFTER_STATIC_DAILY extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private Long STAT_DATE;
  public Long get_STAT_DATE() {
    return STAT_DATE;
  }
  public void set_STAT_DATE(Long STAT_DATE) {
    this.STAT_DATE = STAT_DATE;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_STAT_DATE(Long STAT_DATE) {
    this.STAT_DATE = STAT_DATE;
    return this;
  }
  private Long APPLY_NO;
  public Long get_APPLY_NO() {
    return APPLY_NO;
  }
  public void set_APPLY_NO(Long APPLY_NO) {
    this.APPLY_NO = APPLY_NO;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_APPLY_NO(Long APPLY_NO) {
    this.APPLY_NO = APPLY_NO;
    return this;
  }
  private String DISBURSED_DATE;
  public String get_DISBURSED_DATE() {
    return DISBURSED_DATE;
  }
  public void set_DISBURSED_DATE(String DISBURSED_DATE) {
    this.DISBURSED_DATE = DISBURSED_DATE;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_DISBURSED_DATE(String DISBURSED_DATE) {
    this.DISBURSED_DATE = DISBURSED_DATE;
    return this;
  }
  private java.math.BigDecimal DISBURSED_AMT;
  public java.math.BigDecimal get_DISBURSED_AMT() {
    return DISBURSED_AMT;
  }
  public void set_DISBURSED_AMT(java.math.BigDecimal DISBURSED_AMT) {
    this.DISBURSED_AMT = DISBURSED_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_DISBURSED_AMT(java.math.BigDecimal DISBURSED_AMT) {
    this.DISBURSED_AMT = DISBURSED_AMT;
    return this;
  }
  private Integer TERM;
  public Integer get_TERM() {
    return TERM;
  }
  public void set_TERM(Integer TERM) {
    this.TERM = TERM;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_TERM(Integer TERM) {
    this.TERM = TERM;
    return this;
  }
  private Integer TERM_UNIT;
  public Integer get_TERM_UNIT() {
    return TERM_UNIT;
  }
  public void set_TERM_UNIT(Integer TERM_UNIT) {
    this.TERM_UNIT = TERM_UNIT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_TERM_UNIT(Integer TERM_UNIT) {
    this.TERM_UNIT = TERM_UNIT;
    return this;
  }
  private java.math.BigDecimal INTEREST_RATE;
  public java.math.BigDecimal get_INTEREST_RATE() {
    return INTEREST_RATE;
  }
  public void set_INTEREST_RATE(java.math.BigDecimal INTEREST_RATE) {
    this.INTEREST_RATE = INTEREST_RATE;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_INTEREST_RATE(java.math.BigDecimal INTEREST_RATE) {
    this.INTEREST_RATE = INTEREST_RATE;
    return this;
  }
  private String STATUS;
  public String get_STATUS() {
    return STATUS;
  }
  public void set_STATUS(String STATUS) {
    this.STATUS = STATUS;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_STATUS(String STATUS) {
    this.STATUS = STATUS;
    return this;
  }
  private Integer OVERDUE_DAY;
  public Integer get_OVERDUE_DAY() {
    return OVERDUE_DAY;
  }
  public void set_OVERDUE_DAY(Integer OVERDUE_DAY) {
    this.OVERDUE_DAY = OVERDUE_DAY;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_DAY(Integer OVERDUE_DAY) {
    this.OVERDUE_DAY = OVERDUE_DAY;
    return this;
  }
  private Integer OVERDUE_DAY_MAX;
  public Integer get_OVERDUE_DAY_MAX() {
    return OVERDUE_DAY_MAX;
  }
  public void set_OVERDUE_DAY_MAX(Integer OVERDUE_DAY_MAX) {
    this.OVERDUE_DAY_MAX = OVERDUE_DAY_MAX;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_DAY_MAX(Integer OVERDUE_DAY_MAX) {
    this.OVERDUE_DAY_MAX = OVERDUE_DAY_MAX;
    return this;
  }
  private Integer OVERDUE_TERM;
  public Integer get_OVERDUE_TERM() {
    return OVERDUE_TERM;
  }
  public void set_OVERDUE_TERM(Integer OVERDUE_TERM) {
    this.OVERDUE_TERM = OVERDUE_TERM;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_TERM(Integer OVERDUE_TERM) {
    this.OVERDUE_TERM = OVERDUE_TERM;
    return this;
  }
  private Integer OVERDUE_TERM_MAX;
  public Integer get_OVERDUE_TERM_MAX() {
    return OVERDUE_TERM_MAX;
  }
  public void set_OVERDUE_TERM_MAX(Integer OVERDUE_TERM_MAX) {
    this.OVERDUE_TERM_MAX = OVERDUE_TERM_MAX;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_TERM_MAX(Integer OVERDUE_TERM_MAX) {
    this.OVERDUE_TERM_MAX = OVERDUE_TERM_MAX;
    return this;
  }
  private java.math.BigDecimal OVERDUE_AMT;
  public java.math.BigDecimal get_OVERDUE_AMT() {
    return OVERDUE_AMT;
  }
  public void set_OVERDUE_AMT(java.math.BigDecimal OVERDUE_AMT) {
    this.OVERDUE_AMT = OVERDUE_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_AMT(java.math.BigDecimal OVERDUE_AMT) {
    this.OVERDUE_AMT = OVERDUE_AMT;
    return this;
  }
  private java.math.BigDecimal OVERDUE_AMT_MAX;
  public java.math.BigDecimal get_OVERDUE_AMT_MAX() {
    return OVERDUE_AMT_MAX;
  }
  public void set_OVERDUE_AMT_MAX(java.math.BigDecimal OVERDUE_AMT_MAX) {
    this.OVERDUE_AMT_MAX = OVERDUE_AMT_MAX;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_AMT_MAX(java.math.BigDecimal OVERDUE_AMT_MAX) {
    this.OVERDUE_AMT_MAX = OVERDUE_AMT_MAX;
    return this;
  }
  private java.math.BigDecimal OUTSTANDING_AMT;
  public java.math.BigDecimal get_OUTSTANDING_AMT() {
    return OUTSTANDING_AMT;
  }
  public void set_OUTSTANDING_AMT(java.math.BigDecimal OUTSTANDING_AMT) {
    this.OUTSTANDING_AMT = OUTSTANDING_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OUTSTANDING_AMT(java.math.BigDecimal OUTSTANDING_AMT) {
    this.OUTSTANDING_AMT = OUTSTANDING_AMT;
    return this;
  }
  private Integer TERM_PAID;
  public Integer get_TERM_PAID() {
    return TERM_PAID;
  }
  public void set_TERM_PAID(Integer TERM_PAID) {
    this.TERM_PAID = TERM_PAID;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_TERM_PAID(Integer TERM_PAID) {
    this.TERM_PAID = TERM_PAID;
    return this;
  }
  private java.math.BigDecimal OVERDUE_PRINCIPAL_AMT;
  public java.math.BigDecimal get_OVERDUE_PRINCIPAL_AMT() {
    return OVERDUE_PRINCIPAL_AMT;
  }
  public void set_OVERDUE_PRINCIPAL_AMT(java.math.BigDecimal OVERDUE_PRINCIPAL_AMT) {
    this.OVERDUE_PRINCIPAL_AMT = OVERDUE_PRINCIPAL_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_PRINCIPAL_AMT(java.math.BigDecimal OVERDUE_PRINCIPAL_AMT) {
    this.OVERDUE_PRINCIPAL_AMT = OVERDUE_PRINCIPAL_AMT;
    return this;
  }
  private java.math.BigDecimal MAX_OVERDUE_PRINCIPAL_AMT;
  public java.math.BigDecimal get_MAX_OVERDUE_PRINCIPAL_AMT() {
    return MAX_OVERDUE_PRINCIPAL_AMT;
  }
  public void set_MAX_OVERDUE_PRINCIPAL_AMT(java.math.BigDecimal MAX_OVERDUE_PRINCIPAL_AMT) {
    this.MAX_OVERDUE_PRINCIPAL_AMT = MAX_OVERDUE_PRINCIPAL_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_MAX_OVERDUE_PRINCIPAL_AMT(java.math.BigDecimal MAX_OVERDUE_PRINCIPAL_AMT) {
    this.MAX_OVERDUE_PRINCIPAL_AMT = MAX_OVERDUE_PRINCIPAL_AMT;
    return this;
  }
  private String PRODUCT;
  public String get_PRODUCT() {
    return PRODUCT;
  }
  public void set_PRODUCT(String PRODUCT) {
    this.PRODUCT = PRODUCT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_PRODUCT(String PRODUCT) {
    this.PRODUCT = PRODUCT;
    return this;
  }
  private java.math.BigDecimal PRINCIPAL_TMONTH_AMT;
  public java.math.BigDecimal get_PRINCIPAL_TMONTH_AMT() {
    return PRINCIPAL_TMONTH_AMT;
  }
  public void set_PRINCIPAL_TMONTH_AMT(java.math.BigDecimal PRINCIPAL_TMONTH_AMT) {
    this.PRINCIPAL_TMONTH_AMT = PRINCIPAL_TMONTH_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_PRINCIPAL_TMONTH_AMT(java.math.BigDecimal PRINCIPAL_TMONTH_AMT) {
    this.PRINCIPAL_TMONTH_AMT = PRINCIPAL_TMONTH_AMT;
    return this;
  }
  private String FILE_DATE;
  public String get_FILE_DATE() {
    return FILE_DATE;
  }
  public void set_FILE_DATE(String FILE_DATE) {
    this.FILE_DATE = FILE_DATE;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_FILE_DATE(String FILE_DATE) {
    this.FILE_DATE = FILE_DATE;
    return this;
  }
  private Long USER_ID;
  public Long get_USER_ID() {
    return USER_ID;
  }
  public void set_USER_ID(Long USER_ID) {
    this.USER_ID = USER_ID;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_USER_ID(Long USER_ID) {
    this.USER_ID = USER_ID;
    return this;
  }
  private Integer IS_FIRST_REPAY_OVERDUE_7D;
  public Integer get_IS_FIRST_REPAY_OVERDUE_7D() {
    return IS_FIRST_REPAY_OVERDUE_7D;
  }
  public void set_IS_FIRST_REPAY_OVERDUE_7D(Integer IS_FIRST_REPAY_OVERDUE_7D) {
    this.IS_FIRST_REPAY_OVERDUE_7D = IS_FIRST_REPAY_OVERDUE_7D;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_IS_FIRST_REPAY_OVERDUE_7D(Integer IS_FIRST_REPAY_OVERDUE_7D) {
    this.IS_FIRST_REPAY_OVERDUE_7D = IS_FIRST_REPAY_OVERDUE_7D;
    return this;
  }
  private java.math.BigDecimal OVERDUE_UNREPAY_AMT;
  public java.math.BigDecimal get_OVERDUE_UNREPAY_AMT() {
    return OVERDUE_UNREPAY_AMT;
  }
  public void set_OVERDUE_UNREPAY_AMT(java.math.BigDecimal OVERDUE_UNREPAY_AMT) {
    this.OVERDUE_UNREPAY_AMT = OVERDUE_UNREPAY_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_UNREPAY_AMT(java.math.BigDecimal OVERDUE_UNREPAY_AMT) {
    this.OVERDUE_UNREPAY_AMT = OVERDUE_UNREPAY_AMT;
    return this;
  }
  private java.math.BigDecimal OVERDUE_UNREPAY_L;
  public java.math.BigDecimal get_OVERDUE_UNREPAY_L() {
    return OVERDUE_UNREPAY_L;
  }
  public void set_OVERDUE_UNREPAY_L(java.math.BigDecimal OVERDUE_UNREPAY_L) {
    this.OVERDUE_UNREPAY_L = OVERDUE_UNREPAY_L;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_UNREPAY_L(java.math.BigDecimal OVERDUE_UNREPAY_L) {
    this.OVERDUE_UNREPAY_L = OVERDUE_UNREPAY_L;
    return this;
  }
  private java.math.BigDecimal OVERDUE_UNREPAY_SERVICE_FEE;
  public java.math.BigDecimal get_OVERDUE_UNREPAY_SERVICE_FEE() {
    return OVERDUE_UNREPAY_SERVICE_FEE;
  }
  public void set_OVERDUE_UNREPAY_SERVICE_FEE(java.math.BigDecimal OVERDUE_UNREPAY_SERVICE_FEE) {
    this.OVERDUE_UNREPAY_SERVICE_FEE = OVERDUE_UNREPAY_SERVICE_FEE;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_UNREPAY_SERVICE_FEE(java.math.BigDecimal OVERDUE_UNREPAY_SERVICE_FEE) {
    this.OVERDUE_UNREPAY_SERVICE_FEE = OVERDUE_UNREPAY_SERVICE_FEE;
    return this;
  }
  private java.math.BigDecimal OVERDUE_UNREPAY_PUNISH;
  public java.math.BigDecimal get_OVERDUE_UNREPAY_PUNISH() {
    return OVERDUE_UNREPAY_PUNISH;
  }
  public void set_OVERDUE_UNREPAY_PUNISH(java.math.BigDecimal OVERDUE_UNREPAY_PUNISH) {
    this.OVERDUE_UNREPAY_PUNISH = OVERDUE_UNREPAY_PUNISH;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_UNREPAY_PUNISH(java.math.BigDecimal OVERDUE_UNREPAY_PUNISH) {
    this.OVERDUE_UNREPAY_PUNISH = OVERDUE_UNREPAY_PUNISH;
    return this;
  }
  private java.math.BigDecimal REPAY_AMT_THIS_MONTH;
  public java.math.BigDecimal get_REPAY_AMT_THIS_MONTH() {
    return REPAY_AMT_THIS_MONTH;
  }
  public void set_REPAY_AMT_THIS_MONTH(java.math.BigDecimal REPAY_AMT_THIS_MONTH) {
    this.REPAY_AMT_THIS_MONTH = REPAY_AMT_THIS_MONTH;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_REPAY_AMT_THIS_MONTH(java.math.BigDecimal REPAY_AMT_THIS_MONTH) {
    this.REPAY_AMT_THIS_MONTH = REPAY_AMT_THIS_MONTH;
    return this;
  }
  private java.math.BigDecimal REPAY_L_THIS_MONTH;
  public java.math.BigDecimal get_REPAY_L_THIS_MONTH() {
    return REPAY_L_THIS_MONTH;
  }
  public void set_REPAY_L_THIS_MONTH(java.math.BigDecimal REPAY_L_THIS_MONTH) {
    this.REPAY_L_THIS_MONTH = REPAY_L_THIS_MONTH;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_REPAY_L_THIS_MONTH(java.math.BigDecimal REPAY_L_THIS_MONTH) {
    this.REPAY_L_THIS_MONTH = REPAY_L_THIS_MONTH;
    return this;
  }
  private java.math.BigDecimal REPAY_PUNISH_THIS_MONTH;
  public java.math.BigDecimal get_REPAY_PUNISH_THIS_MONTH() {
    return REPAY_PUNISH_THIS_MONTH;
  }
  public void set_REPAY_PUNISH_THIS_MONTH(java.math.BigDecimal REPAY_PUNISH_THIS_MONTH) {
    this.REPAY_PUNISH_THIS_MONTH = REPAY_PUNISH_THIS_MONTH;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_REPAY_PUNISH_THIS_MONTH(java.math.BigDecimal REPAY_PUNISH_THIS_MONTH) {
    this.REPAY_PUNISH_THIS_MONTH = REPAY_PUNISH_THIS_MONTH;
    return this;
  }
  private java.math.BigDecimal REPAY_SERVICE_FEE_THIS_MONTH;
  public java.math.BigDecimal get_REPAY_SERVICE_FEE_THIS_MONTH() {
    return REPAY_SERVICE_FEE_THIS_MONTH;
  }
  public void set_REPAY_SERVICE_FEE_THIS_MONTH(java.math.BigDecimal REPAY_SERVICE_FEE_THIS_MONTH) {
    this.REPAY_SERVICE_FEE_THIS_MONTH = REPAY_SERVICE_FEE_THIS_MONTH;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_REPAY_SERVICE_FEE_THIS_MONTH(java.math.BigDecimal REPAY_SERVICE_FEE_THIS_MONTH) {
    this.REPAY_SERVICE_FEE_THIS_MONTH = REPAY_SERVICE_FEE_THIS_MONTH;
    return this;
  }
  private java.math.BigDecimal SHOULD_B_THIS_MONTH;
  public java.math.BigDecimal get_SHOULD_B_THIS_MONTH() {
    return SHOULD_B_THIS_MONTH;
  }
  public void set_SHOULD_B_THIS_MONTH(java.math.BigDecimal SHOULD_B_THIS_MONTH) {
    this.SHOULD_B_THIS_MONTH = SHOULD_B_THIS_MONTH;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_SHOULD_B_THIS_MONTH(java.math.BigDecimal SHOULD_B_THIS_MONTH) {
    this.SHOULD_B_THIS_MONTH = SHOULD_B_THIS_MONTH;
    return this;
  }
  private java.math.BigDecimal SHOULD_L_THIS_MONTH;
  public java.math.BigDecimal get_SHOULD_L_THIS_MONTH() {
    return SHOULD_L_THIS_MONTH;
  }
  public void set_SHOULD_L_THIS_MONTH(java.math.BigDecimal SHOULD_L_THIS_MONTH) {
    this.SHOULD_L_THIS_MONTH = SHOULD_L_THIS_MONTH;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_SHOULD_L_THIS_MONTH(java.math.BigDecimal SHOULD_L_THIS_MONTH) {
    this.SHOULD_L_THIS_MONTH = SHOULD_L_THIS_MONTH;
    return this;
  }
  private Integer SHOULD_REPAY_CNT;
  public Integer get_SHOULD_REPAY_CNT() {
    return SHOULD_REPAY_CNT;
  }
  public void set_SHOULD_REPAY_CNT(Integer SHOULD_REPAY_CNT) {
    this.SHOULD_REPAY_CNT = SHOULD_REPAY_CNT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_SHOULD_REPAY_CNT(Integer SHOULD_REPAY_CNT) {
    this.SHOULD_REPAY_CNT = SHOULD_REPAY_CNT;
    return this;
  }
  private String REPAY_BEGIN_DAY;
  public String get_REPAY_BEGIN_DAY() {
    return REPAY_BEGIN_DAY;
  }
  public void set_REPAY_BEGIN_DAY(String REPAY_BEGIN_DAY) {
    this.REPAY_BEGIN_DAY = REPAY_BEGIN_DAY;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_REPAY_BEGIN_DAY(String REPAY_BEGIN_DAY) {
    this.REPAY_BEGIN_DAY = REPAY_BEGIN_DAY;
    return this;
  }
  private java.math.BigDecimal ZX_PRICE;
  public java.math.BigDecimal get_ZX_PRICE() {
    return ZX_PRICE;
  }
  public void set_ZX_PRICE(java.math.BigDecimal ZX_PRICE) {
    this.ZX_PRICE = ZX_PRICE;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_ZX_PRICE(java.math.BigDecimal ZX_PRICE) {
    this.ZX_PRICE = ZX_PRICE;
    return this;
  }
  private java.math.BigDecimal OVERDUE_REPAY_PRICE_B;
  public java.math.BigDecimal get_OVERDUE_REPAY_PRICE_B() {
    return OVERDUE_REPAY_PRICE_B;
  }
  public void set_OVERDUE_REPAY_PRICE_B(java.math.BigDecimal OVERDUE_REPAY_PRICE_B) {
    this.OVERDUE_REPAY_PRICE_B = OVERDUE_REPAY_PRICE_B;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_REPAY_PRICE_B(java.math.BigDecimal OVERDUE_REPAY_PRICE_B) {
    this.OVERDUE_REPAY_PRICE_B = OVERDUE_REPAY_PRICE_B;
    return this;
  }
  private java.math.BigDecimal OVERDUE_REPAY_PRICE;
  public java.math.BigDecimal get_OVERDUE_REPAY_PRICE() {
    return OVERDUE_REPAY_PRICE;
  }
  public void set_OVERDUE_REPAY_PRICE(java.math.BigDecimal OVERDUE_REPAY_PRICE) {
    this.OVERDUE_REPAY_PRICE = OVERDUE_REPAY_PRICE;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_OVERDUE_REPAY_PRICE(java.math.BigDecimal OVERDUE_REPAY_PRICE) {
    this.OVERDUE_REPAY_PRICE = OVERDUE_REPAY_PRICE;
    return this;
  }
  private java.math.BigDecimal REPAYED_AMT;
  public java.math.BigDecimal get_REPAYED_AMT() {
    return REPAYED_AMT;
  }
  public void set_REPAYED_AMT(java.math.BigDecimal REPAYED_AMT) {
    this.REPAYED_AMT = REPAYED_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_REPAYED_AMT(java.math.BigDecimal REPAYED_AMT) {
    this.REPAYED_AMT = REPAYED_AMT;
    return this;
  }
  private java.math.BigDecimal REPAYED_PRICE_B;
  public java.math.BigDecimal get_REPAYED_PRICE_B() {
    return REPAYED_PRICE_B;
  }
  public void set_REPAYED_PRICE_B(java.math.BigDecimal REPAYED_PRICE_B) {
    this.REPAYED_PRICE_B = REPAYED_PRICE_B;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_REPAYED_PRICE_B(java.math.BigDecimal REPAYED_PRICE_B) {
    this.REPAYED_PRICE_B = REPAYED_PRICE_B;
    return this;
  }
  private java.math.BigDecimal UNREPAYED_AMT;
  public java.math.BigDecimal get_UNREPAYED_AMT() {
    return UNREPAYED_AMT;
  }
  public void set_UNREPAYED_AMT(java.math.BigDecimal UNREPAYED_AMT) {
    this.UNREPAYED_AMT = UNREPAYED_AMT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_UNREPAYED_AMT(java.math.BigDecimal UNREPAYED_AMT) {
    this.UNREPAYED_AMT = UNREPAYED_AMT;
    return this;
  }
  private String ALL_REPAYED_TIME;
  public String get_ALL_REPAYED_TIME() {
    return ALL_REPAYED_TIME;
  }
  public void set_ALL_REPAYED_TIME(String ALL_REPAYED_TIME) {
    this.ALL_REPAYED_TIME = ALL_REPAYED_TIME;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_ALL_REPAYED_TIME(String ALL_REPAYED_TIME) {
    this.ALL_REPAYED_TIME = ALL_REPAYED_TIME;
    return this;
  }
  private String USER_NAME;
  public String get_USER_NAME() {
    return USER_NAME;
  }
  public void set_USER_NAME(String USER_NAME) {
    this.USER_NAME = USER_NAME;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_USER_NAME(String USER_NAME) {
    this.USER_NAME = USER_NAME;
    return this;
  }
  private java.math.BigDecimal BR_PRICE_PER_EXPECT;
  public java.math.BigDecimal get_BR_PRICE_PER_EXPECT() {
    return BR_PRICE_PER_EXPECT;
  }
  public void set_BR_PRICE_PER_EXPECT(java.math.BigDecimal BR_PRICE_PER_EXPECT) {
    this.BR_PRICE_PER_EXPECT = BR_PRICE_PER_EXPECT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_BR_PRICE_PER_EXPECT(java.math.BigDecimal BR_PRICE_PER_EXPECT) {
    this.BR_PRICE_PER_EXPECT = BR_PRICE_PER_EXPECT;
    return this;
  }
  private String REPAYMENT_TYPE;
  public String get_REPAYMENT_TYPE() {
    return REPAYMENT_TYPE;
  }
  public void set_REPAYMENT_TYPE(String REPAYMENT_TYPE) {
    this.REPAYMENT_TYPE = REPAYMENT_TYPE;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_REPAYMENT_TYPE(String REPAYMENT_TYPE) {
    this.REPAYMENT_TYPE = REPAYMENT_TYPE;
    return this;
  }
  private java.math.BigDecimal ACCU_PAID_INT;
  public java.math.BigDecimal get_ACCU_PAID_INT() {
    return ACCU_PAID_INT;
  }
  public void set_ACCU_PAID_INT(java.math.BigDecimal ACCU_PAID_INT) {
    this.ACCU_PAID_INT = ACCU_PAID_INT;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_ACCU_PAID_INT(java.math.BigDecimal ACCU_PAID_INT) {
    this.ACCU_PAID_INT = ACCU_PAID_INT;
    return this;
  }
  private java.math.BigDecimal ACCU_PAID_PULISH;
  public java.math.BigDecimal get_ACCU_PAID_PULISH() {
    return ACCU_PAID_PULISH;
  }
  public void set_ACCU_PAID_PULISH(java.math.BigDecimal ACCU_PAID_PULISH) {
    this.ACCU_PAID_PULISH = ACCU_PAID_PULISH;
  }
  public FACT_LOAN_AFTER_STATIC_DAILY with_ACCU_PAID_PULISH(java.math.BigDecimal ACCU_PAID_PULISH) {
    this.ACCU_PAID_PULISH = ACCU_PAID_PULISH;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof FACT_LOAN_AFTER_STATIC_DAILY)) {
      return false;
    }
    FACT_LOAN_AFTER_STATIC_DAILY that = (FACT_LOAN_AFTER_STATIC_DAILY) o;
    boolean equal = true;
    equal = equal && (this.STAT_DATE == null ? that.STAT_DATE == null : this.STAT_DATE.equals(that.STAT_DATE));
    equal = equal && (this.APPLY_NO == null ? that.APPLY_NO == null : this.APPLY_NO.equals(that.APPLY_NO));
    equal = equal && (this.DISBURSED_DATE == null ? that.DISBURSED_DATE == null : this.DISBURSED_DATE.equals(that.DISBURSED_DATE));
    equal = equal && (this.DISBURSED_AMT == null ? that.DISBURSED_AMT == null : this.DISBURSED_AMT.equals(that.DISBURSED_AMT));
    equal = equal && (this.TERM == null ? that.TERM == null : this.TERM.equals(that.TERM));
    equal = equal && (this.TERM_UNIT == null ? that.TERM_UNIT == null : this.TERM_UNIT.equals(that.TERM_UNIT));
    equal = equal && (this.INTEREST_RATE == null ? that.INTEREST_RATE == null : this.INTEREST_RATE.equals(that.INTEREST_RATE));
    equal = equal && (this.STATUS == null ? that.STATUS == null : this.STATUS.equals(that.STATUS));
    equal = equal && (this.OVERDUE_DAY == null ? that.OVERDUE_DAY == null : this.OVERDUE_DAY.equals(that.OVERDUE_DAY));
    equal = equal && (this.OVERDUE_DAY_MAX == null ? that.OVERDUE_DAY_MAX == null : this.OVERDUE_DAY_MAX.equals(that.OVERDUE_DAY_MAX));
    equal = equal && (this.OVERDUE_TERM == null ? that.OVERDUE_TERM == null : this.OVERDUE_TERM.equals(that.OVERDUE_TERM));
    equal = equal && (this.OVERDUE_TERM_MAX == null ? that.OVERDUE_TERM_MAX == null : this.OVERDUE_TERM_MAX.equals(that.OVERDUE_TERM_MAX));
    equal = equal && (this.OVERDUE_AMT == null ? that.OVERDUE_AMT == null : this.OVERDUE_AMT.equals(that.OVERDUE_AMT));
    equal = equal && (this.OVERDUE_AMT_MAX == null ? that.OVERDUE_AMT_MAX == null : this.OVERDUE_AMT_MAX.equals(that.OVERDUE_AMT_MAX));
    equal = equal && (this.OUTSTANDING_AMT == null ? that.OUTSTANDING_AMT == null : this.OUTSTANDING_AMT.equals(that.OUTSTANDING_AMT));
    equal = equal && (this.TERM_PAID == null ? that.TERM_PAID == null : this.TERM_PAID.equals(that.TERM_PAID));
    equal = equal && (this.OVERDUE_PRINCIPAL_AMT == null ? that.OVERDUE_PRINCIPAL_AMT == null : this.OVERDUE_PRINCIPAL_AMT.equals(that.OVERDUE_PRINCIPAL_AMT));
    equal = equal && (this.MAX_OVERDUE_PRINCIPAL_AMT == null ? that.MAX_OVERDUE_PRINCIPAL_AMT == null : this.MAX_OVERDUE_PRINCIPAL_AMT.equals(that.MAX_OVERDUE_PRINCIPAL_AMT));
    equal = equal && (this.PRODUCT == null ? that.PRODUCT == null : this.PRODUCT.equals(that.PRODUCT));
    equal = equal && (this.PRINCIPAL_TMONTH_AMT == null ? that.PRINCIPAL_TMONTH_AMT == null : this.PRINCIPAL_TMONTH_AMT.equals(that.PRINCIPAL_TMONTH_AMT));
    equal = equal && (this.FILE_DATE == null ? that.FILE_DATE == null : this.FILE_DATE.equals(that.FILE_DATE));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.IS_FIRST_REPAY_OVERDUE_7D == null ? that.IS_FIRST_REPAY_OVERDUE_7D == null : this.IS_FIRST_REPAY_OVERDUE_7D.equals(that.IS_FIRST_REPAY_OVERDUE_7D));
    equal = equal && (this.OVERDUE_UNREPAY_AMT == null ? that.OVERDUE_UNREPAY_AMT == null : this.OVERDUE_UNREPAY_AMT.equals(that.OVERDUE_UNREPAY_AMT));
    equal = equal && (this.OVERDUE_UNREPAY_L == null ? that.OVERDUE_UNREPAY_L == null : this.OVERDUE_UNREPAY_L.equals(that.OVERDUE_UNREPAY_L));
    equal = equal && (this.OVERDUE_UNREPAY_SERVICE_FEE == null ? that.OVERDUE_UNREPAY_SERVICE_FEE == null : this.OVERDUE_UNREPAY_SERVICE_FEE.equals(that.OVERDUE_UNREPAY_SERVICE_FEE));
    equal = equal && (this.OVERDUE_UNREPAY_PUNISH == null ? that.OVERDUE_UNREPAY_PUNISH == null : this.OVERDUE_UNREPAY_PUNISH.equals(that.OVERDUE_UNREPAY_PUNISH));
    equal = equal && (this.REPAY_AMT_THIS_MONTH == null ? that.REPAY_AMT_THIS_MONTH == null : this.REPAY_AMT_THIS_MONTH.equals(that.REPAY_AMT_THIS_MONTH));
    equal = equal && (this.REPAY_L_THIS_MONTH == null ? that.REPAY_L_THIS_MONTH == null : this.REPAY_L_THIS_MONTH.equals(that.REPAY_L_THIS_MONTH));
    equal = equal && (this.REPAY_PUNISH_THIS_MONTH == null ? that.REPAY_PUNISH_THIS_MONTH == null : this.REPAY_PUNISH_THIS_MONTH.equals(that.REPAY_PUNISH_THIS_MONTH));
    equal = equal && (this.REPAY_SERVICE_FEE_THIS_MONTH == null ? that.REPAY_SERVICE_FEE_THIS_MONTH == null : this.REPAY_SERVICE_FEE_THIS_MONTH.equals(that.REPAY_SERVICE_FEE_THIS_MONTH));
    equal = equal && (this.SHOULD_B_THIS_MONTH == null ? that.SHOULD_B_THIS_MONTH == null : this.SHOULD_B_THIS_MONTH.equals(that.SHOULD_B_THIS_MONTH));
    equal = equal && (this.SHOULD_L_THIS_MONTH == null ? that.SHOULD_L_THIS_MONTH == null : this.SHOULD_L_THIS_MONTH.equals(that.SHOULD_L_THIS_MONTH));
    equal = equal && (this.SHOULD_REPAY_CNT == null ? that.SHOULD_REPAY_CNT == null : this.SHOULD_REPAY_CNT.equals(that.SHOULD_REPAY_CNT));
    equal = equal && (this.REPAY_BEGIN_DAY == null ? that.REPAY_BEGIN_DAY == null : this.REPAY_BEGIN_DAY.equals(that.REPAY_BEGIN_DAY));
    equal = equal && (this.ZX_PRICE == null ? that.ZX_PRICE == null : this.ZX_PRICE.equals(that.ZX_PRICE));
    equal = equal && (this.OVERDUE_REPAY_PRICE_B == null ? that.OVERDUE_REPAY_PRICE_B == null : this.OVERDUE_REPAY_PRICE_B.equals(that.OVERDUE_REPAY_PRICE_B));
    equal = equal && (this.OVERDUE_REPAY_PRICE == null ? that.OVERDUE_REPAY_PRICE == null : this.OVERDUE_REPAY_PRICE.equals(that.OVERDUE_REPAY_PRICE));
    equal = equal && (this.REPAYED_AMT == null ? that.REPAYED_AMT == null : this.REPAYED_AMT.equals(that.REPAYED_AMT));
    equal = equal && (this.REPAYED_PRICE_B == null ? that.REPAYED_PRICE_B == null : this.REPAYED_PRICE_B.equals(that.REPAYED_PRICE_B));
    equal = equal && (this.UNREPAYED_AMT == null ? that.UNREPAYED_AMT == null : this.UNREPAYED_AMT.equals(that.UNREPAYED_AMT));
    equal = equal && (this.ALL_REPAYED_TIME == null ? that.ALL_REPAYED_TIME == null : this.ALL_REPAYED_TIME.equals(that.ALL_REPAYED_TIME));
    equal = equal && (this.USER_NAME == null ? that.USER_NAME == null : this.USER_NAME.equals(that.USER_NAME));
    equal = equal && (this.BR_PRICE_PER_EXPECT == null ? that.BR_PRICE_PER_EXPECT == null : this.BR_PRICE_PER_EXPECT.equals(that.BR_PRICE_PER_EXPECT));
    equal = equal && (this.REPAYMENT_TYPE == null ? that.REPAYMENT_TYPE == null : this.REPAYMENT_TYPE.equals(that.REPAYMENT_TYPE));
    equal = equal && (this.ACCU_PAID_INT == null ? that.ACCU_PAID_INT == null : this.ACCU_PAID_INT.equals(that.ACCU_PAID_INT));
    equal = equal && (this.ACCU_PAID_PULISH == null ? that.ACCU_PAID_PULISH == null : this.ACCU_PAID_PULISH.equals(that.ACCU_PAID_PULISH));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof FACT_LOAN_AFTER_STATIC_DAILY)) {
      return false;
    }
    FACT_LOAN_AFTER_STATIC_DAILY that = (FACT_LOAN_AFTER_STATIC_DAILY) o;
    boolean equal = true;
    equal = equal && (this.STAT_DATE == null ? that.STAT_DATE == null : this.STAT_DATE.equals(that.STAT_DATE));
    equal = equal && (this.APPLY_NO == null ? that.APPLY_NO == null : this.APPLY_NO.equals(that.APPLY_NO));
    equal = equal && (this.DISBURSED_DATE == null ? that.DISBURSED_DATE == null : this.DISBURSED_DATE.equals(that.DISBURSED_DATE));
    equal = equal && (this.DISBURSED_AMT == null ? that.DISBURSED_AMT == null : this.DISBURSED_AMT.equals(that.DISBURSED_AMT));
    equal = equal && (this.TERM == null ? that.TERM == null : this.TERM.equals(that.TERM));
    equal = equal && (this.TERM_UNIT == null ? that.TERM_UNIT == null : this.TERM_UNIT.equals(that.TERM_UNIT));
    equal = equal && (this.INTEREST_RATE == null ? that.INTEREST_RATE == null : this.INTEREST_RATE.equals(that.INTEREST_RATE));
    equal = equal && (this.STATUS == null ? that.STATUS == null : this.STATUS.equals(that.STATUS));
    equal = equal && (this.OVERDUE_DAY == null ? that.OVERDUE_DAY == null : this.OVERDUE_DAY.equals(that.OVERDUE_DAY));
    equal = equal && (this.OVERDUE_DAY_MAX == null ? that.OVERDUE_DAY_MAX == null : this.OVERDUE_DAY_MAX.equals(that.OVERDUE_DAY_MAX));
    equal = equal && (this.OVERDUE_TERM == null ? that.OVERDUE_TERM == null : this.OVERDUE_TERM.equals(that.OVERDUE_TERM));
    equal = equal && (this.OVERDUE_TERM_MAX == null ? that.OVERDUE_TERM_MAX == null : this.OVERDUE_TERM_MAX.equals(that.OVERDUE_TERM_MAX));
    equal = equal && (this.OVERDUE_AMT == null ? that.OVERDUE_AMT == null : this.OVERDUE_AMT.equals(that.OVERDUE_AMT));
    equal = equal && (this.OVERDUE_AMT_MAX == null ? that.OVERDUE_AMT_MAX == null : this.OVERDUE_AMT_MAX.equals(that.OVERDUE_AMT_MAX));
    equal = equal && (this.OUTSTANDING_AMT == null ? that.OUTSTANDING_AMT == null : this.OUTSTANDING_AMT.equals(that.OUTSTANDING_AMT));
    equal = equal && (this.TERM_PAID == null ? that.TERM_PAID == null : this.TERM_PAID.equals(that.TERM_PAID));
    equal = equal && (this.OVERDUE_PRINCIPAL_AMT == null ? that.OVERDUE_PRINCIPAL_AMT == null : this.OVERDUE_PRINCIPAL_AMT.equals(that.OVERDUE_PRINCIPAL_AMT));
    equal = equal && (this.MAX_OVERDUE_PRINCIPAL_AMT == null ? that.MAX_OVERDUE_PRINCIPAL_AMT == null : this.MAX_OVERDUE_PRINCIPAL_AMT.equals(that.MAX_OVERDUE_PRINCIPAL_AMT));
    equal = equal && (this.PRODUCT == null ? that.PRODUCT == null : this.PRODUCT.equals(that.PRODUCT));
    equal = equal && (this.PRINCIPAL_TMONTH_AMT == null ? that.PRINCIPAL_TMONTH_AMT == null : this.PRINCIPAL_TMONTH_AMT.equals(that.PRINCIPAL_TMONTH_AMT));
    equal = equal && (this.FILE_DATE == null ? that.FILE_DATE == null : this.FILE_DATE.equals(that.FILE_DATE));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.IS_FIRST_REPAY_OVERDUE_7D == null ? that.IS_FIRST_REPAY_OVERDUE_7D == null : this.IS_FIRST_REPAY_OVERDUE_7D.equals(that.IS_FIRST_REPAY_OVERDUE_7D));
    equal = equal && (this.OVERDUE_UNREPAY_AMT == null ? that.OVERDUE_UNREPAY_AMT == null : this.OVERDUE_UNREPAY_AMT.equals(that.OVERDUE_UNREPAY_AMT));
    equal = equal && (this.OVERDUE_UNREPAY_L == null ? that.OVERDUE_UNREPAY_L == null : this.OVERDUE_UNREPAY_L.equals(that.OVERDUE_UNREPAY_L));
    equal = equal && (this.OVERDUE_UNREPAY_SERVICE_FEE == null ? that.OVERDUE_UNREPAY_SERVICE_FEE == null : this.OVERDUE_UNREPAY_SERVICE_FEE.equals(that.OVERDUE_UNREPAY_SERVICE_FEE));
    equal = equal && (this.OVERDUE_UNREPAY_PUNISH == null ? that.OVERDUE_UNREPAY_PUNISH == null : this.OVERDUE_UNREPAY_PUNISH.equals(that.OVERDUE_UNREPAY_PUNISH));
    equal = equal && (this.REPAY_AMT_THIS_MONTH == null ? that.REPAY_AMT_THIS_MONTH == null : this.REPAY_AMT_THIS_MONTH.equals(that.REPAY_AMT_THIS_MONTH));
    equal = equal && (this.REPAY_L_THIS_MONTH == null ? that.REPAY_L_THIS_MONTH == null : this.REPAY_L_THIS_MONTH.equals(that.REPAY_L_THIS_MONTH));
    equal = equal && (this.REPAY_PUNISH_THIS_MONTH == null ? that.REPAY_PUNISH_THIS_MONTH == null : this.REPAY_PUNISH_THIS_MONTH.equals(that.REPAY_PUNISH_THIS_MONTH));
    equal = equal && (this.REPAY_SERVICE_FEE_THIS_MONTH == null ? that.REPAY_SERVICE_FEE_THIS_MONTH == null : this.REPAY_SERVICE_FEE_THIS_MONTH.equals(that.REPAY_SERVICE_FEE_THIS_MONTH));
    equal = equal && (this.SHOULD_B_THIS_MONTH == null ? that.SHOULD_B_THIS_MONTH == null : this.SHOULD_B_THIS_MONTH.equals(that.SHOULD_B_THIS_MONTH));
    equal = equal && (this.SHOULD_L_THIS_MONTH == null ? that.SHOULD_L_THIS_MONTH == null : this.SHOULD_L_THIS_MONTH.equals(that.SHOULD_L_THIS_MONTH));
    equal = equal && (this.SHOULD_REPAY_CNT == null ? that.SHOULD_REPAY_CNT == null : this.SHOULD_REPAY_CNT.equals(that.SHOULD_REPAY_CNT));
    equal = equal && (this.REPAY_BEGIN_DAY == null ? that.REPAY_BEGIN_DAY == null : this.REPAY_BEGIN_DAY.equals(that.REPAY_BEGIN_DAY));
    equal = equal && (this.ZX_PRICE == null ? that.ZX_PRICE == null : this.ZX_PRICE.equals(that.ZX_PRICE));
    equal = equal && (this.OVERDUE_REPAY_PRICE_B == null ? that.OVERDUE_REPAY_PRICE_B == null : this.OVERDUE_REPAY_PRICE_B.equals(that.OVERDUE_REPAY_PRICE_B));
    equal = equal && (this.OVERDUE_REPAY_PRICE == null ? that.OVERDUE_REPAY_PRICE == null : this.OVERDUE_REPAY_PRICE.equals(that.OVERDUE_REPAY_PRICE));
    equal = equal && (this.REPAYED_AMT == null ? that.REPAYED_AMT == null : this.REPAYED_AMT.equals(that.REPAYED_AMT));
    equal = equal && (this.REPAYED_PRICE_B == null ? that.REPAYED_PRICE_B == null : this.REPAYED_PRICE_B.equals(that.REPAYED_PRICE_B));
    equal = equal && (this.UNREPAYED_AMT == null ? that.UNREPAYED_AMT == null : this.UNREPAYED_AMT.equals(that.UNREPAYED_AMT));
    equal = equal && (this.ALL_REPAYED_TIME == null ? that.ALL_REPAYED_TIME == null : this.ALL_REPAYED_TIME.equals(that.ALL_REPAYED_TIME));
    equal = equal && (this.USER_NAME == null ? that.USER_NAME == null : this.USER_NAME.equals(that.USER_NAME));
    equal = equal && (this.BR_PRICE_PER_EXPECT == null ? that.BR_PRICE_PER_EXPECT == null : this.BR_PRICE_PER_EXPECT.equals(that.BR_PRICE_PER_EXPECT));
    equal = equal && (this.REPAYMENT_TYPE == null ? that.REPAYMENT_TYPE == null : this.REPAYMENT_TYPE.equals(that.REPAYMENT_TYPE));
    equal = equal && (this.ACCU_PAID_INT == null ? that.ACCU_PAID_INT == null : this.ACCU_PAID_INT.equals(that.ACCU_PAID_INT));
    equal = equal && (this.ACCU_PAID_PULISH == null ? that.ACCU_PAID_PULISH == null : this.ACCU_PAID_PULISH.equals(that.ACCU_PAID_PULISH));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.STAT_DATE = JdbcWritableBridge.readLong(1, __dbResults);
    this.APPLY_NO = JdbcWritableBridge.readLong(2, __dbResults);
    this.DISBURSED_DATE = JdbcWritableBridge.readString(3, __dbResults);
    this.DISBURSED_AMT = JdbcWritableBridge.readBigDecimal(4, __dbResults);
    this.TERM = JdbcWritableBridge.readInteger(5, __dbResults);
    this.TERM_UNIT = JdbcWritableBridge.readInteger(6, __dbResults);
    this.INTEREST_RATE = JdbcWritableBridge.readBigDecimal(7, __dbResults);
    this.STATUS = JdbcWritableBridge.readString(8, __dbResults);
    this.OVERDUE_DAY = JdbcWritableBridge.readInteger(9, __dbResults);
    this.OVERDUE_DAY_MAX = JdbcWritableBridge.readInteger(10, __dbResults);
    this.OVERDUE_TERM = JdbcWritableBridge.readInteger(11, __dbResults);
    this.OVERDUE_TERM_MAX = JdbcWritableBridge.readInteger(12, __dbResults);
    this.OVERDUE_AMT = JdbcWritableBridge.readBigDecimal(13, __dbResults);
    this.OVERDUE_AMT_MAX = JdbcWritableBridge.readBigDecimal(14, __dbResults);
    this.OUTSTANDING_AMT = JdbcWritableBridge.readBigDecimal(15, __dbResults);
    this.TERM_PAID = JdbcWritableBridge.readInteger(16, __dbResults);
    this.OVERDUE_PRINCIPAL_AMT = JdbcWritableBridge.readBigDecimal(17, __dbResults);
    this.MAX_OVERDUE_PRINCIPAL_AMT = JdbcWritableBridge.readBigDecimal(18, __dbResults);
    this.PRODUCT = JdbcWritableBridge.readString(19, __dbResults);
    this.PRINCIPAL_TMONTH_AMT = JdbcWritableBridge.readBigDecimal(20, __dbResults);
    this.FILE_DATE = JdbcWritableBridge.readString(21, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(22, __dbResults);
    this.IS_FIRST_REPAY_OVERDUE_7D = JdbcWritableBridge.readInteger(23, __dbResults);
    this.OVERDUE_UNREPAY_AMT = JdbcWritableBridge.readBigDecimal(24, __dbResults);
    this.OVERDUE_UNREPAY_L = JdbcWritableBridge.readBigDecimal(25, __dbResults);
    this.OVERDUE_UNREPAY_SERVICE_FEE = JdbcWritableBridge.readBigDecimal(26, __dbResults);
    this.OVERDUE_UNREPAY_PUNISH = JdbcWritableBridge.readBigDecimal(27, __dbResults);
    this.REPAY_AMT_THIS_MONTH = JdbcWritableBridge.readBigDecimal(28, __dbResults);
    this.REPAY_L_THIS_MONTH = JdbcWritableBridge.readBigDecimal(29, __dbResults);
    this.REPAY_PUNISH_THIS_MONTH = JdbcWritableBridge.readBigDecimal(30, __dbResults);
    this.REPAY_SERVICE_FEE_THIS_MONTH = JdbcWritableBridge.readBigDecimal(31, __dbResults);
    this.SHOULD_B_THIS_MONTH = JdbcWritableBridge.readBigDecimal(32, __dbResults);
    this.SHOULD_L_THIS_MONTH = JdbcWritableBridge.readBigDecimal(33, __dbResults);
    this.SHOULD_REPAY_CNT = JdbcWritableBridge.readInteger(34, __dbResults);
    this.REPAY_BEGIN_DAY = JdbcWritableBridge.readString(35, __dbResults);
    this.ZX_PRICE = JdbcWritableBridge.readBigDecimal(36, __dbResults);
    this.OVERDUE_REPAY_PRICE_B = JdbcWritableBridge.readBigDecimal(37, __dbResults);
    this.OVERDUE_REPAY_PRICE = JdbcWritableBridge.readBigDecimal(38, __dbResults);
    this.REPAYED_AMT = JdbcWritableBridge.readBigDecimal(39, __dbResults);
    this.REPAYED_PRICE_B = JdbcWritableBridge.readBigDecimal(40, __dbResults);
    this.UNREPAYED_AMT = JdbcWritableBridge.readBigDecimal(41, __dbResults);
    this.ALL_REPAYED_TIME = JdbcWritableBridge.readString(42, __dbResults);
    this.USER_NAME = JdbcWritableBridge.readString(43, __dbResults);
    this.BR_PRICE_PER_EXPECT = JdbcWritableBridge.readBigDecimal(44, __dbResults);
    this.REPAYMENT_TYPE = JdbcWritableBridge.readString(45, __dbResults);
    this.ACCU_PAID_INT = JdbcWritableBridge.readBigDecimal(46, __dbResults);
    this.ACCU_PAID_PULISH = JdbcWritableBridge.readBigDecimal(47, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.STAT_DATE = JdbcWritableBridge.readLong(1, __dbResults);
    this.APPLY_NO = JdbcWritableBridge.readLong(2, __dbResults);
    this.DISBURSED_DATE = JdbcWritableBridge.readString(3, __dbResults);
    this.DISBURSED_AMT = JdbcWritableBridge.readBigDecimal(4, __dbResults);
    this.TERM = JdbcWritableBridge.readInteger(5, __dbResults);
    this.TERM_UNIT = JdbcWritableBridge.readInteger(6, __dbResults);
    this.INTEREST_RATE = JdbcWritableBridge.readBigDecimal(7, __dbResults);
    this.STATUS = JdbcWritableBridge.readString(8, __dbResults);
    this.OVERDUE_DAY = JdbcWritableBridge.readInteger(9, __dbResults);
    this.OVERDUE_DAY_MAX = JdbcWritableBridge.readInteger(10, __dbResults);
    this.OVERDUE_TERM = JdbcWritableBridge.readInteger(11, __dbResults);
    this.OVERDUE_TERM_MAX = JdbcWritableBridge.readInteger(12, __dbResults);
    this.OVERDUE_AMT = JdbcWritableBridge.readBigDecimal(13, __dbResults);
    this.OVERDUE_AMT_MAX = JdbcWritableBridge.readBigDecimal(14, __dbResults);
    this.OUTSTANDING_AMT = JdbcWritableBridge.readBigDecimal(15, __dbResults);
    this.TERM_PAID = JdbcWritableBridge.readInteger(16, __dbResults);
    this.OVERDUE_PRINCIPAL_AMT = JdbcWritableBridge.readBigDecimal(17, __dbResults);
    this.MAX_OVERDUE_PRINCIPAL_AMT = JdbcWritableBridge.readBigDecimal(18, __dbResults);
    this.PRODUCT = JdbcWritableBridge.readString(19, __dbResults);
    this.PRINCIPAL_TMONTH_AMT = JdbcWritableBridge.readBigDecimal(20, __dbResults);
    this.FILE_DATE = JdbcWritableBridge.readString(21, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(22, __dbResults);
    this.IS_FIRST_REPAY_OVERDUE_7D = JdbcWritableBridge.readInteger(23, __dbResults);
    this.OVERDUE_UNREPAY_AMT = JdbcWritableBridge.readBigDecimal(24, __dbResults);
    this.OVERDUE_UNREPAY_L = JdbcWritableBridge.readBigDecimal(25, __dbResults);
    this.OVERDUE_UNREPAY_SERVICE_FEE = JdbcWritableBridge.readBigDecimal(26, __dbResults);
    this.OVERDUE_UNREPAY_PUNISH = JdbcWritableBridge.readBigDecimal(27, __dbResults);
    this.REPAY_AMT_THIS_MONTH = JdbcWritableBridge.readBigDecimal(28, __dbResults);
    this.REPAY_L_THIS_MONTH = JdbcWritableBridge.readBigDecimal(29, __dbResults);
    this.REPAY_PUNISH_THIS_MONTH = JdbcWritableBridge.readBigDecimal(30, __dbResults);
    this.REPAY_SERVICE_FEE_THIS_MONTH = JdbcWritableBridge.readBigDecimal(31, __dbResults);
    this.SHOULD_B_THIS_MONTH = JdbcWritableBridge.readBigDecimal(32, __dbResults);
    this.SHOULD_L_THIS_MONTH = JdbcWritableBridge.readBigDecimal(33, __dbResults);
    this.SHOULD_REPAY_CNT = JdbcWritableBridge.readInteger(34, __dbResults);
    this.REPAY_BEGIN_DAY = JdbcWritableBridge.readString(35, __dbResults);
    this.ZX_PRICE = JdbcWritableBridge.readBigDecimal(36, __dbResults);
    this.OVERDUE_REPAY_PRICE_B = JdbcWritableBridge.readBigDecimal(37, __dbResults);
    this.OVERDUE_REPAY_PRICE = JdbcWritableBridge.readBigDecimal(38, __dbResults);
    this.REPAYED_AMT = JdbcWritableBridge.readBigDecimal(39, __dbResults);
    this.REPAYED_PRICE_B = JdbcWritableBridge.readBigDecimal(40, __dbResults);
    this.UNREPAYED_AMT = JdbcWritableBridge.readBigDecimal(41, __dbResults);
    this.ALL_REPAYED_TIME = JdbcWritableBridge.readString(42, __dbResults);
    this.USER_NAME = JdbcWritableBridge.readString(43, __dbResults);
    this.BR_PRICE_PER_EXPECT = JdbcWritableBridge.readBigDecimal(44, __dbResults);
    this.REPAYMENT_TYPE = JdbcWritableBridge.readString(45, __dbResults);
    this.ACCU_PAID_INT = JdbcWritableBridge.readBigDecimal(46, __dbResults);
    this.ACCU_PAID_PULISH = JdbcWritableBridge.readBigDecimal(47, __dbResults);
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
    JdbcWritableBridge.writeLong(STAT_DATE, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(APPLY_NO, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(DISBURSED_DATE, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(DISBURSED_AMT, 4 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(TERM, 5 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(TERM_UNIT, 6 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(INTEREST_RATE, 7 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(STATUS, 8 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_DAY, 9 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_DAY_MAX, 10 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_TERM, 11 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_TERM_MAX, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_AMT, 13 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_AMT_MAX, 14 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OUTSTANDING_AMT, 15 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(TERM_PAID, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_PRINCIPAL_AMT, 17 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(MAX_OVERDUE_PRINCIPAL_AMT, 18 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(PRODUCT, 19 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRINCIPAL_TMONTH_AMT, 20 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(FILE_DATE, 21 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeLong(USER_ID, 22 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(IS_FIRST_REPAY_OVERDUE_7D, 23 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_UNREPAY_AMT, 24 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_UNREPAY_L, 25 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_UNREPAY_SERVICE_FEE, 26 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_UNREPAY_PUNISH, 27 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAY_AMT_THIS_MONTH, 28 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAY_L_THIS_MONTH, 29 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAY_PUNISH_THIS_MONTH, 30 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAY_SERVICE_FEE_THIS_MONTH, 31 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(SHOULD_B_THIS_MONTH, 32 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(SHOULD_L_THIS_MONTH, 33 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(SHOULD_REPAY_CNT, 34 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(REPAY_BEGIN_DAY, 35 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ZX_PRICE, 36 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_REPAY_PRICE_B, 37 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_REPAY_PRICE, 38 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAYED_AMT, 39 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAYED_PRICE_B, 40 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(UNREPAYED_AMT, 41 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(ALL_REPAYED_TIME, 42 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(USER_NAME, 43 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(BR_PRICE_PER_EXPECT, 44 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(REPAYMENT_TYPE, 45 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ACCU_PAID_INT, 46 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ACCU_PAID_PULISH, 47 + __off, 3, __dbStmt);
    return 47;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(STAT_DATE, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(APPLY_NO, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(DISBURSED_DATE, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(DISBURSED_AMT, 4 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(TERM, 5 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(TERM_UNIT, 6 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(INTEREST_RATE, 7 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(STATUS, 8 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_DAY, 9 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_DAY_MAX, 10 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_TERM, 11 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(OVERDUE_TERM_MAX, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_AMT, 13 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_AMT_MAX, 14 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OUTSTANDING_AMT, 15 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(TERM_PAID, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_PRINCIPAL_AMT, 17 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(MAX_OVERDUE_PRINCIPAL_AMT, 18 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(PRODUCT, 19 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRINCIPAL_TMONTH_AMT, 20 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(FILE_DATE, 21 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeLong(USER_ID, 22 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(IS_FIRST_REPAY_OVERDUE_7D, 23 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_UNREPAY_AMT, 24 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_UNREPAY_L, 25 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_UNREPAY_SERVICE_FEE, 26 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_UNREPAY_PUNISH, 27 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAY_AMT_THIS_MONTH, 28 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAY_L_THIS_MONTH, 29 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAY_PUNISH_THIS_MONTH, 30 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAY_SERVICE_FEE_THIS_MONTH, 31 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(SHOULD_B_THIS_MONTH, 32 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(SHOULD_L_THIS_MONTH, 33 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(SHOULD_REPAY_CNT, 34 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(REPAY_BEGIN_DAY, 35 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ZX_PRICE, 36 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_REPAY_PRICE_B, 37 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OVERDUE_REPAY_PRICE, 38 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAYED_AMT, 39 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(REPAYED_PRICE_B, 40 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(UNREPAYED_AMT, 41 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(ALL_REPAYED_TIME, 42 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(USER_NAME, 43 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(BR_PRICE_PER_EXPECT, 44 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(REPAYMENT_TYPE, 45 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ACCU_PAID_INT, 46 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ACCU_PAID_PULISH, 47 + __off, 3, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.STAT_DATE = null;
    } else {
    this.STAT_DATE = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.APPLY_NO = null;
    } else {
    this.APPLY_NO = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.DISBURSED_DATE = null;
    } else {
    this.DISBURSED_DATE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.DISBURSED_AMT = null;
    } else {
    this.DISBURSED_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.TERM = null;
    } else {
    this.TERM = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.TERM_UNIT = null;
    } else {
    this.TERM_UNIT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.INTEREST_RATE = null;
    } else {
    this.INTEREST_RATE = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.STATUS = null;
    } else {
    this.STATUS = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_DAY = null;
    } else {
    this.OVERDUE_DAY = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_DAY_MAX = null;
    } else {
    this.OVERDUE_DAY_MAX = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_TERM = null;
    } else {
    this.OVERDUE_TERM = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_TERM_MAX = null;
    } else {
    this.OVERDUE_TERM_MAX = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_AMT = null;
    } else {
    this.OVERDUE_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_AMT_MAX = null;
    } else {
    this.OVERDUE_AMT_MAX = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.OUTSTANDING_AMT = null;
    } else {
    this.OUTSTANDING_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.TERM_PAID = null;
    } else {
    this.TERM_PAID = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_PRINCIPAL_AMT = null;
    } else {
    this.OVERDUE_PRINCIPAL_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.MAX_OVERDUE_PRINCIPAL_AMT = null;
    } else {
    this.MAX_OVERDUE_PRINCIPAL_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PRODUCT = null;
    } else {
    this.PRODUCT = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PRINCIPAL_TMONTH_AMT = null;
    } else {
    this.PRINCIPAL_TMONTH_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.FILE_DATE = null;
    } else {
    this.FILE_DATE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.USER_ID = null;
    } else {
    this.USER_ID = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.IS_FIRST_REPAY_OVERDUE_7D = null;
    } else {
    this.IS_FIRST_REPAY_OVERDUE_7D = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_UNREPAY_AMT = null;
    } else {
    this.OVERDUE_UNREPAY_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_UNREPAY_L = null;
    } else {
    this.OVERDUE_UNREPAY_L = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_UNREPAY_SERVICE_FEE = null;
    } else {
    this.OVERDUE_UNREPAY_SERVICE_FEE = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_UNREPAY_PUNISH = null;
    } else {
    this.OVERDUE_UNREPAY_PUNISH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REPAY_AMT_THIS_MONTH = null;
    } else {
    this.REPAY_AMT_THIS_MONTH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REPAY_L_THIS_MONTH = null;
    } else {
    this.REPAY_L_THIS_MONTH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REPAY_PUNISH_THIS_MONTH = null;
    } else {
    this.REPAY_PUNISH_THIS_MONTH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REPAY_SERVICE_FEE_THIS_MONTH = null;
    } else {
    this.REPAY_SERVICE_FEE_THIS_MONTH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.SHOULD_B_THIS_MONTH = null;
    } else {
    this.SHOULD_B_THIS_MONTH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.SHOULD_L_THIS_MONTH = null;
    } else {
    this.SHOULD_L_THIS_MONTH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.SHOULD_REPAY_CNT = null;
    } else {
    this.SHOULD_REPAY_CNT = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.REPAY_BEGIN_DAY = null;
    } else {
    this.REPAY_BEGIN_DAY = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ZX_PRICE = null;
    } else {
    this.ZX_PRICE = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_REPAY_PRICE_B = null;
    } else {
    this.OVERDUE_REPAY_PRICE_B = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.OVERDUE_REPAY_PRICE = null;
    } else {
    this.OVERDUE_REPAY_PRICE = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REPAYED_AMT = null;
    } else {
    this.REPAYED_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REPAYED_PRICE_B = null;
    } else {
    this.REPAYED_PRICE_B = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.UNREPAYED_AMT = null;
    } else {
    this.UNREPAYED_AMT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ALL_REPAYED_TIME = null;
    } else {
    this.ALL_REPAYED_TIME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.USER_NAME = null;
    } else {
    this.USER_NAME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.BR_PRICE_PER_EXPECT = null;
    } else {
    this.BR_PRICE_PER_EXPECT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REPAYMENT_TYPE = null;
    } else {
    this.REPAYMENT_TYPE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ACCU_PAID_INT = null;
    } else {
    this.ACCU_PAID_INT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ACCU_PAID_PULISH = null;
    } else {
    this.ACCU_PAID_PULISH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.STAT_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.STAT_DATE);
    }
    if (null == this.APPLY_NO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.APPLY_NO);
    }
    if (null == this.DISBURSED_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DISBURSED_DATE);
    }
    if (null == this.DISBURSED_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.DISBURSED_AMT, __dataOut);
    }
    if (null == this.TERM) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.TERM);
    }
    if (null == this.TERM_UNIT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.TERM_UNIT);
    }
    if (null == this.INTEREST_RATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.INTEREST_RATE, __dataOut);
    }
    if (null == this.STATUS) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, STATUS);
    }
    if (null == this.OVERDUE_DAY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_DAY);
    }
    if (null == this.OVERDUE_DAY_MAX) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_DAY_MAX);
    }
    if (null == this.OVERDUE_TERM) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_TERM);
    }
    if (null == this.OVERDUE_TERM_MAX) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_TERM_MAX);
    }
    if (null == this.OVERDUE_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_AMT, __dataOut);
    }
    if (null == this.OVERDUE_AMT_MAX) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_AMT_MAX, __dataOut);
    }
    if (null == this.OUTSTANDING_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OUTSTANDING_AMT, __dataOut);
    }
    if (null == this.TERM_PAID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.TERM_PAID);
    }
    if (null == this.OVERDUE_PRINCIPAL_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_PRINCIPAL_AMT, __dataOut);
    }
    if (null == this.MAX_OVERDUE_PRINCIPAL_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.MAX_OVERDUE_PRINCIPAL_AMT, __dataOut);
    }
    if (null == this.PRODUCT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PRODUCT);
    }
    if (null == this.PRINCIPAL_TMONTH_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRINCIPAL_TMONTH_AMT, __dataOut);
    }
    if (null == this.FILE_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, FILE_DATE);
    }
    if (null == this.USER_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.USER_ID);
    }
    if (null == this.IS_FIRST_REPAY_OVERDUE_7D) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.IS_FIRST_REPAY_OVERDUE_7D);
    }
    if (null == this.OVERDUE_UNREPAY_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_UNREPAY_AMT, __dataOut);
    }
    if (null == this.OVERDUE_UNREPAY_L) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_UNREPAY_L, __dataOut);
    }
    if (null == this.OVERDUE_UNREPAY_SERVICE_FEE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_UNREPAY_SERVICE_FEE, __dataOut);
    }
    if (null == this.OVERDUE_UNREPAY_PUNISH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_UNREPAY_PUNISH, __dataOut);
    }
    if (null == this.REPAY_AMT_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAY_AMT_THIS_MONTH, __dataOut);
    }
    if (null == this.REPAY_L_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAY_L_THIS_MONTH, __dataOut);
    }
    if (null == this.REPAY_PUNISH_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAY_PUNISH_THIS_MONTH, __dataOut);
    }
    if (null == this.REPAY_SERVICE_FEE_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAY_SERVICE_FEE_THIS_MONTH, __dataOut);
    }
    if (null == this.SHOULD_B_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.SHOULD_B_THIS_MONTH, __dataOut);
    }
    if (null == this.SHOULD_L_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.SHOULD_L_THIS_MONTH, __dataOut);
    }
    if (null == this.SHOULD_REPAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.SHOULD_REPAY_CNT);
    }
    if (null == this.REPAY_BEGIN_DAY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REPAY_BEGIN_DAY);
    }
    if (null == this.ZX_PRICE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ZX_PRICE, __dataOut);
    }
    if (null == this.OVERDUE_REPAY_PRICE_B) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_REPAY_PRICE_B, __dataOut);
    }
    if (null == this.OVERDUE_REPAY_PRICE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_REPAY_PRICE, __dataOut);
    }
    if (null == this.REPAYED_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAYED_AMT, __dataOut);
    }
    if (null == this.REPAYED_PRICE_B) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAYED_PRICE_B, __dataOut);
    }
    if (null == this.UNREPAYED_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.UNREPAYED_AMT, __dataOut);
    }
    if (null == this.ALL_REPAYED_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ALL_REPAYED_TIME);
    }
    if (null == this.USER_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, USER_NAME);
    }
    if (null == this.BR_PRICE_PER_EXPECT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.BR_PRICE_PER_EXPECT, __dataOut);
    }
    if (null == this.REPAYMENT_TYPE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REPAYMENT_TYPE);
    }
    if (null == this.ACCU_PAID_INT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ACCU_PAID_INT, __dataOut);
    }
    if (null == this.ACCU_PAID_PULISH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ACCU_PAID_PULISH, __dataOut);
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.STAT_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.STAT_DATE);
    }
    if (null == this.APPLY_NO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.APPLY_NO);
    }
    if (null == this.DISBURSED_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DISBURSED_DATE);
    }
    if (null == this.DISBURSED_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.DISBURSED_AMT, __dataOut);
    }
    if (null == this.TERM) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.TERM);
    }
    if (null == this.TERM_UNIT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.TERM_UNIT);
    }
    if (null == this.INTEREST_RATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.INTEREST_RATE, __dataOut);
    }
    if (null == this.STATUS) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, STATUS);
    }
    if (null == this.OVERDUE_DAY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_DAY);
    }
    if (null == this.OVERDUE_DAY_MAX) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_DAY_MAX);
    }
    if (null == this.OVERDUE_TERM) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_TERM);
    }
    if (null == this.OVERDUE_TERM_MAX) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.OVERDUE_TERM_MAX);
    }
    if (null == this.OVERDUE_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_AMT, __dataOut);
    }
    if (null == this.OVERDUE_AMT_MAX) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_AMT_MAX, __dataOut);
    }
    if (null == this.OUTSTANDING_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OUTSTANDING_AMT, __dataOut);
    }
    if (null == this.TERM_PAID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.TERM_PAID);
    }
    if (null == this.OVERDUE_PRINCIPAL_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_PRINCIPAL_AMT, __dataOut);
    }
    if (null == this.MAX_OVERDUE_PRINCIPAL_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.MAX_OVERDUE_PRINCIPAL_AMT, __dataOut);
    }
    if (null == this.PRODUCT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PRODUCT);
    }
    if (null == this.PRINCIPAL_TMONTH_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRINCIPAL_TMONTH_AMT, __dataOut);
    }
    if (null == this.FILE_DATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, FILE_DATE);
    }
    if (null == this.USER_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.USER_ID);
    }
    if (null == this.IS_FIRST_REPAY_OVERDUE_7D) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.IS_FIRST_REPAY_OVERDUE_7D);
    }
    if (null == this.OVERDUE_UNREPAY_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_UNREPAY_AMT, __dataOut);
    }
    if (null == this.OVERDUE_UNREPAY_L) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_UNREPAY_L, __dataOut);
    }
    if (null == this.OVERDUE_UNREPAY_SERVICE_FEE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_UNREPAY_SERVICE_FEE, __dataOut);
    }
    if (null == this.OVERDUE_UNREPAY_PUNISH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_UNREPAY_PUNISH, __dataOut);
    }
    if (null == this.REPAY_AMT_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAY_AMT_THIS_MONTH, __dataOut);
    }
    if (null == this.REPAY_L_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAY_L_THIS_MONTH, __dataOut);
    }
    if (null == this.REPAY_PUNISH_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAY_PUNISH_THIS_MONTH, __dataOut);
    }
    if (null == this.REPAY_SERVICE_FEE_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAY_SERVICE_FEE_THIS_MONTH, __dataOut);
    }
    if (null == this.SHOULD_B_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.SHOULD_B_THIS_MONTH, __dataOut);
    }
    if (null == this.SHOULD_L_THIS_MONTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.SHOULD_L_THIS_MONTH, __dataOut);
    }
    if (null == this.SHOULD_REPAY_CNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.SHOULD_REPAY_CNT);
    }
    if (null == this.REPAY_BEGIN_DAY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REPAY_BEGIN_DAY);
    }
    if (null == this.ZX_PRICE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ZX_PRICE, __dataOut);
    }
    if (null == this.OVERDUE_REPAY_PRICE_B) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_REPAY_PRICE_B, __dataOut);
    }
    if (null == this.OVERDUE_REPAY_PRICE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OVERDUE_REPAY_PRICE, __dataOut);
    }
    if (null == this.REPAYED_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAYED_AMT, __dataOut);
    }
    if (null == this.REPAYED_PRICE_B) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.REPAYED_PRICE_B, __dataOut);
    }
    if (null == this.UNREPAYED_AMT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.UNREPAYED_AMT, __dataOut);
    }
    if (null == this.ALL_REPAYED_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ALL_REPAYED_TIME);
    }
    if (null == this.USER_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, USER_NAME);
    }
    if (null == this.BR_PRICE_PER_EXPECT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.BR_PRICE_PER_EXPECT, __dataOut);
    }
    if (null == this.REPAYMENT_TYPE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REPAYMENT_TYPE);
    }
    if (null == this.ACCU_PAID_INT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ACCU_PAID_INT, __dataOut);
    }
    if (null == this.ACCU_PAID_PULISH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ACCU_PAID_PULISH, __dataOut);
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
    __sb.append(FieldFormatter.escapeAndEnclose(APPLY_NO==null?"null":"" + APPLY_NO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DISBURSED_DATE==null?"null":DISBURSED_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DISBURSED_AMT==null?"null":DISBURSED_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(TERM==null?"null":"" + TERM, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(TERM_UNIT==null?"null":"" + TERM_UNIT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(INTEREST_RATE==null?"null":INTEREST_RATE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(STATUS==null?"null":STATUS, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_DAY==null?"null":"" + OVERDUE_DAY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_DAY_MAX==null?"null":"" + OVERDUE_DAY_MAX, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_TERM==null?"null":"" + OVERDUE_TERM, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_TERM_MAX==null?"null":"" + OVERDUE_TERM_MAX, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_AMT==null?"null":OVERDUE_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_AMT_MAX==null?"null":OVERDUE_AMT_MAX.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OUTSTANDING_AMT==null?"null":OUTSTANDING_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(TERM_PAID==null?"null":"" + TERM_PAID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_PRINCIPAL_AMT==null?"null":OVERDUE_PRINCIPAL_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MAX_OVERDUE_PRINCIPAL_AMT==null?"null":MAX_OVERDUE_PRINCIPAL_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRODUCT==null?"null":PRODUCT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRINCIPAL_TMONTH_AMT==null?"null":PRINCIPAL_TMONTH_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FILE_DATE==null?"null":FILE_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"null":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_FIRST_REPAY_OVERDUE_7D==null?"null":"" + IS_FIRST_REPAY_OVERDUE_7D, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_UNREPAY_AMT==null?"null":OVERDUE_UNREPAY_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_UNREPAY_L==null?"null":OVERDUE_UNREPAY_L.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_UNREPAY_SERVICE_FEE==null?"null":OVERDUE_UNREPAY_SERVICE_FEE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_UNREPAY_PUNISH==null?"null":OVERDUE_UNREPAY_PUNISH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_AMT_THIS_MONTH==null?"null":REPAY_AMT_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_L_THIS_MONTH==null?"null":REPAY_L_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_PUNISH_THIS_MONTH==null?"null":REPAY_PUNISH_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_SERVICE_FEE_THIS_MONTH==null?"null":REPAY_SERVICE_FEE_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SHOULD_B_THIS_MONTH==null?"null":SHOULD_B_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SHOULD_L_THIS_MONTH==null?"null":SHOULD_L_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SHOULD_REPAY_CNT==null?"null":"" + SHOULD_REPAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_BEGIN_DAY==null?"null":REPAY_BEGIN_DAY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ZX_PRICE==null?"null":ZX_PRICE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_REPAY_PRICE_B==null?"null":OVERDUE_REPAY_PRICE_B.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_REPAY_PRICE==null?"null":OVERDUE_REPAY_PRICE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAYED_AMT==null?"null":REPAYED_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAYED_PRICE_B==null?"null":REPAYED_PRICE_B.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(UNREPAYED_AMT==null?"null":UNREPAYED_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ALL_REPAYED_TIME==null?"null":ALL_REPAYED_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_NAME==null?"null":USER_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BR_PRICE_PER_EXPECT==null?"null":BR_PRICE_PER_EXPECT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAYMENT_TYPE==null?"null":REPAYMENT_TYPE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ACCU_PAID_INT==null?"null":ACCU_PAID_INT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ACCU_PAID_PULISH==null?"null":ACCU_PAID_PULISH.toPlainString(), delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(STAT_DATE==null?"null":"" + STAT_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(APPLY_NO==null?"null":"" + APPLY_NO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DISBURSED_DATE==null?"null":DISBURSED_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DISBURSED_AMT==null?"null":DISBURSED_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(TERM==null?"null":"" + TERM, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(TERM_UNIT==null?"null":"" + TERM_UNIT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(INTEREST_RATE==null?"null":INTEREST_RATE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(STATUS==null?"null":STATUS, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_DAY==null?"null":"" + OVERDUE_DAY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_DAY_MAX==null?"null":"" + OVERDUE_DAY_MAX, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_TERM==null?"null":"" + OVERDUE_TERM, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_TERM_MAX==null?"null":"" + OVERDUE_TERM_MAX, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_AMT==null?"null":OVERDUE_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_AMT_MAX==null?"null":OVERDUE_AMT_MAX.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OUTSTANDING_AMT==null?"null":OUTSTANDING_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(TERM_PAID==null?"null":"" + TERM_PAID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_PRINCIPAL_AMT==null?"null":OVERDUE_PRINCIPAL_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MAX_OVERDUE_PRINCIPAL_AMT==null?"null":MAX_OVERDUE_PRINCIPAL_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRODUCT==null?"null":PRODUCT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRINCIPAL_TMONTH_AMT==null?"null":PRINCIPAL_TMONTH_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FILE_DATE==null?"null":FILE_DATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"null":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_FIRST_REPAY_OVERDUE_7D==null?"null":"" + IS_FIRST_REPAY_OVERDUE_7D, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_UNREPAY_AMT==null?"null":OVERDUE_UNREPAY_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_UNREPAY_L==null?"null":OVERDUE_UNREPAY_L.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_UNREPAY_SERVICE_FEE==null?"null":OVERDUE_UNREPAY_SERVICE_FEE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_UNREPAY_PUNISH==null?"null":OVERDUE_UNREPAY_PUNISH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_AMT_THIS_MONTH==null?"null":REPAY_AMT_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_L_THIS_MONTH==null?"null":REPAY_L_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_PUNISH_THIS_MONTH==null?"null":REPAY_PUNISH_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_SERVICE_FEE_THIS_MONTH==null?"null":REPAY_SERVICE_FEE_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SHOULD_B_THIS_MONTH==null?"null":SHOULD_B_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SHOULD_L_THIS_MONTH==null?"null":SHOULD_L_THIS_MONTH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SHOULD_REPAY_CNT==null?"null":"" + SHOULD_REPAY_CNT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAY_BEGIN_DAY==null?"null":REPAY_BEGIN_DAY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ZX_PRICE==null?"null":ZX_PRICE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_REPAY_PRICE_B==null?"null":OVERDUE_REPAY_PRICE_B.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OVERDUE_REPAY_PRICE==null?"null":OVERDUE_REPAY_PRICE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAYED_AMT==null?"null":REPAYED_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAYED_PRICE_B==null?"null":REPAYED_PRICE_B.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(UNREPAYED_AMT==null?"null":UNREPAYED_AMT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ALL_REPAYED_TIME==null?"null":ALL_REPAYED_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_NAME==null?"null":USER_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BR_PRICE_PER_EXPECT==null?"null":BR_PRICE_PER_EXPECT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(REPAYMENT_TYPE==null?"null":REPAYMENT_TYPE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ACCU_PAID_INT==null?"null":ACCU_PAID_INT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ACCU_PAID_PULISH==null?"null":ACCU_PAID_PULISH.toPlainString(), delimiters));
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
      this.STAT_DATE = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.APPLY_NO = null; } else {
      this.APPLY_NO = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.DISBURSED_DATE = null; } else {
      this.DISBURSED_DATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.DISBURSED_AMT = null; } else {
      this.DISBURSED_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.TERM = null; } else {
      this.TERM = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.TERM_UNIT = null; } else {
      this.TERM_UNIT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.INTEREST_RATE = null; } else {
      this.INTEREST_RATE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.STATUS = null; } else {
      this.STATUS = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_DAY = null; } else {
      this.OVERDUE_DAY = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_DAY_MAX = null; } else {
      this.OVERDUE_DAY_MAX = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_TERM = null; } else {
      this.OVERDUE_TERM = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_TERM_MAX = null; } else {
      this.OVERDUE_TERM_MAX = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_AMT = null; } else {
      this.OVERDUE_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_AMT_MAX = null; } else {
      this.OVERDUE_AMT_MAX = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OUTSTANDING_AMT = null; } else {
      this.OUTSTANDING_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.TERM_PAID = null; } else {
      this.TERM_PAID = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_PRINCIPAL_AMT = null; } else {
      this.OVERDUE_PRINCIPAL_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.MAX_OVERDUE_PRINCIPAL_AMT = null; } else {
      this.MAX_OVERDUE_PRINCIPAL_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.PRODUCT = null; } else {
      this.PRODUCT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRINCIPAL_TMONTH_AMT = null; } else {
      this.PRINCIPAL_TMONTH_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.FILE_DATE = null; } else {
      this.FILE_DATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_FIRST_REPAY_OVERDUE_7D = null; } else {
      this.IS_FIRST_REPAY_OVERDUE_7D = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_UNREPAY_AMT = null; } else {
      this.OVERDUE_UNREPAY_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_UNREPAY_L = null; } else {
      this.OVERDUE_UNREPAY_L = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_UNREPAY_SERVICE_FEE = null; } else {
      this.OVERDUE_UNREPAY_SERVICE_FEE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_UNREPAY_PUNISH = null; } else {
      this.OVERDUE_UNREPAY_PUNISH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAY_AMT_THIS_MONTH = null; } else {
      this.REPAY_AMT_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAY_L_THIS_MONTH = null; } else {
      this.REPAY_L_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAY_PUNISH_THIS_MONTH = null; } else {
      this.REPAY_PUNISH_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAY_SERVICE_FEE_THIS_MONTH = null; } else {
      this.REPAY_SERVICE_FEE_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.SHOULD_B_THIS_MONTH = null; } else {
      this.SHOULD_B_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.SHOULD_L_THIS_MONTH = null; } else {
      this.SHOULD_L_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.SHOULD_REPAY_CNT = null; } else {
      this.SHOULD_REPAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REPAY_BEGIN_DAY = null; } else {
      this.REPAY_BEGIN_DAY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ZX_PRICE = null; } else {
      this.ZX_PRICE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_REPAY_PRICE_B = null; } else {
      this.OVERDUE_REPAY_PRICE_B = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_REPAY_PRICE = null; } else {
      this.OVERDUE_REPAY_PRICE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAYED_AMT = null; } else {
      this.REPAYED_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAYED_PRICE_B = null; } else {
      this.REPAYED_PRICE_B = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.UNREPAYED_AMT = null; } else {
      this.UNREPAYED_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.ALL_REPAYED_TIME = null; } else {
      this.ALL_REPAYED_TIME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.USER_NAME = null; } else {
      this.USER_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BR_PRICE_PER_EXPECT = null; } else {
      this.BR_PRICE_PER_EXPECT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REPAYMENT_TYPE = null; } else {
      this.REPAYMENT_TYPE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ACCU_PAID_INT = null; } else {
      this.ACCU_PAID_INT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ACCU_PAID_PULISH = null; } else {
      this.ACCU_PAID_PULISH = new java.math.BigDecimal(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.STAT_DATE = null; } else {
      this.STAT_DATE = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.APPLY_NO = null; } else {
      this.APPLY_NO = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.DISBURSED_DATE = null; } else {
      this.DISBURSED_DATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.DISBURSED_AMT = null; } else {
      this.DISBURSED_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.TERM = null; } else {
      this.TERM = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.TERM_UNIT = null; } else {
      this.TERM_UNIT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.INTEREST_RATE = null; } else {
      this.INTEREST_RATE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.STATUS = null; } else {
      this.STATUS = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_DAY = null; } else {
      this.OVERDUE_DAY = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_DAY_MAX = null; } else {
      this.OVERDUE_DAY_MAX = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_TERM = null; } else {
      this.OVERDUE_TERM = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_TERM_MAX = null; } else {
      this.OVERDUE_TERM_MAX = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_AMT = null; } else {
      this.OVERDUE_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_AMT_MAX = null; } else {
      this.OVERDUE_AMT_MAX = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OUTSTANDING_AMT = null; } else {
      this.OUTSTANDING_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.TERM_PAID = null; } else {
      this.TERM_PAID = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_PRINCIPAL_AMT = null; } else {
      this.OVERDUE_PRINCIPAL_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.MAX_OVERDUE_PRINCIPAL_AMT = null; } else {
      this.MAX_OVERDUE_PRINCIPAL_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.PRODUCT = null; } else {
      this.PRODUCT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRINCIPAL_TMONTH_AMT = null; } else {
      this.PRINCIPAL_TMONTH_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.FILE_DATE = null; } else {
      this.FILE_DATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_FIRST_REPAY_OVERDUE_7D = null; } else {
      this.IS_FIRST_REPAY_OVERDUE_7D = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_UNREPAY_AMT = null; } else {
      this.OVERDUE_UNREPAY_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_UNREPAY_L = null; } else {
      this.OVERDUE_UNREPAY_L = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_UNREPAY_SERVICE_FEE = null; } else {
      this.OVERDUE_UNREPAY_SERVICE_FEE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_UNREPAY_PUNISH = null; } else {
      this.OVERDUE_UNREPAY_PUNISH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAY_AMT_THIS_MONTH = null; } else {
      this.REPAY_AMT_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAY_L_THIS_MONTH = null; } else {
      this.REPAY_L_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAY_PUNISH_THIS_MONTH = null; } else {
      this.REPAY_PUNISH_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAY_SERVICE_FEE_THIS_MONTH = null; } else {
      this.REPAY_SERVICE_FEE_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.SHOULD_B_THIS_MONTH = null; } else {
      this.SHOULD_B_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.SHOULD_L_THIS_MONTH = null; } else {
      this.SHOULD_L_THIS_MONTH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.SHOULD_REPAY_CNT = null; } else {
      this.SHOULD_REPAY_CNT = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REPAY_BEGIN_DAY = null; } else {
      this.REPAY_BEGIN_DAY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ZX_PRICE = null; } else {
      this.ZX_PRICE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_REPAY_PRICE_B = null; } else {
      this.OVERDUE_REPAY_PRICE_B = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OVERDUE_REPAY_PRICE = null; } else {
      this.OVERDUE_REPAY_PRICE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAYED_AMT = null; } else {
      this.REPAYED_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.REPAYED_PRICE_B = null; } else {
      this.REPAYED_PRICE_B = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.UNREPAYED_AMT = null; } else {
      this.UNREPAYED_AMT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.ALL_REPAYED_TIME = null; } else {
      this.ALL_REPAYED_TIME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.USER_NAME = null; } else {
      this.USER_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BR_PRICE_PER_EXPECT = null; } else {
      this.BR_PRICE_PER_EXPECT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.REPAYMENT_TYPE = null; } else {
      this.REPAYMENT_TYPE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ACCU_PAID_INT = null; } else {
      this.ACCU_PAID_INT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ACCU_PAID_PULISH = null; } else {
      this.ACCU_PAID_PULISH = new java.math.BigDecimal(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    FACT_LOAN_AFTER_STATIC_DAILY o = (FACT_LOAN_AFTER_STATIC_DAILY) super.clone();
    return o;
  }

  public void clone0(FACT_LOAN_AFTER_STATIC_DAILY o) throws CloneNotSupportedException {
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("STAT_DATE", this.STAT_DATE);
    __sqoop$field_map.put("APPLY_NO", this.APPLY_NO);
    __sqoop$field_map.put("DISBURSED_DATE", this.DISBURSED_DATE);
    __sqoop$field_map.put("DISBURSED_AMT", this.DISBURSED_AMT);
    __sqoop$field_map.put("TERM", this.TERM);
    __sqoop$field_map.put("TERM_UNIT", this.TERM_UNIT);
    __sqoop$field_map.put("INTEREST_RATE", this.INTEREST_RATE);
    __sqoop$field_map.put("STATUS", this.STATUS);
    __sqoop$field_map.put("OVERDUE_DAY", this.OVERDUE_DAY);
    __sqoop$field_map.put("OVERDUE_DAY_MAX", this.OVERDUE_DAY_MAX);
    __sqoop$field_map.put("OVERDUE_TERM", this.OVERDUE_TERM);
    __sqoop$field_map.put("OVERDUE_TERM_MAX", this.OVERDUE_TERM_MAX);
    __sqoop$field_map.put("OVERDUE_AMT", this.OVERDUE_AMT);
    __sqoop$field_map.put("OVERDUE_AMT_MAX", this.OVERDUE_AMT_MAX);
    __sqoop$field_map.put("OUTSTANDING_AMT", this.OUTSTANDING_AMT);
    __sqoop$field_map.put("TERM_PAID", this.TERM_PAID);
    __sqoop$field_map.put("OVERDUE_PRINCIPAL_AMT", this.OVERDUE_PRINCIPAL_AMT);
    __sqoop$field_map.put("MAX_OVERDUE_PRINCIPAL_AMT", this.MAX_OVERDUE_PRINCIPAL_AMT);
    __sqoop$field_map.put("PRODUCT", this.PRODUCT);
    __sqoop$field_map.put("PRINCIPAL_TMONTH_AMT", this.PRINCIPAL_TMONTH_AMT);
    __sqoop$field_map.put("FILE_DATE", this.FILE_DATE);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("IS_FIRST_REPAY_OVERDUE_7D", this.IS_FIRST_REPAY_OVERDUE_7D);
    __sqoop$field_map.put("OVERDUE_UNREPAY_AMT", this.OVERDUE_UNREPAY_AMT);
    __sqoop$field_map.put("OVERDUE_UNREPAY_L", this.OVERDUE_UNREPAY_L);
    __sqoop$field_map.put("OVERDUE_UNREPAY_SERVICE_FEE", this.OVERDUE_UNREPAY_SERVICE_FEE);
    __sqoop$field_map.put("OVERDUE_UNREPAY_PUNISH", this.OVERDUE_UNREPAY_PUNISH);
    __sqoop$field_map.put("REPAY_AMT_THIS_MONTH", this.REPAY_AMT_THIS_MONTH);
    __sqoop$field_map.put("REPAY_L_THIS_MONTH", this.REPAY_L_THIS_MONTH);
    __sqoop$field_map.put("REPAY_PUNISH_THIS_MONTH", this.REPAY_PUNISH_THIS_MONTH);
    __sqoop$field_map.put("REPAY_SERVICE_FEE_THIS_MONTH", this.REPAY_SERVICE_FEE_THIS_MONTH);
    __sqoop$field_map.put("SHOULD_B_THIS_MONTH", this.SHOULD_B_THIS_MONTH);
    __sqoop$field_map.put("SHOULD_L_THIS_MONTH", this.SHOULD_L_THIS_MONTH);
    __sqoop$field_map.put("SHOULD_REPAY_CNT", this.SHOULD_REPAY_CNT);
    __sqoop$field_map.put("REPAY_BEGIN_DAY", this.REPAY_BEGIN_DAY);
    __sqoop$field_map.put("ZX_PRICE", this.ZX_PRICE);
    __sqoop$field_map.put("OVERDUE_REPAY_PRICE_B", this.OVERDUE_REPAY_PRICE_B);
    __sqoop$field_map.put("OVERDUE_REPAY_PRICE", this.OVERDUE_REPAY_PRICE);
    __sqoop$field_map.put("REPAYED_AMT", this.REPAYED_AMT);
    __sqoop$field_map.put("REPAYED_PRICE_B", this.REPAYED_PRICE_B);
    __sqoop$field_map.put("UNREPAYED_AMT", this.UNREPAYED_AMT);
    __sqoop$field_map.put("ALL_REPAYED_TIME", this.ALL_REPAYED_TIME);
    __sqoop$field_map.put("USER_NAME", this.USER_NAME);
    __sqoop$field_map.put("BR_PRICE_PER_EXPECT", this.BR_PRICE_PER_EXPECT);
    __sqoop$field_map.put("REPAYMENT_TYPE", this.REPAYMENT_TYPE);
    __sqoop$field_map.put("ACCU_PAID_INT", this.ACCU_PAID_INT);
    __sqoop$field_map.put("ACCU_PAID_PULISH", this.ACCU_PAID_PULISH);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("STAT_DATE", this.STAT_DATE);
    __sqoop$field_map.put("APPLY_NO", this.APPLY_NO);
    __sqoop$field_map.put("DISBURSED_DATE", this.DISBURSED_DATE);
    __sqoop$field_map.put("DISBURSED_AMT", this.DISBURSED_AMT);
    __sqoop$field_map.put("TERM", this.TERM);
    __sqoop$field_map.put("TERM_UNIT", this.TERM_UNIT);
    __sqoop$field_map.put("INTEREST_RATE", this.INTEREST_RATE);
    __sqoop$field_map.put("STATUS", this.STATUS);
    __sqoop$field_map.put("OVERDUE_DAY", this.OVERDUE_DAY);
    __sqoop$field_map.put("OVERDUE_DAY_MAX", this.OVERDUE_DAY_MAX);
    __sqoop$field_map.put("OVERDUE_TERM", this.OVERDUE_TERM);
    __sqoop$field_map.put("OVERDUE_TERM_MAX", this.OVERDUE_TERM_MAX);
    __sqoop$field_map.put("OVERDUE_AMT", this.OVERDUE_AMT);
    __sqoop$field_map.put("OVERDUE_AMT_MAX", this.OVERDUE_AMT_MAX);
    __sqoop$field_map.put("OUTSTANDING_AMT", this.OUTSTANDING_AMT);
    __sqoop$field_map.put("TERM_PAID", this.TERM_PAID);
    __sqoop$field_map.put("OVERDUE_PRINCIPAL_AMT", this.OVERDUE_PRINCIPAL_AMT);
    __sqoop$field_map.put("MAX_OVERDUE_PRINCIPAL_AMT", this.MAX_OVERDUE_PRINCIPAL_AMT);
    __sqoop$field_map.put("PRODUCT", this.PRODUCT);
    __sqoop$field_map.put("PRINCIPAL_TMONTH_AMT", this.PRINCIPAL_TMONTH_AMT);
    __sqoop$field_map.put("FILE_DATE", this.FILE_DATE);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("IS_FIRST_REPAY_OVERDUE_7D", this.IS_FIRST_REPAY_OVERDUE_7D);
    __sqoop$field_map.put("OVERDUE_UNREPAY_AMT", this.OVERDUE_UNREPAY_AMT);
    __sqoop$field_map.put("OVERDUE_UNREPAY_L", this.OVERDUE_UNREPAY_L);
    __sqoop$field_map.put("OVERDUE_UNREPAY_SERVICE_FEE", this.OVERDUE_UNREPAY_SERVICE_FEE);
    __sqoop$field_map.put("OVERDUE_UNREPAY_PUNISH", this.OVERDUE_UNREPAY_PUNISH);
    __sqoop$field_map.put("REPAY_AMT_THIS_MONTH", this.REPAY_AMT_THIS_MONTH);
    __sqoop$field_map.put("REPAY_L_THIS_MONTH", this.REPAY_L_THIS_MONTH);
    __sqoop$field_map.put("REPAY_PUNISH_THIS_MONTH", this.REPAY_PUNISH_THIS_MONTH);
    __sqoop$field_map.put("REPAY_SERVICE_FEE_THIS_MONTH", this.REPAY_SERVICE_FEE_THIS_MONTH);
    __sqoop$field_map.put("SHOULD_B_THIS_MONTH", this.SHOULD_B_THIS_MONTH);
    __sqoop$field_map.put("SHOULD_L_THIS_MONTH", this.SHOULD_L_THIS_MONTH);
    __sqoop$field_map.put("SHOULD_REPAY_CNT", this.SHOULD_REPAY_CNT);
    __sqoop$field_map.put("REPAY_BEGIN_DAY", this.REPAY_BEGIN_DAY);
    __sqoop$field_map.put("ZX_PRICE", this.ZX_PRICE);
    __sqoop$field_map.put("OVERDUE_REPAY_PRICE_B", this.OVERDUE_REPAY_PRICE_B);
    __sqoop$field_map.put("OVERDUE_REPAY_PRICE", this.OVERDUE_REPAY_PRICE);
    __sqoop$field_map.put("REPAYED_AMT", this.REPAYED_AMT);
    __sqoop$field_map.put("REPAYED_PRICE_B", this.REPAYED_PRICE_B);
    __sqoop$field_map.put("UNREPAYED_AMT", this.UNREPAYED_AMT);
    __sqoop$field_map.put("ALL_REPAYED_TIME", this.ALL_REPAYED_TIME);
    __sqoop$field_map.put("USER_NAME", this.USER_NAME);
    __sqoop$field_map.put("BR_PRICE_PER_EXPECT", this.BR_PRICE_PER_EXPECT);
    __sqoop$field_map.put("REPAYMENT_TYPE", this.REPAYMENT_TYPE);
    __sqoop$field_map.put("ACCU_PAID_INT", this.ACCU_PAID_INT);
    __sqoop$field_map.put("ACCU_PAID_PULISH", this.ACCU_PAID_PULISH);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("STAT_DATE".equals(__fieldName)) {
      this.STAT_DATE = (Long) __fieldVal;
    }
    else    if ("APPLY_NO".equals(__fieldName)) {
      this.APPLY_NO = (Long) __fieldVal;
    }
    else    if ("DISBURSED_DATE".equals(__fieldName)) {
      this.DISBURSED_DATE = (String) __fieldVal;
    }
    else    if ("DISBURSED_AMT".equals(__fieldName)) {
      this.DISBURSED_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("TERM".equals(__fieldName)) {
      this.TERM = (Integer) __fieldVal;
    }
    else    if ("TERM_UNIT".equals(__fieldName)) {
      this.TERM_UNIT = (Integer) __fieldVal;
    }
    else    if ("INTEREST_RATE".equals(__fieldName)) {
      this.INTEREST_RATE = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("STATUS".equals(__fieldName)) {
      this.STATUS = (String) __fieldVal;
    }
    else    if ("OVERDUE_DAY".equals(__fieldName)) {
      this.OVERDUE_DAY = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_DAY_MAX".equals(__fieldName)) {
      this.OVERDUE_DAY_MAX = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_TERM".equals(__fieldName)) {
      this.OVERDUE_TERM = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_TERM_MAX".equals(__fieldName)) {
      this.OVERDUE_TERM_MAX = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_AMT".equals(__fieldName)) {
      this.OVERDUE_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("OVERDUE_AMT_MAX".equals(__fieldName)) {
      this.OVERDUE_AMT_MAX = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("OUTSTANDING_AMT".equals(__fieldName)) {
      this.OUTSTANDING_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("TERM_PAID".equals(__fieldName)) {
      this.TERM_PAID = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_PRINCIPAL_AMT".equals(__fieldName)) {
      this.OVERDUE_PRINCIPAL_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("MAX_OVERDUE_PRINCIPAL_AMT".equals(__fieldName)) {
      this.MAX_OVERDUE_PRINCIPAL_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("PRODUCT".equals(__fieldName)) {
      this.PRODUCT = (String) __fieldVal;
    }
    else    if ("PRINCIPAL_TMONTH_AMT".equals(__fieldName)) {
      this.PRINCIPAL_TMONTH_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("FILE_DATE".equals(__fieldName)) {
      this.FILE_DATE = (String) __fieldVal;
    }
    else    if ("USER_ID".equals(__fieldName)) {
      this.USER_ID = (Long) __fieldVal;
    }
    else    if ("IS_FIRST_REPAY_OVERDUE_7D".equals(__fieldName)) {
      this.IS_FIRST_REPAY_OVERDUE_7D = (Integer) __fieldVal;
    }
    else    if ("OVERDUE_UNREPAY_AMT".equals(__fieldName)) {
      this.OVERDUE_UNREPAY_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("OVERDUE_UNREPAY_L".equals(__fieldName)) {
      this.OVERDUE_UNREPAY_L = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("OVERDUE_UNREPAY_SERVICE_FEE".equals(__fieldName)) {
      this.OVERDUE_UNREPAY_SERVICE_FEE = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("OVERDUE_UNREPAY_PUNISH".equals(__fieldName)) {
      this.OVERDUE_UNREPAY_PUNISH = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("REPAY_AMT_THIS_MONTH".equals(__fieldName)) {
      this.REPAY_AMT_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("REPAY_L_THIS_MONTH".equals(__fieldName)) {
      this.REPAY_L_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("REPAY_PUNISH_THIS_MONTH".equals(__fieldName)) {
      this.REPAY_PUNISH_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("REPAY_SERVICE_FEE_THIS_MONTH".equals(__fieldName)) {
      this.REPAY_SERVICE_FEE_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("SHOULD_B_THIS_MONTH".equals(__fieldName)) {
      this.SHOULD_B_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("SHOULD_L_THIS_MONTH".equals(__fieldName)) {
      this.SHOULD_L_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("SHOULD_REPAY_CNT".equals(__fieldName)) {
      this.SHOULD_REPAY_CNT = (Integer) __fieldVal;
    }
    else    if ("REPAY_BEGIN_DAY".equals(__fieldName)) {
      this.REPAY_BEGIN_DAY = (String) __fieldVal;
    }
    else    if ("ZX_PRICE".equals(__fieldName)) {
      this.ZX_PRICE = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("OVERDUE_REPAY_PRICE_B".equals(__fieldName)) {
      this.OVERDUE_REPAY_PRICE_B = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("OVERDUE_REPAY_PRICE".equals(__fieldName)) {
      this.OVERDUE_REPAY_PRICE = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("REPAYED_AMT".equals(__fieldName)) {
      this.REPAYED_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("REPAYED_PRICE_B".equals(__fieldName)) {
      this.REPAYED_PRICE_B = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("UNREPAYED_AMT".equals(__fieldName)) {
      this.UNREPAYED_AMT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("ALL_REPAYED_TIME".equals(__fieldName)) {
      this.ALL_REPAYED_TIME = (String) __fieldVal;
    }
    else    if ("USER_NAME".equals(__fieldName)) {
      this.USER_NAME = (String) __fieldVal;
    }
    else    if ("BR_PRICE_PER_EXPECT".equals(__fieldName)) {
      this.BR_PRICE_PER_EXPECT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("REPAYMENT_TYPE".equals(__fieldName)) {
      this.REPAYMENT_TYPE = (String) __fieldVal;
    }
    else    if ("ACCU_PAID_INT".equals(__fieldName)) {
      this.ACCU_PAID_INT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("ACCU_PAID_PULISH".equals(__fieldName)) {
      this.ACCU_PAID_PULISH = (java.math.BigDecimal) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("STAT_DATE".equals(__fieldName)) {
      this.STAT_DATE = (Long) __fieldVal;
      return true;
    }
    else    if ("APPLY_NO".equals(__fieldName)) {
      this.APPLY_NO = (Long) __fieldVal;
      return true;
    }
    else    if ("DISBURSED_DATE".equals(__fieldName)) {
      this.DISBURSED_DATE = (String) __fieldVal;
      return true;
    }
    else    if ("DISBURSED_AMT".equals(__fieldName)) {
      this.DISBURSED_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("TERM".equals(__fieldName)) {
      this.TERM = (Integer) __fieldVal;
      return true;
    }
    else    if ("TERM_UNIT".equals(__fieldName)) {
      this.TERM_UNIT = (Integer) __fieldVal;
      return true;
    }
    else    if ("INTEREST_RATE".equals(__fieldName)) {
      this.INTEREST_RATE = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("STATUS".equals(__fieldName)) {
      this.STATUS = (String) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_DAY".equals(__fieldName)) {
      this.OVERDUE_DAY = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_DAY_MAX".equals(__fieldName)) {
      this.OVERDUE_DAY_MAX = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_TERM".equals(__fieldName)) {
      this.OVERDUE_TERM = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_TERM_MAX".equals(__fieldName)) {
      this.OVERDUE_TERM_MAX = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_AMT".equals(__fieldName)) {
      this.OVERDUE_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_AMT_MAX".equals(__fieldName)) {
      this.OVERDUE_AMT_MAX = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("OUTSTANDING_AMT".equals(__fieldName)) {
      this.OUTSTANDING_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("TERM_PAID".equals(__fieldName)) {
      this.TERM_PAID = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_PRINCIPAL_AMT".equals(__fieldName)) {
      this.OVERDUE_PRINCIPAL_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("MAX_OVERDUE_PRINCIPAL_AMT".equals(__fieldName)) {
      this.MAX_OVERDUE_PRINCIPAL_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("PRODUCT".equals(__fieldName)) {
      this.PRODUCT = (String) __fieldVal;
      return true;
    }
    else    if ("PRINCIPAL_TMONTH_AMT".equals(__fieldName)) {
      this.PRINCIPAL_TMONTH_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("FILE_DATE".equals(__fieldName)) {
      this.FILE_DATE = (String) __fieldVal;
      return true;
    }
    else    if ("USER_ID".equals(__fieldName)) {
      this.USER_ID = (Long) __fieldVal;
      return true;
    }
    else    if ("IS_FIRST_REPAY_OVERDUE_7D".equals(__fieldName)) {
      this.IS_FIRST_REPAY_OVERDUE_7D = (Integer) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_UNREPAY_AMT".equals(__fieldName)) {
      this.OVERDUE_UNREPAY_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_UNREPAY_L".equals(__fieldName)) {
      this.OVERDUE_UNREPAY_L = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_UNREPAY_SERVICE_FEE".equals(__fieldName)) {
      this.OVERDUE_UNREPAY_SERVICE_FEE = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_UNREPAY_PUNISH".equals(__fieldName)) {
      this.OVERDUE_UNREPAY_PUNISH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("REPAY_AMT_THIS_MONTH".equals(__fieldName)) {
      this.REPAY_AMT_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("REPAY_L_THIS_MONTH".equals(__fieldName)) {
      this.REPAY_L_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("REPAY_PUNISH_THIS_MONTH".equals(__fieldName)) {
      this.REPAY_PUNISH_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("REPAY_SERVICE_FEE_THIS_MONTH".equals(__fieldName)) {
      this.REPAY_SERVICE_FEE_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("SHOULD_B_THIS_MONTH".equals(__fieldName)) {
      this.SHOULD_B_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("SHOULD_L_THIS_MONTH".equals(__fieldName)) {
      this.SHOULD_L_THIS_MONTH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("SHOULD_REPAY_CNT".equals(__fieldName)) {
      this.SHOULD_REPAY_CNT = (Integer) __fieldVal;
      return true;
    }
    else    if ("REPAY_BEGIN_DAY".equals(__fieldName)) {
      this.REPAY_BEGIN_DAY = (String) __fieldVal;
      return true;
    }
    else    if ("ZX_PRICE".equals(__fieldName)) {
      this.ZX_PRICE = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_REPAY_PRICE_B".equals(__fieldName)) {
      this.OVERDUE_REPAY_PRICE_B = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("OVERDUE_REPAY_PRICE".equals(__fieldName)) {
      this.OVERDUE_REPAY_PRICE = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("REPAYED_AMT".equals(__fieldName)) {
      this.REPAYED_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("REPAYED_PRICE_B".equals(__fieldName)) {
      this.REPAYED_PRICE_B = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("UNREPAYED_AMT".equals(__fieldName)) {
      this.UNREPAYED_AMT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("ALL_REPAYED_TIME".equals(__fieldName)) {
      this.ALL_REPAYED_TIME = (String) __fieldVal;
      return true;
    }
    else    if ("USER_NAME".equals(__fieldName)) {
      this.USER_NAME = (String) __fieldVal;
      return true;
    }
    else    if ("BR_PRICE_PER_EXPECT".equals(__fieldName)) {
      this.BR_PRICE_PER_EXPECT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("REPAYMENT_TYPE".equals(__fieldName)) {
      this.REPAYMENT_TYPE = (String) __fieldVal;
      return true;
    }
    else    if ("ACCU_PAID_INT".equals(__fieldName)) {
      this.ACCU_PAID_INT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("ACCU_PAID_PULISH".equals(__fieldName)) {
      this.ACCU_PAID_PULISH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
