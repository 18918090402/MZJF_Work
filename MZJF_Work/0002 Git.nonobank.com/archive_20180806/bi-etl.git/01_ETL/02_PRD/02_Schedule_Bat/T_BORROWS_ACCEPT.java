// ORM class for table 'T_BORROWS_ACCEPT'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Fri Dec 09 10:35:38 CST 2016
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

public class T_BORROWS_ACCEPT extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private Long ID;
  public Long get_ID() {
    return ID;
  }
  public void set_ID(Long ID) {
    this.ID = ID;
  }
  public T_BORROWS_ACCEPT with_ID(Long ID) {
    this.ID = ID;
    return this;
  }
  private Long USER_ID;
  public Long get_USER_ID() {
    return USER_ID;
  }
  public void set_USER_ID(Long USER_ID) {
    this.USER_ID = USER_ID;
  }
  public T_BORROWS_ACCEPT with_USER_ID(Long USER_ID) {
    this.USER_ID = USER_ID;
    return this;
  }
  private Long BO_ID;
  public Long get_BO_ID() {
    return BO_ID;
  }
  public void set_BO_ID(Long BO_ID) {
    this.BO_ID = BO_ID;
  }
  public T_BORROWS_ACCEPT with_BO_ID(Long BO_ID) {
    this.BO_ID = BO_ID;
    return this;
  }
  private Boolean IS_VIP;
  public Boolean get_IS_VIP() {
    return IS_VIP;
  }
  public void set_IS_VIP(Boolean IS_VIP) {
    this.IS_VIP = IS_VIP;
  }
  public T_BORROWS_ACCEPT with_IS_VIP(Boolean IS_VIP) {
    this.IS_VIP = IS_VIP;
    return this;
  }
  private Long VA_ID;
  public Long get_VA_ID() {
    return VA_ID;
  }
  public void set_VA_ID(Long VA_ID) {
    this.VA_ID = VA_ID;
  }
  public T_BORROWS_ACCEPT with_VA_ID(Long VA_ID) {
    this.VA_ID = VA_ID;
    return this;
  }
  private java.math.BigDecimal ORIGINAL_PRINCIPAL;
  public java.math.BigDecimal get_ORIGINAL_PRINCIPAL() {
    return ORIGINAL_PRINCIPAL;
  }
  public void set_ORIGINAL_PRINCIPAL(java.math.BigDecimal ORIGINAL_PRINCIPAL) {
    this.ORIGINAL_PRINCIPAL = ORIGINAL_PRINCIPAL;
  }
  public T_BORROWS_ACCEPT with_ORIGINAL_PRINCIPAL(java.math.BigDecimal ORIGINAL_PRINCIPAL) {
    this.ORIGINAL_PRINCIPAL = ORIGINAL_PRINCIPAL;
    return this;
  }
  private java.math.BigDecimal PRICE_PRINCIPAL;
  public java.math.BigDecimal get_PRICE_PRINCIPAL() {
    return PRICE_PRINCIPAL;
  }
  public void set_PRICE_PRINCIPAL(java.math.BigDecimal PRICE_PRINCIPAL) {
    this.PRICE_PRINCIPAL = PRICE_PRINCIPAL;
  }
  public T_BORROWS_ACCEPT with_PRICE_PRINCIPAL(java.math.BigDecimal PRICE_PRINCIPAL) {
    this.PRICE_PRINCIPAL = PRICE_PRINCIPAL;
    return this;
  }
  private java.math.BigDecimal PRICE_INTEREST;
  public java.math.BigDecimal get_PRICE_INTEREST() {
    return PRICE_INTEREST;
  }
  public void set_PRICE_INTEREST(java.math.BigDecimal PRICE_INTEREST) {
    this.PRICE_INTEREST = PRICE_INTEREST;
  }
  public T_BORROWS_ACCEPT with_PRICE_INTEREST(java.math.BigDecimal PRICE_INTEREST) {
    this.PRICE_INTEREST = PRICE_INTEREST;
    return this;
  }
  private java.math.BigDecimal PRICE;
  public java.math.BigDecimal get_PRICE() {
    return PRICE;
  }
  public void set_PRICE(java.math.BigDecimal PRICE) {
    this.PRICE = PRICE;
  }
  public T_BORROWS_ACCEPT with_PRICE(java.math.BigDecimal PRICE) {
    this.PRICE = PRICE;
    return this;
  }
  private java.math.BigDecimal PRICE_PUNISH;
  public java.math.BigDecimal get_PRICE_PUNISH() {
    return PRICE_PUNISH;
  }
  public void set_PRICE_PUNISH(java.math.BigDecimal PRICE_PUNISH) {
    this.PRICE_PUNISH = PRICE_PUNISH;
  }
  public T_BORROWS_ACCEPT with_PRICE_PUNISH(java.math.BigDecimal PRICE_PUNISH) {
    this.PRICE_PUNISH = PRICE_PUNISH;
    return this;
  }
  private java.sql.Date PLAN_TIME;
  public java.sql.Date get_PLAN_TIME() {
    return PLAN_TIME;
  }
  public void set_PLAN_TIME(java.sql.Date PLAN_TIME) {
    this.PLAN_TIME = PLAN_TIME;
  }
  public T_BORROWS_ACCEPT with_PLAN_TIME(java.sql.Date PLAN_TIME) {
    this.PLAN_TIME = PLAN_TIME;
    return this;
  }
  private java.sql.Timestamp SUCCESS_TIME;
  public java.sql.Timestamp get_SUCCESS_TIME() {
    return SUCCESS_TIME;
  }
  public void set_SUCCESS_TIME(java.sql.Timestamp SUCCESS_TIME) {
    this.SUCCESS_TIME = SUCCESS_TIME;
  }
  public T_BORROWS_ACCEPT with_SUCCESS_TIME(java.sql.Timestamp SUCCESS_TIME) {
    this.SUCCESS_TIME = SUCCESS_TIME;
    return this;
  }
  private Boolean IS_PAY;
  public Boolean get_IS_PAY() {
    return IS_PAY;
  }
  public void set_IS_PAY(Boolean IS_PAY) {
    this.IS_PAY = IS_PAY;
  }
  public T_BORROWS_ACCEPT with_IS_PAY(Boolean IS_PAY) {
    this.IS_PAY = IS_PAY;
    return this;
  }
  private java.math.BigDecimal OWNER_RATE;
  public java.math.BigDecimal get_OWNER_RATE() {
    return OWNER_RATE;
  }
  public void set_OWNER_RATE(java.math.BigDecimal OWNER_RATE) {
    this.OWNER_RATE = OWNER_RATE;
  }
  public T_BORROWS_ACCEPT with_OWNER_RATE(java.math.BigDecimal OWNER_RATE) {
    this.OWNER_RATE = OWNER_RATE;
    return this;
  }
  private Boolean IS_LENDER;
  public Boolean get_IS_LENDER() {
    return IS_LENDER;
  }
  public void set_IS_LENDER(Boolean IS_LENDER) {
    this.IS_LENDER = IS_LENDER;
  }
  public T_BORROWS_ACCEPT with_IS_LENDER(Boolean IS_LENDER) {
    this.IS_LENDER = IS_LENDER;
    return this;
  }
  private Integer EXPECT_NUM;
  public Integer get_EXPECT_NUM() {
    return EXPECT_NUM;
  }
  public void set_EXPECT_NUM(Integer EXPECT_NUM) {
    this.EXPECT_NUM = EXPECT_NUM;
  }
  public T_BORROWS_ACCEPT with_EXPECT_NUM(Integer EXPECT_NUM) {
    this.EXPECT_NUM = EXPECT_NUM;
    return this;
  }
  private java.math.BigDecimal BA_TRANSFER;
  public java.math.BigDecimal get_BA_TRANSFER() {
    return BA_TRANSFER;
  }
  public void set_BA_TRANSFER(java.math.BigDecimal BA_TRANSFER) {
    this.BA_TRANSFER = BA_TRANSFER;
  }
  public T_BORROWS_ACCEPT with_BA_TRANSFER(java.math.BigDecimal BA_TRANSFER) {
    this.BA_TRANSFER = BA_TRANSFER;
    return this;
  }
  private Integer BA_IS_TRANSFER;
  public Integer get_BA_IS_TRANSFER() {
    return BA_IS_TRANSFER;
  }
  public void set_BA_IS_TRANSFER(Integer BA_IS_TRANSFER) {
    this.BA_IS_TRANSFER = BA_IS_TRANSFER;
  }
  public T_BORROWS_ACCEPT with_BA_IS_TRANSFER(Integer BA_IS_TRANSFER) {
    this.BA_IS_TRANSFER = BA_IS_TRANSFER;
    return this;
  }
  private Integer VERSION;
  public Integer get_VERSION() {
    return VERSION;
  }
  public void set_VERSION(Integer VERSION) {
    this.VERSION = VERSION;
  }
  public T_BORROWS_ACCEPT with_VERSION(Integer VERSION) {
    this.VERSION = VERSION;
    return this;
  }
  private java.sql.Timestamp CREATE_TIME;
  public java.sql.Timestamp get_CREATE_TIME() {
    return CREATE_TIME;
  }
  public void set_CREATE_TIME(java.sql.Timestamp CREATE_TIME) {
    this.CREATE_TIME = CREATE_TIME;
  }
  public T_BORROWS_ACCEPT with_CREATE_TIME(java.sql.Timestamp CREATE_TIME) {
    this.CREATE_TIME = CREATE_TIME;
    return this;
  }
  private java.sql.Timestamp UPDATE_TIME;
  public java.sql.Timestamp get_UPDATE_TIME() {
    return UPDATE_TIME;
  }
  public void set_UPDATE_TIME(java.sql.Timestamp UPDATE_TIME) {
    this.UPDATE_TIME = UPDATE_TIME;
  }
  public T_BORROWS_ACCEPT with_UPDATE_TIME(java.sql.Timestamp UPDATE_TIME) {
    this.UPDATE_TIME = UPDATE_TIME;
    return this;
  }
  private Integer IS_DELETE_FLAG;
  public Integer get_IS_DELETE_FLAG() {
    return IS_DELETE_FLAG;
  }
  public void set_IS_DELETE_FLAG(Integer IS_DELETE_FLAG) {
    this.IS_DELETE_FLAG = IS_DELETE_FLAG;
  }
  public T_BORROWS_ACCEPT with_IS_DELETE_FLAG(Integer IS_DELETE_FLAG) {
    this.IS_DELETE_FLAG = IS_DELETE_FLAG;
    return this;
  }
  private String DW_CREATE_BY;
  public String get_DW_CREATE_BY() {
    return DW_CREATE_BY;
  }
  public void set_DW_CREATE_BY(String DW_CREATE_BY) {
    this.DW_CREATE_BY = DW_CREATE_BY;
  }
  public T_BORROWS_ACCEPT with_DW_CREATE_BY(String DW_CREATE_BY) {
    this.DW_CREATE_BY = DW_CREATE_BY;
    return this;
  }
  private java.sql.Timestamp DW_CREATE_TIME;
  public java.sql.Timestamp get_DW_CREATE_TIME() {
    return DW_CREATE_TIME;
  }
  public void set_DW_CREATE_TIME(java.sql.Timestamp DW_CREATE_TIME) {
    this.DW_CREATE_TIME = DW_CREATE_TIME;
  }
  public T_BORROWS_ACCEPT with_DW_CREATE_TIME(java.sql.Timestamp DW_CREATE_TIME) {
    this.DW_CREATE_TIME = DW_CREATE_TIME;
    return this;
  }
  private String DW_UPDATE_BY;
  public String get_DW_UPDATE_BY() {
    return DW_UPDATE_BY;
  }
  public void set_DW_UPDATE_BY(String DW_UPDATE_BY) {
    this.DW_UPDATE_BY = DW_UPDATE_BY;
  }
  public T_BORROWS_ACCEPT with_DW_UPDATE_BY(String DW_UPDATE_BY) {
    this.DW_UPDATE_BY = DW_UPDATE_BY;
    return this;
  }
  private java.sql.Timestamp DW_UPDATE_TIME;
  public java.sql.Timestamp get_DW_UPDATE_TIME() {
    return DW_UPDATE_TIME;
  }
  public void set_DW_UPDATE_TIME(java.sql.Timestamp DW_UPDATE_TIME) {
    this.DW_UPDATE_TIME = DW_UPDATE_TIME;
  }
  public T_BORROWS_ACCEPT with_DW_UPDATE_TIME(java.sql.Timestamp DW_UPDATE_TIME) {
    this.DW_UPDATE_TIME = DW_UPDATE_TIME;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof T_BORROWS_ACCEPT)) {
      return false;
    }
    T_BORROWS_ACCEPT that = (T_BORROWS_ACCEPT) o;
    boolean equal = true;
    equal = equal && (this.ID == null ? that.ID == null : this.ID.equals(that.ID));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.BO_ID == null ? that.BO_ID == null : this.BO_ID.equals(that.BO_ID));
    equal = equal && (this.IS_VIP == null ? that.IS_VIP == null : this.IS_VIP.equals(that.IS_VIP));
    equal = equal && (this.VA_ID == null ? that.VA_ID == null : this.VA_ID.equals(that.VA_ID));
    equal = equal && (this.ORIGINAL_PRINCIPAL == null ? that.ORIGINAL_PRINCIPAL == null : this.ORIGINAL_PRINCIPAL.equals(that.ORIGINAL_PRINCIPAL));
    equal = equal && (this.PRICE_PRINCIPAL == null ? that.PRICE_PRINCIPAL == null : this.PRICE_PRINCIPAL.equals(that.PRICE_PRINCIPAL));
    equal = equal && (this.PRICE_INTEREST == null ? that.PRICE_INTEREST == null : this.PRICE_INTEREST.equals(that.PRICE_INTEREST));
    equal = equal && (this.PRICE == null ? that.PRICE == null : this.PRICE.equals(that.PRICE));
    equal = equal && (this.PRICE_PUNISH == null ? that.PRICE_PUNISH == null : this.PRICE_PUNISH.equals(that.PRICE_PUNISH));
    equal = equal && (this.PLAN_TIME == null ? that.PLAN_TIME == null : this.PLAN_TIME.equals(that.PLAN_TIME));
    equal = equal && (this.SUCCESS_TIME == null ? that.SUCCESS_TIME == null : this.SUCCESS_TIME.equals(that.SUCCESS_TIME));
    equal = equal && (this.IS_PAY == null ? that.IS_PAY == null : this.IS_PAY.equals(that.IS_PAY));
    equal = equal && (this.OWNER_RATE == null ? that.OWNER_RATE == null : this.OWNER_RATE.equals(that.OWNER_RATE));
    equal = equal && (this.IS_LENDER == null ? that.IS_LENDER == null : this.IS_LENDER.equals(that.IS_LENDER));
    equal = equal && (this.EXPECT_NUM == null ? that.EXPECT_NUM == null : this.EXPECT_NUM.equals(that.EXPECT_NUM));
    equal = equal && (this.BA_TRANSFER == null ? that.BA_TRANSFER == null : this.BA_TRANSFER.equals(that.BA_TRANSFER));
    equal = equal && (this.BA_IS_TRANSFER == null ? that.BA_IS_TRANSFER == null : this.BA_IS_TRANSFER.equals(that.BA_IS_TRANSFER));
    equal = equal && (this.VERSION == null ? that.VERSION == null : this.VERSION.equals(that.VERSION));
    equal = equal && (this.CREATE_TIME == null ? that.CREATE_TIME == null : this.CREATE_TIME.equals(that.CREATE_TIME));
    equal = equal && (this.UPDATE_TIME == null ? that.UPDATE_TIME == null : this.UPDATE_TIME.equals(that.UPDATE_TIME));
    equal = equal && (this.IS_DELETE_FLAG == null ? that.IS_DELETE_FLAG == null : this.IS_DELETE_FLAG.equals(that.IS_DELETE_FLAG));
    equal = equal && (this.DW_CREATE_BY == null ? that.DW_CREATE_BY == null : this.DW_CREATE_BY.equals(that.DW_CREATE_BY));
    equal = equal && (this.DW_CREATE_TIME == null ? that.DW_CREATE_TIME == null : this.DW_CREATE_TIME.equals(that.DW_CREATE_TIME));
    equal = equal && (this.DW_UPDATE_BY == null ? that.DW_UPDATE_BY == null : this.DW_UPDATE_BY.equals(that.DW_UPDATE_BY));
    equal = equal && (this.DW_UPDATE_TIME == null ? that.DW_UPDATE_TIME == null : this.DW_UPDATE_TIME.equals(that.DW_UPDATE_TIME));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof T_BORROWS_ACCEPT)) {
      return false;
    }
    T_BORROWS_ACCEPT that = (T_BORROWS_ACCEPT) o;
    boolean equal = true;
    equal = equal && (this.ID == null ? that.ID == null : this.ID.equals(that.ID));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.BO_ID == null ? that.BO_ID == null : this.BO_ID.equals(that.BO_ID));
    equal = equal && (this.IS_VIP == null ? that.IS_VIP == null : this.IS_VIP.equals(that.IS_VIP));
    equal = equal && (this.VA_ID == null ? that.VA_ID == null : this.VA_ID.equals(that.VA_ID));
    equal = equal && (this.ORIGINAL_PRINCIPAL == null ? that.ORIGINAL_PRINCIPAL == null : this.ORIGINAL_PRINCIPAL.equals(that.ORIGINAL_PRINCIPAL));
    equal = equal && (this.PRICE_PRINCIPAL == null ? that.PRICE_PRINCIPAL == null : this.PRICE_PRINCIPAL.equals(that.PRICE_PRINCIPAL));
    equal = equal && (this.PRICE_INTEREST == null ? that.PRICE_INTEREST == null : this.PRICE_INTEREST.equals(that.PRICE_INTEREST));
    equal = equal && (this.PRICE == null ? that.PRICE == null : this.PRICE.equals(that.PRICE));
    equal = equal && (this.PRICE_PUNISH == null ? that.PRICE_PUNISH == null : this.PRICE_PUNISH.equals(that.PRICE_PUNISH));
    equal = equal && (this.PLAN_TIME == null ? that.PLAN_TIME == null : this.PLAN_TIME.equals(that.PLAN_TIME));
    equal = equal && (this.SUCCESS_TIME == null ? that.SUCCESS_TIME == null : this.SUCCESS_TIME.equals(that.SUCCESS_TIME));
    equal = equal && (this.IS_PAY == null ? that.IS_PAY == null : this.IS_PAY.equals(that.IS_PAY));
    equal = equal && (this.OWNER_RATE == null ? that.OWNER_RATE == null : this.OWNER_RATE.equals(that.OWNER_RATE));
    equal = equal && (this.IS_LENDER == null ? that.IS_LENDER == null : this.IS_LENDER.equals(that.IS_LENDER));
    equal = equal && (this.EXPECT_NUM == null ? that.EXPECT_NUM == null : this.EXPECT_NUM.equals(that.EXPECT_NUM));
    equal = equal && (this.BA_TRANSFER == null ? that.BA_TRANSFER == null : this.BA_TRANSFER.equals(that.BA_TRANSFER));
    equal = equal && (this.BA_IS_TRANSFER == null ? that.BA_IS_TRANSFER == null : this.BA_IS_TRANSFER.equals(that.BA_IS_TRANSFER));
    equal = equal && (this.VERSION == null ? that.VERSION == null : this.VERSION.equals(that.VERSION));
    equal = equal && (this.CREATE_TIME == null ? that.CREATE_TIME == null : this.CREATE_TIME.equals(that.CREATE_TIME));
    equal = equal && (this.UPDATE_TIME == null ? that.UPDATE_TIME == null : this.UPDATE_TIME.equals(that.UPDATE_TIME));
    equal = equal && (this.IS_DELETE_FLAG == null ? that.IS_DELETE_FLAG == null : this.IS_DELETE_FLAG.equals(that.IS_DELETE_FLAG));
    equal = equal && (this.DW_CREATE_BY == null ? that.DW_CREATE_BY == null : this.DW_CREATE_BY.equals(that.DW_CREATE_BY));
    equal = equal && (this.DW_CREATE_TIME == null ? that.DW_CREATE_TIME == null : this.DW_CREATE_TIME.equals(that.DW_CREATE_TIME));
    equal = equal && (this.DW_UPDATE_BY == null ? that.DW_UPDATE_BY == null : this.DW_UPDATE_BY.equals(that.DW_UPDATE_BY));
    equal = equal && (this.DW_UPDATE_TIME == null ? that.DW_UPDATE_TIME == null : this.DW_UPDATE_TIME.equals(that.DW_UPDATE_TIME));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.ID = JdbcWritableBridge.readLong(1, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(2, __dbResults);
    this.BO_ID = JdbcWritableBridge.readLong(3, __dbResults);
    this.IS_VIP = JdbcWritableBridge.readBoolean(4, __dbResults);
    this.VA_ID = JdbcWritableBridge.readLong(5, __dbResults);
    this.ORIGINAL_PRINCIPAL = JdbcWritableBridge.readBigDecimal(6, __dbResults);
    this.PRICE_PRINCIPAL = JdbcWritableBridge.readBigDecimal(7, __dbResults);
    this.PRICE_INTEREST = JdbcWritableBridge.readBigDecimal(8, __dbResults);
    this.PRICE = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.PRICE_PUNISH = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.PLAN_TIME = JdbcWritableBridge.readDate(11, __dbResults);
    this.SUCCESS_TIME = JdbcWritableBridge.readTimestamp(12, __dbResults);
    this.IS_PAY = JdbcWritableBridge.readBoolean(13, __dbResults);
    this.OWNER_RATE = JdbcWritableBridge.readBigDecimal(14, __dbResults);
    this.IS_LENDER = JdbcWritableBridge.readBoolean(15, __dbResults);
    this.EXPECT_NUM = JdbcWritableBridge.readInteger(16, __dbResults);
    this.BA_TRANSFER = JdbcWritableBridge.readBigDecimal(17, __dbResults);
    this.BA_IS_TRANSFER = JdbcWritableBridge.readInteger(18, __dbResults);
    this.VERSION = JdbcWritableBridge.readInteger(19, __dbResults);
    this.CREATE_TIME = JdbcWritableBridge.readTimestamp(20, __dbResults);
    this.UPDATE_TIME = JdbcWritableBridge.readTimestamp(21, __dbResults);
    this.IS_DELETE_FLAG = JdbcWritableBridge.readInteger(22, __dbResults);
    this.DW_CREATE_BY = JdbcWritableBridge.readString(23, __dbResults);
    this.DW_CREATE_TIME = JdbcWritableBridge.readTimestamp(24, __dbResults);
    this.DW_UPDATE_BY = JdbcWritableBridge.readString(25, __dbResults);
    this.DW_UPDATE_TIME = JdbcWritableBridge.readTimestamp(26, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.ID = JdbcWritableBridge.readLong(1, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(2, __dbResults);
    this.BO_ID = JdbcWritableBridge.readLong(3, __dbResults);
    this.IS_VIP = JdbcWritableBridge.readBoolean(4, __dbResults);
    this.VA_ID = JdbcWritableBridge.readLong(5, __dbResults);
    this.ORIGINAL_PRINCIPAL = JdbcWritableBridge.readBigDecimal(6, __dbResults);
    this.PRICE_PRINCIPAL = JdbcWritableBridge.readBigDecimal(7, __dbResults);
    this.PRICE_INTEREST = JdbcWritableBridge.readBigDecimal(8, __dbResults);
    this.PRICE = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.PRICE_PUNISH = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.PLAN_TIME = JdbcWritableBridge.readDate(11, __dbResults);
    this.SUCCESS_TIME = JdbcWritableBridge.readTimestamp(12, __dbResults);
    this.IS_PAY = JdbcWritableBridge.readBoolean(13, __dbResults);
    this.OWNER_RATE = JdbcWritableBridge.readBigDecimal(14, __dbResults);
    this.IS_LENDER = JdbcWritableBridge.readBoolean(15, __dbResults);
    this.EXPECT_NUM = JdbcWritableBridge.readInteger(16, __dbResults);
    this.BA_TRANSFER = JdbcWritableBridge.readBigDecimal(17, __dbResults);
    this.BA_IS_TRANSFER = JdbcWritableBridge.readInteger(18, __dbResults);
    this.VERSION = JdbcWritableBridge.readInteger(19, __dbResults);
    this.CREATE_TIME = JdbcWritableBridge.readTimestamp(20, __dbResults);
    this.UPDATE_TIME = JdbcWritableBridge.readTimestamp(21, __dbResults);
    this.IS_DELETE_FLAG = JdbcWritableBridge.readInteger(22, __dbResults);
    this.DW_CREATE_BY = JdbcWritableBridge.readString(23, __dbResults);
    this.DW_CREATE_TIME = JdbcWritableBridge.readTimestamp(24, __dbResults);
    this.DW_UPDATE_BY = JdbcWritableBridge.readString(25, __dbResults);
    this.DW_UPDATE_TIME = JdbcWritableBridge.readTimestamp(26, __dbResults);
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
    JdbcWritableBridge.writeLong(ID, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(USER_ID, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(BO_ID, 3 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeBoolean(IS_VIP, 4 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeLong(VA_ID, 5 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ORIGINAL_PRINCIPAL, 6 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRICE_PRINCIPAL, 7 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRICE_INTEREST, 8 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRICE, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRICE_PUNISH, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeDate(PLAN_TIME, 11 + __off, 91, __dbStmt);
    JdbcWritableBridge.writeTimestamp(SUCCESS_TIME, 12 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeBoolean(IS_PAY, 13 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OWNER_RATE, 14 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBoolean(IS_LENDER, 15 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeInteger(EXPECT_NUM, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(BA_TRANSFER, 17 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(BA_IS_TRANSFER, 18 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(VERSION, 19 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(CREATE_TIME, 20 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(UPDATE_TIME, 21 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(IS_DELETE_FLAG, 22 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(DW_CREATE_BY, 23 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(DW_CREATE_TIME, 24 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(DW_UPDATE_BY, 25 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(DW_UPDATE_TIME, 26 + __off, 93, __dbStmt);
    return 26;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(ID, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(USER_ID, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(BO_ID, 3 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeBoolean(IS_VIP, 4 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeLong(VA_ID, 5 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ORIGINAL_PRINCIPAL, 6 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRICE_PRINCIPAL, 7 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRICE_INTEREST, 8 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRICE, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(PRICE_PUNISH, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeDate(PLAN_TIME, 11 + __off, 91, __dbStmt);
    JdbcWritableBridge.writeTimestamp(SUCCESS_TIME, 12 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeBoolean(IS_PAY, 13 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(OWNER_RATE, 14 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBoolean(IS_LENDER, 15 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeInteger(EXPECT_NUM, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(BA_TRANSFER, 17 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(BA_IS_TRANSFER, 18 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(VERSION, 19 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(CREATE_TIME, 20 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(UPDATE_TIME, 21 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(IS_DELETE_FLAG, 22 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(DW_CREATE_BY, 23 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(DW_CREATE_TIME, 24 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(DW_UPDATE_BY, 25 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(DW_UPDATE_TIME, 26 + __off, 93, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.ID = null;
    } else {
    this.ID = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.USER_ID = null;
    } else {
    this.USER_ID = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.BO_ID = null;
    } else {
    this.BO_ID = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.IS_VIP = null;
    } else {
    this.IS_VIP = Boolean.valueOf(__dataIn.readBoolean());
    }
    if (__dataIn.readBoolean()) { 
        this.VA_ID = null;
    } else {
    this.VA_ID = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.ORIGINAL_PRINCIPAL = null;
    } else {
    this.ORIGINAL_PRINCIPAL = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PRICE_PRINCIPAL = null;
    } else {
    this.PRICE_PRINCIPAL = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PRICE_INTEREST = null;
    } else {
    this.PRICE_INTEREST = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PRICE = null;
    } else {
    this.PRICE = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PRICE_PUNISH = null;
    } else {
    this.PRICE_PUNISH = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PLAN_TIME = null;
    } else {
    this.PLAN_TIME = new Date(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.SUCCESS_TIME = null;
    } else {
    this.SUCCESS_TIME = new Timestamp(__dataIn.readLong());
    this.SUCCESS_TIME.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.IS_PAY = null;
    } else {
    this.IS_PAY = Boolean.valueOf(__dataIn.readBoolean());
    }
    if (__dataIn.readBoolean()) { 
        this.OWNER_RATE = null;
    } else {
    this.OWNER_RATE = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.IS_LENDER = null;
    } else {
    this.IS_LENDER = Boolean.valueOf(__dataIn.readBoolean());
    }
    if (__dataIn.readBoolean()) { 
        this.EXPECT_NUM = null;
    } else {
    this.EXPECT_NUM = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.BA_TRANSFER = null;
    } else {
    this.BA_TRANSFER = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.BA_IS_TRANSFER = null;
    } else {
    this.BA_IS_TRANSFER = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.VERSION = null;
    } else {
    this.VERSION = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.CREATE_TIME = null;
    } else {
    this.CREATE_TIME = new Timestamp(__dataIn.readLong());
    this.CREATE_TIME.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.UPDATE_TIME = null;
    } else {
    this.UPDATE_TIME = new Timestamp(__dataIn.readLong());
    this.UPDATE_TIME.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.IS_DELETE_FLAG = null;
    } else {
    this.IS_DELETE_FLAG = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.DW_CREATE_BY = null;
    } else {
    this.DW_CREATE_BY = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.DW_CREATE_TIME = null;
    } else {
    this.DW_CREATE_TIME = new Timestamp(__dataIn.readLong());
    this.DW_CREATE_TIME.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.DW_UPDATE_BY = null;
    } else {
    this.DW_UPDATE_BY = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.DW_UPDATE_TIME = null;
    } else {
    this.DW_UPDATE_TIME = new Timestamp(__dataIn.readLong());
    this.DW_UPDATE_TIME.setNanos(__dataIn.readInt());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.ID);
    }
    if (null == this.USER_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.USER_ID);
    }
    if (null == this.BO_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.BO_ID);
    }
    if (null == this.IS_VIP) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.IS_VIP);
    }
    if (null == this.VA_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.VA_ID);
    }
    if (null == this.ORIGINAL_PRINCIPAL) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ORIGINAL_PRINCIPAL, __dataOut);
    }
    if (null == this.PRICE_PRINCIPAL) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRICE_PRINCIPAL, __dataOut);
    }
    if (null == this.PRICE_INTEREST) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRICE_INTEREST, __dataOut);
    }
    if (null == this.PRICE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRICE, __dataOut);
    }
    if (null == this.PRICE_PUNISH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRICE_PUNISH, __dataOut);
    }
    if (null == this.PLAN_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.PLAN_TIME.getTime());
    }
    if (null == this.SUCCESS_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.SUCCESS_TIME.getTime());
    __dataOut.writeInt(this.SUCCESS_TIME.getNanos());
    }
    if (null == this.IS_PAY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.IS_PAY);
    }
    if (null == this.OWNER_RATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OWNER_RATE, __dataOut);
    }
    if (null == this.IS_LENDER) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.IS_LENDER);
    }
    if (null == this.EXPECT_NUM) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.EXPECT_NUM);
    }
    if (null == this.BA_TRANSFER) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.BA_TRANSFER, __dataOut);
    }
    if (null == this.BA_IS_TRANSFER) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.BA_IS_TRANSFER);
    }
    if (null == this.VERSION) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.VERSION);
    }
    if (null == this.CREATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.CREATE_TIME.getTime());
    __dataOut.writeInt(this.CREATE_TIME.getNanos());
    }
    if (null == this.UPDATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.UPDATE_TIME.getTime());
    __dataOut.writeInt(this.UPDATE_TIME.getNanos());
    }
    if (null == this.IS_DELETE_FLAG) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.IS_DELETE_FLAG);
    }
    if (null == this.DW_CREATE_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DW_CREATE_BY);
    }
    if (null == this.DW_CREATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.DW_CREATE_TIME.getTime());
    __dataOut.writeInt(this.DW_CREATE_TIME.getNanos());
    }
    if (null == this.DW_UPDATE_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DW_UPDATE_BY);
    }
    if (null == this.DW_UPDATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.DW_UPDATE_TIME.getTime());
    __dataOut.writeInt(this.DW_UPDATE_TIME.getNanos());
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.ID);
    }
    if (null == this.USER_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.USER_ID);
    }
    if (null == this.BO_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.BO_ID);
    }
    if (null == this.IS_VIP) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.IS_VIP);
    }
    if (null == this.VA_ID) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.VA_ID);
    }
    if (null == this.ORIGINAL_PRINCIPAL) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ORIGINAL_PRINCIPAL, __dataOut);
    }
    if (null == this.PRICE_PRINCIPAL) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRICE_PRINCIPAL, __dataOut);
    }
    if (null == this.PRICE_INTEREST) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRICE_INTEREST, __dataOut);
    }
    if (null == this.PRICE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRICE, __dataOut);
    }
    if (null == this.PRICE_PUNISH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.PRICE_PUNISH, __dataOut);
    }
    if (null == this.PLAN_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.PLAN_TIME.getTime());
    }
    if (null == this.SUCCESS_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.SUCCESS_TIME.getTime());
    __dataOut.writeInt(this.SUCCESS_TIME.getNanos());
    }
    if (null == this.IS_PAY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.IS_PAY);
    }
    if (null == this.OWNER_RATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.OWNER_RATE, __dataOut);
    }
    if (null == this.IS_LENDER) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.IS_LENDER);
    }
    if (null == this.EXPECT_NUM) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.EXPECT_NUM);
    }
    if (null == this.BA_TRANSFER) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.BA_TRANSFER, __dataOut);
    }
    if (null == this.BA_IS_TRANSFER) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.BA_IS_TRANSFER);
    }
    if (null == this.VERSION) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.VERSION);
    }
    if (null == this.CREATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.CREATE_TIME.getTime());
    __dataOut.writeInt(this.CREATE_TIME.getNanos());
    }
    if (null == this.UPDATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.UPDATE_TIME.getTime());
    __dataOut.writeInt(this.UPDATE_TIME.getNanos());
    }
    if (null == this.IS_DELETE_FLAG) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.IS_DELETE_FLAG);
    }
    if (null == this.DW_CREATE_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DW_CREATE_BY);
    }
    if (null == this.DW_CREATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.DW_CREATE_TIME.getTime());
    __dataOut.writeInt(this.DW_CREATE_TIME.getNanos());
    }
    if (null == this.DW_UPDATE_BY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DW_UPDATE_BY);
    }
    if (null == this.DW_UPDATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.DW_UPDATE_TIME.getTime());
    __dataOut.writeInt(this.DW_UPDATE_TIME.getNanos());
    }
  }
  private static final DelimiterSet __outputDelimiters = new DelimiterSet((char) 1, (char) 10, (char) 0, (char) 0, false);
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
    __sb.append(FieldFormatter.escapeAndEnclose(ID==null?"null":"" + ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"null":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BO_ID==null?"null":"" + BO_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_VIP==null?"null":"" + IS_VIP, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(VA_ID==null?"null":"" + VA_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ORIGINAL_PRINCIPAL==null?"null":ORIGINAL_PRINCIPAL.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRICE_PRINCIPAL==null?"null":PRICE_PRINCIPAL.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRICE_INTEREST==null?"null":PRICE_INTEREST.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRICE==null?"null":PRICE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRICE_PUNISH==null?"null":PRICE_PUNISH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PLAN_TIME==null?"null":"" + PLAN_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SUCCESS_TIME==null?"null":"" + SUCCESS_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_PAY==null?"null":"" + IS_PAY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OWNER_RATE==null?"null":OWNER_RATE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_LENDER==null?"null":"" + IS_LENDER, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(EXPECT_NUM==null?"null":"" + EXPECT_NUM, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BA_TRANSFER==null?"null":BA_TRANSFER.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BA_IS_TRANSFER==null?"null":"" + BA_IS_TRANSFER, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(VERSION==null?"null":"" + VERSION, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATE_TIME==null?"null":"" + CREATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(UPDATE_TIME==null?"null":"" + UPDATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_DELETE_FLAG==null?"null":"" + IS_DELETE_FLAG, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_CREATE_BY==null?"null":DW_CREATE_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_CREATE_TIME==null?"null":"" + DW_CREATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_UPDATE_BY==null?"null":DW_UPDATE_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_UPDATE_TIME==null?"null":"" + DW_UPDATE_TIME, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(ID==null?"null":"" + ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"null":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BO_ID==null?"null":"" + BO_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_VIP==null?"null":"" + IS_VIP, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(VA_ID==null?"null":"" + VA_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ORIGINAL_PRINCIPAL==null?"null":ORIGINAL_PRINCIPAL.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRICE_PRINCIPAL==null?"null":PRICE_PRINCIPAL.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRICE_INTEREST==null?"null":PRICE_INTEREST.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRICE==null?"null":PRICE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRICE_PUNISH==null?"null":PRICE_PUNISH.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PLAN_TIME==null?"null":"" + PLAN_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SUCCESS_TIME==null?"null":"" + SUCCESS_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_PAY==null?"null":"" + IS_PAY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(OWNER_RATE==null?"null":OWNER_RATE.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_LENDER==null?"null":"" + IS_LENDER, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(EXPECT_NUM==null?"null":"" + EXPECT_NUM, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BA_TRANSFER==null?"null":BA_TRANSFER.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BA_IS_TRANSFER==null?"null":"" + BA_IS_TRANSFER, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(VERSION==null?"null":"" + VERSION, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATE_TIME==null?"null":"" + CREATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(UPDATE_TIME==null?"null":"" + UPDATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(IS_DELETE_FLAG==null?"null":"" + IS_DELETE_FLAG, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_CREATE_BY==null?"null":DW_CREATE_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_CREATE_TIME==null?"null":"" + DW_CREATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_UPDATE_BY==null?"null":DW_UPDATE_BY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_UPDATE_TIME==null?"null":"" + DW_UPDATE_TIME, delimiters));
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
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ID = null; } else {
      this.ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BO_ID = null; } else {
      this.BO_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_VIP = null; } else {
      this.IS_VIP = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.VA_ID = null; } else {
      this.VA_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ORIGINAL_PRINCIPAL = null; } else {
      this.ORIGINAL_PRINCIPAL = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRICE_PRINCIPAL = null; } else {
      this.PRICE_PRINCIPAL = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRICE_INTEREST = null; } else {
      this.PRICE_INTEREST = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRICE = null; } else {
      this.PRICE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRICE_PUNISH = null; } else {
      this.PRICE_PUNISH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PLAN_TIME = null; } else {
      this.PLAN_TIME = java.sql.Date.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.SUCCESS_TIME = null; } else {
      this.SUCCESS_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_PAY = null; } else {
      this.IS_PAY = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OWNER_RATE = null; } else {
      this.OWNER_RATE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_LENDER = null; } else {
      this.IS_LENDER = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.EXPECT_NUM = null; } else {
      this.EXPECT_NUM = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BA_TRANSFER = null; } else {
      this.BA_TRANSFER = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BA_IS_TRANSFER = null; } else {
      this.BA_IS_TRANSFER = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.VERSION = null; } else {
      this.VERSION = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.CREATE_TIME = null; } else {
      this.CREATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.UPDATE_TIME = null; } else {
      this.UPDATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_DELETE_FLAG = null; } else {
      this.IS_DELETE_FLAG = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.DW_CREATE_BY = null; } else {
      this.DW_CREATE_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.DW_CREATE_TIME = null; } else {
      this.DW_CREATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.DW_UPDATE_BY = null; } else {
      this.DW_UPDATE_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.DW_UPDATE_TIME = null; } else {
      this.DW_UPDATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ID = null; } else {
      this.ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BO_ID = null; } else {
      this.BO_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_VIP = null; } else {
      this.IS_VIP = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.VA_ID = null; } else {
      this.VA_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ORIGINAL_PRINCIPAL = null; } else {
      this.ORIGINAL_PRINCIPAL = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRICE_PRINCIPAL = null; } else {
      this.PRICE_PRINCIPAL = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRICE_INTEREST = null; } else {
      this.PRICE_INTEREST = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRICE = null; } else {
      this.PRICE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PRICE_PUNISH = null; } else {
      this.PRICE_PUNISH = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.PLAN_TIME = null; } else {
      this.PLAN_TIME = java.sql.Date.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.SUCCESS_TIME = null; } else {
      this.SUCCESS_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_PAY = null; } else {
      this.IS_PAY = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.OWNER_RATE = null; } else {
      this.OWNER_RATE = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_LENDER = null; } else {
      this.IS_LENDER = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.EXPECT_NUM = null; } else {
      this.EXPECT_NUM = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BA_TRANSFER = null; } else {
      this.BA_TRANSFER = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BA_IS_TRANSFER = null; } else {
      this.BA_IS_TRANSFER = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.VERSION = null; } else {
      this.VERSION = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.CREATE_TIME = null; } else {
      this.CREATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.UPDATE_TIME = null; } else {
      this.UPDATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.IS_DELETE_FLAG = null; } else {
      this.IS_DELETE_FLAG = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.DW_CREATE_BY = null; } else {
      this.DW_CREATE_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.DW_CREATE_TIME = null; } else {
      this.DW_CREATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.DW_UPDATE_BY = null; } else {
      this.DW_UPDATE_BY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.DW_UPDATE_TIME = null; } else {
      this.DW_UPDATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    T_BORROWS_ACCEPT o = (T_BORROWS_ACCEPT) super.clone();
    o.PLAN_TIME = (o.PLAN_TIME != null) ? (java.sql.Date) o.PLAN_TIME.clone() : null;
    o.SUCCESS_TIME = (o.SUCCESS_TIME != null) ? (java.sql.Timestamp) o.SUCCESS_TIME.clone() : null;
    o.CREATE_TIME = (o.CREATE_TIME != null) ? (java.sql.Timestamp) o.CREATE_TIME.clone() : null;
    o.UPDATE_TIME = (o.UPDATE_TIME != null) ? (java.sql.Timestamp) o.UPDATE_TIME.clone() : null;
    o.DW_CREATE_TIME = (o.DW_CREATE_TIME != null) ? (java.sql.Timestamp) o.DW_CREATE_TIME.clone() : null;
    o.DW_UPDATE_TIME = (o.DW_UPDATE_TIME != null) ? (java.sql.Timestamp) o.DW_UPDATE_TIME.clone() : null;
    return o;
  }

  public void clone0(T_BORROWS_ACCEPT o) throws CloneNotSupportedException {
    o.PLAN_TIME = (o.PLAN_TIME != null) ? (java.sql.Date) o.PLAN_TIME.clone() : null;
    o.SUCCESS_TIME = (o.SUCCESS_TIME != null) ? (java.sql.Timestamp) o.SUCCESS_TIME.clone() : null;
    o.CREATE_TIME = (o.CREATE_TIME != null) ? (java.sql.Timestamp) o.CREATE_TIME.clone() : null;
    o.UPDATE_TIME = (o.UPDATE_TIME != null) ? (java.sql.Timestamp) o.UPDATE_TIME.clone() : null;
    o.DW_CREATE_TIME = (o.DW_CREATE_TIME != null) ? (java.sql.Timestamp) o.DW_CREATE_TIME.clone() : null;
    o.DW_UPDATE_TIME = (o.DW_UPDATE_TIME != null) ? (java.sql.Timestamp) o.DW_UPDATE_TIME.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("ID", this.ID);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("BO_ID", this.BO_ID);
    __sqoop$field_map.put("IS_VIP", this.IS_VIP);
    __sqoop$field_map.put("VA_ID", this.VA_ID);
    __sqoop$field_map.put("ORIGINAL_PRINCIPAL", this.ORIGINAL_PRINCIPAL);
    __sqoop$field_map.put("PRICE_PRINCIPAL", this.PRICE_PRINCIPAL);
    __sqoop$field_map.put("PRICE_INTEREST", this.PRICE_INTEREST);
    __sqoop$field_map.put("PRICE", this.PRICE);
    __sqoop$field_map.put("PRICE_PUNISH", this.PRICE_PUNISH);
    __sqoop$field_map.put("PLAN_TIME", this.PLAN_TIME);
    __sqoop$field_map.put("SUCCESS_TIME", this.SUCCESS_TIME);
    __sqoop$field_map.put("IS_PAY", this.IS_PAY);
    __sqoop$field_map.put("OWNER_RATE", this.OWNER_RATE);
    __sqoop$field_map.put("IS_LENDER", this.IS_LENDER);
    __sqoop$field_map.put("EXPECT_NUM", this.EXPECT_NUM);
    __sqoop$field_map.put("BA_TRANSFER", this.BA_TRANSFER);
    __sqoop$field_map.put("BA_IS_TRANSFER", this.BA_IS_TRANSFER);
    __sqoop$field_map.put("VERSION", this.VERSION);
    __sqoop$field_map.put("CREATE_TIME", this.CREATE_TIME);
    __sqoop$field_map.put("UPDATE_TIME", this.UPDATE_TIME);
    __sqoop$field_map.put("IS_DELETE_FLAG", this.IS_DELETE_FLAG);
    __sqoop$field_map.put("DW_CREATE_BY", this.DW_CREATE_BY);
    __sqoop$field_map.put("DW_CREATE_TIME", this.DW_CREATE_TIME);
    __sqoop$field_map.put("DW_UPDATE_BY", this.DW_UPDATE_BY);
    __sqoop$field_map.put("DW_UPDATE_TIME", this.DW_UPDATE_TIME);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("ID", this.ID);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("BO_ID", this.BO_ID);
    __sqoop$field_map.put("IS_VIP", this.IS_VIP);
    __sqoop$field_map.put("VA_ID", this.VA_ID);
    __sqoop$field_map.put("ORIGINAL_PRINCIPAL", this.ORIGINAL_PRINCIPAL);
    __sqoop$field_map.put("PRICE_PRINCIPAL", this.PRICE_PRINCIPAL);
    __sqoop$field_map.put("PRICE_INTEREST", this.PRICE_INTEREST);
    __sqoop$field_map.put("PRICE", this.PRICE);
    __sqoop$field_map.put("PRICE_PUNISH", this.PRICE_PUNISH);
    __sqoop$field_map.put("PLAN_TIME", this.PLAN_TIME);
    __sqoop$field_map.put("SUCCESS_TIME", this.SUCCESS_TIME);
    __sqoop$field_map.put("IS_PAY", this.IS_PAY);
    __sqoop$field_map.put("OWNER_RATE", this.OWNER_RATE);
    __sqoop$field_map.put("IS_LENDER", this.IS_LENDER);
    __sqoop$field_map.put("EXPECT_NUM", this.EXPECT_NUM);
    __sqoop$field_map.put("BA_TRANSFER", this.BA_TRANSFER);
    __sqoop$field_map.put("BA_IS_TRANSFER", this.BA_IS_TRANSFER);
    __sqoop$field_map.put("VERSION", this.VERSION);
    __sqoop$field_map.put("CREATE_TIME", this.CREATE_TIME);
    __sqoop$field_map.put("UPDATE_TIME", this.UPDATE_TIME);
    __sqoop$field_map.put("IS_DELETE_FLAG", this.IS_DELETE_FLAG);
    __sqoop$field_map.put("DW_CREATE_BY", this.DW_CREATE_BY);
    __sqoop$field_map.put("DW_CREATE_TIME", this.DW_CREATE_TIME);
    __sqoop$field_map.put("DW_UPDATE_BY", this.DW_UPDATE_BY);
    __sqoop$field_map.put("DW_UPDATE_TIME", this.DW_UPDATE_TIME);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("ID".equals(__fieldName)) {
      this.ID = (Long) __fieldVal;
    }
    else    if ("USER_ID".equals(__fieldName)) {
      this.USER_ID = (Long) __fieldVal;
    }
    else    if ("BO_ID".equals(__fieldName)) {
      this.BO_ID = (Long) __fieldVal;
    }
    else    if ("IS_VIP".equals(__fieldName)) {
      this.IS_VIP = (Boolean) __fieldVal;
    }
    else    if ("VA_ID".equals(__fieldName)) {
      this.VA_ID = (Long) __fieldVal;
    }
    else    if ("ORIGINAL_PRINCIPAL".equals(__fieldName)) {
      this.ORIGINAL_PRINCIPAL = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("PRICE_PRINCIPAL".equals(__fieldName)) {
      this.PRICE_PRINCIPAL = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("PRICE_INTEREST".equals(__fieldName)) {
      this.PRICE_INTEREST = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("PRICE".equals(__fieldName)) {
      this.PRICE = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("PRICE_PUNISH".equals(__fieldName)) {
      this.PRICE_PUNISH = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("PLAN_TIME".equals(__fieldName)) {
      this.PLAN_TIME = (java.sql.Date) __fieldVal;
    }
    else    if ("SUCCESS_TIME".equals(__fieldName)) {
      this.SUCCESS_TIME = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("IS_PAY".equals(__fieldName)) {
      this.IS_PAY = (Boolean) __fieldVal;
    }
    else    if ("OWNER_RATE".equals(__fieldName)) {
      this.OWNER_RATE = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("IS_LENDER".equals(__fieldName)) {
      this.IS_LENDER = (Boolean) __fieldVal;
    }
    else    if ("EXPECT_NUM".equals(__fieldName)) {
      this.EXPECT_NUM = (Integer) __fieldVal;
    }
    else    if ("BA_TRANSFER".equals(__fieldName)) {
      this.BA_TRANSFER = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("BA_IS_TRANSFER".equals(__fieldName)) {
      this.BA_IS_TRANSFER = (Integer) __fieldVal;
    }
    else    if ("VERSION".equals(__fieldName)) {
      this.VERSION = (Integer) __fieldVal;
    }
    else    if ("CREATE_TIME".equals(__fieldName)) {
      this.CREATE_TIME = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("UPDATE_TIME".equals(__fieldName)) {
      this.UPDATE_TIME = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("IS_DELETE_FLAG".equals(__fieldName)) {
      this.IS_DELETE_FLAG = (Integer) __fieldVal;
    }
    else    if ("DW_CREATE_BY".equals(__fieldName)) {
      this.DW_CREATE_BY = (String) __fieldVal;
    }
    else    if ("DW_CREATE_TIME".equals(__fieldName)) {
      this.DW_CREATE_TIME = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("DW_UPDATE_BY".equals(__fieldName)) {
      this.DW_UPDATE_BY = (String) __fieldVal;
    }
    else    if ("DW_UPDATE_TIME".equals(__fieldName)) {
      this.DW_UPDATE_TIME = (java.sql.Timestamp) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("ID".equals(__fieldName)) {
      this.ID = (Long) __fieldVal;
      return true;
    }
    else    if ("USER_ID".equals(__fieldName)) {
      this.USER_ID = (Long) __fieldVal;
      return true;
    }
    else    if ("BO_ID".equals(__fieldName)) {
      this.BO_ID = (Long) __fieldVal;
      return true;
    }
    else    if ("IS_VIP".equals(__fieldName)) {
      this.IS_VIP = (Boolean) __fieldVal;
      return true;
    }
    else    if ("VA_ID".equals(__fieldName)) {
      this.VA_ID = (Long) __fieldVal;
      return true;
    }
    else    if ("ORIGINAL_PRINCIPAL".equals(__fieldName)) {
      this.ORIGINAL_PRINCIPAL = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("PRICE_PRINCIPAL".equals(__fieldName)) {
      this.PRICE_PRINCIPAL = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("PRICE_INTEREST".equals(__fieldName)) {
      this.PRICE_INTEREST = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("PRICE".equals(__fieldName)) {
      this.PRICE = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("PRICE_PUNISH".equals(__fieldName)) {
      this.PRICE_PUNISH = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("PLAN_TIME".equals(__fieldName)) {
      this.PLAN_TIME = (java.sql.Date) __fieldVal;
      return true;
    }
    else    if ("SUCCESS_TIME".equals(__fieldName)) {
      this.SUCCESS_TIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("IS_PAY".equals(__fieldName)) {
      this.IS_PAY = (Boolean) __fieldVal;
      return true;
    }
    else    if ("OWNER_RATE".equals(__fieldName)) {
      this.OWNER_RATE = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("IS_LENDER".equals(__fieldName)) {
      this.IS_LENDER = (Boolean) __fieldVal;
      return true;
    }
    else    if ("EXPECT_NUM".equals(__fieldName)) {
      this.EXPECT_NUM = (Integer) __fieldVal;
      return true;
    }
    else    if ("BA_TRANSFER".equals(__fieldName)) {
      this.BA_TRANSFER = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("BA_IS_TRANSFER".equals(__fieldName)) {
      this.BA_IS_TRANSFER = (Integer) __fieldVal;
      return true;
    }
    else    if ("VERSION".equals(__fieldName)) {
      this.VERSION = (Integer) __fieldVal;
      return true;
    }
    else    if ("CREATE_TIME".equals(__fieldName)) {
      this.CREATE_TIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("UPDATE_TIME".equals(__fieldName)) {
      this.UPDATE_TIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("IS_DELETE_FLAG".equals(__fieldName)) {
      this.IS_DELETE_FLAG = (Integer) __fieldVal;
      return true;
    }
    else    if ("DW_CREATE_BY".equals(__fieldName)) {
      this.DW_CREATE_BY = (String) __fieldVal;
      return true;
    }
    else    if ("DW_CREATE_TIME".equals(__fieldName)) {
      this.DW_CREATE_TIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("DW_UPDATE_BY".equals(__fieldName)) {
      this.DW_UPDATE_BY = (String) __fieldVal;
      return true;
    }
    else    if ("DW_UPDATE_TIME".equals(__fieldName)) {
      this.DW_UPDATE_TIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
