// ORM class for table 'borrows_accept'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Tue Jul 18 17:16:20 CST 2017
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

public class borrows_accept extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private Long id;
  public Long get_id() {
    return id;
  }
  public void set_id(Long id) {
    this.id = id;
  }
  public borrows_accept with_id(Long id) {
    this.id = id;
    return this;
  }
  private Long user_id;
  public Long get_user_id() {
    return user_id;
  }
  public void set_user_id(Long user_id) {
    this.user_id = user_id;
  }
  public borrows_accept with_user_id(Long user_id) {
    this.user_id = user_id;
    return this;
  }
  private Long bo_id;
  public Long get_bo_id() {
    return bo_id;
  }
  public void set_bo_id(Long bo_id) {
    this.bo_id = bo_id;
  }
  public borrows_accept with_bo_id(Long bo_id) {
    this.bo_id = bo_id;
    return this;
  }
  private Integer is_vip;
  public Integer get_is_vip() {
    return is_vip;
  }
  public void set_is_vip(Integer is_vip) {
    this.is_vip = is_vip;
  }
  public borrows_accept with_is_vip(Integer is_vip) {
    this.is_vip = is_vip;
    return this;
  }
  private Long va_id;
  public Long get_va_id() {
    return va_id;
  }
  public void set_va_id(Long va_id) {
    this.va_id = va_id;
  }
  public borrows_accept with_va_id(Long va_id) {
    this.va_id = va_id;
    return this;
  }
  private java.math.BigDecimal original_principal;
  public java.math.BigDecimal get_original_principal() {
    return original_principal;
  }
  public void set_original_principal(java.math.BigDecimal original_principal) {
    this.original_principal = original_principal;
  }
  public borrows_accept with_original_principal(java.math.BigDecimal original_principal) {
    this.original_principal = original_principal;
    return this;
  }
  private java.math.BigDecimal price_principal;
  public java.math.BigDecimal get_price_principal() {
    return price_principal;
  }
  public void set_price_principal(java.math.BigDecimal price_principal) {
    this.price_principal = price_principal;
  }
  public borrows_accept with_price_principal(java.math.BigDecimal price_principal) {
    this.price_principal = price_principal;
    return this;
  }
  private java.math.BigDecimal price_interest;
  public java.math.BigDecimal get_price_interest() {
    return price_interest;
  }
  public void set_price_interest(java.math.BigDecimal price_interest) {
    this.price_interest = price_interest;
  }
  public borrows_accept with_price_interest(java.math.BigDecimal price_interest) {
    this.price_interest = price_interest;
    return this;
  }
  private java.math.BigDecimal price;
  public java.math.BigDecimal get_price() {
    return price;
  }
  public void set_price(java.math.BigDecimal price) {
    this.price = price;
  }
  public borrows_accept with_price(java.math.BigDecimal price) {
    this.price = price;
    return this;
  }
  private java.math.BigDecimal price_punish;
  public java.math.BigDecimal get_price_punish() {
    return price_punish;
  }
  public void set_price_punish(java.math.BigDecimal price_punish) {
    this.price_punish = price_punish;
  }
  public borrows_accept with_price_punish(java.math.BigDecimal price_punish) {
    this.price_punish = price_punish;
    return this;
  }
  private java.sql.Date plan_time;
  public java.sql.Date get_plan_time() {
    return plan_time;
  }
  public void set_plan_time(java.sql.Date plan_time) {
    this.plan_time = plan_time;
  }
  public borrows_accept with_plan_time(java.sql.Date plan_time) {
    this.plan_time = plan_time;
    return this;
  }
  private java.sql.Timestamp success_time;
  public java.sql.Timestamp get_success_time() {
    return success_time;
  }
  public void set_success_time(java.sql.Timestamp success_time) {
    this.success_time = success_time;
  }
  public borrows_accept with_success_time(java.sql.Timestamp success_time) {
    this.success_time = success_time;
    return this;
  }
  private Integer is_pay;
  public Integer get_is_pay() {
    return is_pay;
  }
  public void set_is_pay(Integer is_pay) {
    this.is_pay = is_pay;
  }
  public borrows_accept with_is_pay(Integer is_pay) {
    this.is_pay = is_pay;
    return this;
  }
  private java.math.BigDecimal owner_rate;
  public java.math.BigDecimal get_owner_rate() {
    return owner_rate;
  }
  public void set_owner_rate(java.math.BigDecimal owner_rate) {
    this.owner_rate = owner_rate;
  }
  public borrows_accept with_owner_rate(java.math.BigDecimal owner_rate) {
    this.owner_rate = owner_rate;
    return this;
  }
  private Integer is_lender;
  public Integer get_is_lender() {
    return is_lender;
  }
  public void set_is_lender(Integer is_lender) {
    this.is_lender = is_lender;
  }
  public borrows_accept with_is_lender(Integer is_lender) {
    this.is_lender = is_lender;
    return this;
  }
  private Integer expect_num;
  public Integer get_expect_num() {
    return expect_num;
  }
  public void set_expect_num(Integer expect_num) {
    this.expect_num = expect_num;
  }
  public borrows_accept with_expect_num(Integer expect_num) {
    this.expect_num = expect_num;
    return this;
  }
  private java.math.BigDecimal ba_transfer;
  public java.math.BigDecimal get_ba_transfer() {
    return ba_transfer;
  }
  public void set_ba_transfer(java.math.BigDecimal ba_transfer) {
    this.ba_transfer = ba_transfer;
  }
  public borrows_accept with_ba_transfer(java.math.BigDecimal ba_transfer) {
    this.ba_transfer = ba_transfer;
    return this;
  }
  private Integer ba_is_transfer;
  public Integer get_ba_is_transfer() {
    return ba_is_transfer;
  }
  public void set_ba_is_transfer(Integer ba_is_transfer) {
    this.ba_is_transfer = ba_is_transfer;
  }
  public borrows_accept with_ba_is_transfer(Integer ba_is_transfer) {
    this.ba_is_transfer = ba_is_transfer;
    return this;
  }
  private String seri_no;
  public String get_seri_no() {
    return seri_no;
  }
  public void set_seri_no(String seri_no) {
    this.seri_no = seri_no;
  }
  public borrows_accept with_seri_no(String seri_no) {
    this.seri_no = seri_no;
    return this;
  }
  private Integer version;
  public Integer get_version() {
    return version;
  }
  public void set_version(Integer version) {
    this.version = version;
  }
  public borrows_accept with_version(Integer version) {
    this.version = version;
    return this;
  }
  private java.sql.Timestamp create_time;
  public java.sql.Timestamp get_create_time() {
    return create_time;
  }
  public void set_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
  }
  public borrows_accept with_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
    return this;
  }
  private java.sql.Timestamp update_time;
  public java.sql.Timestamp get_update_time() {
    return update_time;
  }
  public void set_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
  }
  public borrows_accept with_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof borrows_accept)) {
      return false;
    }
    borrows_accept that = (borrows_accept) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.bo_id == null ? that.bo_id == null : this.bo_id.equals(that.bo_id));
    equal = equal && (this.is_vip == null ? that.is_vip == null : this.is_vip.equals(that.is_vip));
    equal = equal && (this.va_id == null ? that.va_id == null : this.va_id.equals(that.va_id));
    equal = equal && (this.original_principal == null ? that.original_principal == null : this.original_principal.equals(that.original_principal));
    equal = equal && (this.price_principal == null ? that.price_principal == null : this.price_principal.equals(that.price_principal));
    equal = equal && (this.price_interest == null ? that.price_interest == null : this.price_interest.equals(that.price_interest));
    equal = equal && (this.price == null ? that.price == null : this.price.equals(that.price));
    equal = equal && (this.price_punish == null ? that.price_punish == null : this.price_punish.equals(that.price_punish));
    equal = equal && (this.plan_time == null ? that.plan_time == null : this.plan_time.equals(that.plan_time));
    equal = equal && (this.success_time == null ? that.success_time == null : this.success_time.equals(that.success_time));
    equal = equal && (this.is_pay == null ? that.is_pay == null : this.is_pay.equals(that.is_pay));
    equal = equal && (this.owner_rate == null ? that.owner_rate == null : this.owner_rate.equals(that.owner_rate));
    equal = equal && (this.is_lender == null ? that.is_lender == null : this.is_lender.equals(that.is_lender));
    equal = equal && (this.expect_num == null ? that.expect_num == null : this.expect_num.equals(that.expect_num));
    equal = equal && (this.ba_transfer == null ? that.ba_transfer == null : this.ba_transfer.equals(that.ba_transfer));
    equal = equal && (this.ba_is_transfer == null ? that.ba_is_transfer == null : this.ba_is_transfer.equals(that.ba_is_transfer));
    equal = equal && (this.seri_no == null ? that.seri_no == null : this.seri_no.equals(that.seri_no));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof borrows_accept)) {
      return false;
    }
    borrows_accept that = (borrows_accept) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.bo_id == null ? that.bo_id == null : this.bo_id.equals(that.bo_id));
    equal = equal && (this.is_vip == null ? that.is_vip == null : this.is_vip.equals(that.is_vip));
    equal = equal && (this.va_id == null ? that.va_id == null : this.va_id.equals(that.va_id));
    equal = equal && (this.original_principal == null ? that.original_principal == null : this.original_principal.equals(that.original_principal));
    equal = equal && (this.price_principal == null ? that.price_principal == null : this.price_principal.equals(that.price_principal));
    equal = equal && (this.price_interest == null ? that.price_interest == null : this.price_interest.equals(that.price_interest));
    equal = equal && (this.price == null ? that.price == null : this.price.equals(that.price));
    equal = equal && (this.price_punish == null ? that.price_punish == null : this.price_punish.equals(that.price_punish));
    equal = equal && (this.plan_time == null ? that.plan_time == null : this.plan_time.equals(that.plan_time));
    equal = equal && (this.success_time == null ? that.success_time == null : this.success_time.equals(that.success_time));
    equal = equal && (this.is_pay == null ? that.is_pay == null : this.is_pay.equals(that.is_pay));
    equal = equal && (this.owner_rate == null ? that.owner_rate == null : this.owner_rate.equals(that.owner_rate));
    equal = equal && (this.is_lender == null ? that.is_lender == null : this.is_lender.equals(that.is_lender));
    equal = equal && (this.expect_num == null ? that.expect_num == null : this.expect_num.equals(that.expect_num));
    equal = equal && (this.ba_transfer == null ? that.ba_transfer == null : this.ba_transfer.equals(that.ba_transfer));
    equal = equal && (this.ba_is_transfer == null ? that.ba_is_transfer == null : this.ba_is_transfer.equals(that.ba_is_transfer));
    equal = equal && (this.seri_no == null ? that.seri_no == null : this.seri_no.equals(that.seri_no));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.bo_id = JdbcWritableBridge.readLong(3, __dbResults);
    this.is_vip = JdbcWritableBridge.readInteger(4, __dbResults);
    this.va_id = JdbcWritableBridge.readLong(5, __dbResults);
    this.original_principal = JdbcWritableBridge.readBigDecimal(6, __dbResults);
    this.price_principal = JdbcWritableBridge.readBigDecimal(7, __dbResults);
    this.price_interest = JdbcWritableBridge.readBigDecimal(8, __dbResults);
    this.price = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.price_punish = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.plan_time = JdbcWritableBridge.readDate(11, __dbResults);
    this.success_time = JdbcWritableBridge.readTimestamp(12, __dbResults);
    this.is_pay = JdbcWritableBridge.readInteger(13, __dbResults);
    this.owner_rate = JdbcWritableBridge.readBigDecimal(14, __dbResults);
    this.is_lender = JdbcWritableBridge.readInteger(15, __dbResults);
    this.expect_num = JdbcWritableBridge.readInteger(16, __dbResults);
    this.ba_transfer = JdbcWritableBridge.readBigDecimal(17, __dbResults);
    this.ba_is_transfer = JdbcWritableBridge.readInteger(18, __dbResults);
    this.seri_no = JdbcWritableBridge.readString(19, __dbResults);
    this.version = JdbcWritableBridge.readInteger(20, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(21, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(22, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.bo_id = JdbcWritableBridge.readLong(3, __dbResults);
    this.is_vip = JdbcWritableBridge.readInteger(4, __dbResults);
    this.va_id = JdbcWritableBridge.readLong(5, __dbResults);
    this.original_principal = JdbcWritableBridge.readBigDecimal(6, __dbResults);
    this.price_principal = JdbcWritableBridge.readBigDecimal(7, __dbResults);
    this.price_interest = JdbcWritableBridge.readBigDecimal(8, __dbResults);
    this.price = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.price_punish = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.plan_time = JdbcWritableBridge.readDate(11, __dbResults);
    this.success_time = JdbcWritableBridge.readTimestamp(12, __dbResults);
    this.is_pay = JdbcWritableBridge.readInteger(13, __dbResults);
    this.owner_rate = JdbcWritableBridge.readBigDecimal(14, __dbResults);
    this.is_lender = JdbcWritableBridge.readInteger(15, __dbResults);
    this.expect_num = JdbcWritableBridge.readInteger(16, __dbResults);
    this.ba_transfer = JdbcWritableBridge.readBigDecimal(17, __dbResults);
    this.ba_is_transfer = JdbcWritableBridge.readInteger(18, __dbResults);
    this.seri_no = JdbcWritableBridge.readString(19, __dbResults);
    this.version = JdbcWritableBridge.readInteger(20, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(21, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(22, __dbResults);
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
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(user_id, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(bo_id, 3 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(is_vip, 4 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeLong(va_id, 5 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(original_principal, 6 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_principal, 7 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_interest, 8 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_punish, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeDate(plan_time, 11 + __off, 91, __dbStmt);
    JdbcWritableBridge.writeTimestamp(success_time, 12 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(is_pay, 13 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(owner_rate, 14 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(is_lender, 15 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeInteger(expect_num, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ba_transfer, 17 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(ba_is_transfer, 18 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(seri_no, 19 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 20 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 21 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 22 + __off, 93, __dbStmt);
    return 22;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(user_id, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(bo_id, 3 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(is_vip, 4 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeLong(va_id, 5 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(original_principal, 6 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_principal, 7 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_interest, 8 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_punish, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeDate(plan_time, 11 + __off, 91, __dbStmt);
    JdbcWritableBridge.writeTimestamp(success_time, 12 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(is_pay, 13 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(owner_rate, 14 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(is_lender, 15 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeInteger(expect_num, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(ba_transfer, 17 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(ba_is_transfer, 18 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(seri_no, 19 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 20 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 21 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 22 + __off, 93, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.id = null;
    } else {
    this.id = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.user_id = null;
    } else {
    this.user_id = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.bo_id = null;
    } else {
    this.bo_id = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.is_vip = null;
    } else {
    this.is_vip = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.va_id = null;
    } else {
    this.va_id = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.original_principal = null;
    } else {
    this.original_principal = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price_principal = null;
    } else {
    this.price_principal = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price_interest = null;
    } else {
    this.price_interest = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price = null;
    } else {
    this.price = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price_punish = null;
    } else {
    this.price_punish = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.plan_time = null;
    } else {
    this.plan_time = new Date(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.success_time = null;
    } else {
    this.success_time = new Timestamp(__dataIn.readLong());
    this.success_time.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.is_pay = null;
    } else {
    this.is_pay = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.owner_rate = null;
    } else {
    this.owner_rate = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.is_lender = null;
    } else {
    this.is_lender = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.expect_num = null;
    } else {
    this.expect_num = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.ba_transfer = null;
    } else {
    this.ba_transfer = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ba_is_transfer = null;
    } else {
    this.ba_is_transfer = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.seri_no = null;
    } else {
    this.seri_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.version = null;
    } else {
    this.version = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.create_time = null;
    } else {
    this.create_time = new Timestamp(__dataIn.readLong());
    this.create_time.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.update_time = null;
    } else {
    this.update_time = new Timestamp(__dataIn.readLong());
    this.update_time.setNanos(__dataIn.readInt());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.id);
    }
    if (null == this.user_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.user_id);
    }
    if (null == this.bo_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.bo_id);
    }
    if (null == this.is_vip) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_vip);
    }
    if (null == this.va_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.va_id);
    }
    if (null == this.original_principal) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.original_principal, __dataOut);
    }
    if (null == this.price_principal) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_principal, __dataOut);
    }
    if (null == this.price_interest) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_interest, __dataOut);
    }
    if (null == this.price) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price, __dataOut);
    }
    if (null == this.price_punish) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_punish, __dataOut);
    }
    if (null == this.plan_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.plan_time.getTime());
    }
    if (null == this.success_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.success_time.getTime());
    __dataOut.writeInt(this.success_time.getNanos());
    }
    if (null == this.is_pay) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_pay);
    }
    if (null == this.owner_rate) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.owner_rate, __dataOut);
    }
    if (null == this.is_lender) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_lender);
    }
    if (null == this.expect_num) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.expect_num);
    }
    if (null == this.ba_transfer) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ba_transfer, __dataOut);
    }
    if (null == this.ba_is_transfer) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ba_is_transfer);
    }
    if (null == this.seri_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, seri_no);
    }
    if (null == this.version) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.version);
    }
    if (null == this.create_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.create_time.getTime());
    __dataOut.writeInt(this.create_time.getNanos());
    }
    if (null == this.update_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.update_time.getTime());
    __dataOut.writeInt(this.update_time.getNanos());
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.id);
    }
    if (null == this.user_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.user_id);
    }
    if (null == this.bo_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.bo_id);
    }
    if (null == this.is_vip) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_vip);
    }
    if (null == this.va_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.va_id);
    }
    if (null == this.original_principal) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.original_principal, __dataOut);
    }
    if (null == this.price_principal) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_principal, __dataOut);
    }
    if (null == this.price_interest) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_interest, __dataOut);
    }
    if (null == this.price) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price, __dataOut);
    }
    if (null == this.price_punish) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_punish, __dataOut);
    }
    if (null == this.plan_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.plan_time.getTime());
    }
    if (null == this.success_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.success_time.getTime());
    __dataOut.writeInt(this.success_time.getNanos());
    }
    if (null == this.is_pay) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_pay);
    }
    if (null == this.owner_rate) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.owner_rate, __dataOut);
    }
    if (null == this.is_lender) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_lender);
    }
    if (null == this.expect_num) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.expect_num);
    }
    if (null == this.ba_transfer) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.ba_transfer, __dataOut);
    }
    if (null == this.ba_is_transfer) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ba_is_transfer);
    }
    if (null == this.seri_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, seri_no);
    }
    if (null == this.version) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.version);
    }
    if (null == this.create_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.create_time.getTime());
    __dataOut.writeInt(this.create_time.getNanos());
    }
    if (null == this.update_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.update_time.getTime());
    __dataOut.writeInt(this.update_time.getNanos());
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
    __sb.append(FieldFormatter.escapeAndEnclose(id==null?"\\N":"" + id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(user_id==null?"\\N":"" + user_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bo_id==null?"\\N":"" + bo_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_vip==null?"\\N":"" + is_vip, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(va_id==null?"\\N":"" + va_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(original_principal==null?"\\N":original_principal.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_principal==null?"\\N":price_principal.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_interest==null?"\\N":price_interest.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price==null?"\\N":price.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_punish==null?"\\N":price_punish.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(plan_time==null?"\\N":"" + plan_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(success_time==null?"\\N":"" + success_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_pay==null?"\\N":"" + is_pay, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(owner_rate==null?"\\N":owner_rate.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_lender==null?"\\N":"" + is_lender, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(expect_num==null?"\\N":"" + expect_num, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ba_transfer==null?"\\N":ba_transfer.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ba_is_transfer==null?"\\N":"" + ba_is_transfer, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(seri_no==null?"\\N":seri_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"\\N":"" + version, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"\\N":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"\\N":"" + update_time, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(id==null?"\\N":"" + id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(user_id==null?"\\N":"" + user_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bo_id==null?"\\N":"" + bo_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_vip==null?"\\N":"" + is_vip, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(va_id==null?"\\N":"" + va_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(original_principal==null?"\\N":original_principal.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_principal==null?"\\N":price_principal.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_interest==null?"\\N":price_interest.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price==null?"\\N":price.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_punish==null?"\\N":price_punish.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(plan_time==null?"\\N":"" + plan_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(success_time==null?"\\N":"" + success_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_pay==null?"\\N":"" + is_pay, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(owner_rate==null?"\\N":owner_rate.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_lender==null?"\\N":"" + is_lender, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(expect_num==null?"\\N":"" + expect_num, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ba_transfer==null?"\\N":ba_transfer.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ba_is_transfer==null?"\\N":"" + ba_is_transfer, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(seri_no==null?"\\N":seri_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"\\N":"" + version, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"\\N":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"\\N":"" + update_time, delimiters));
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
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.id = null; } else {
      this.id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.user_id = null; } else {
      this.user_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.bo_id = null; } else {
      this.bo_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_vip = null; } else {
      this.is_vip = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.va_id = null; } else {
      this.va_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.original_principal = null; } else {
      this.original_principal = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_principal = null; } else {
      this.price_principal = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_interest = null; } else {
      this.price_interest = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price = null; } else {
      this.price = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_punish = null; } else {
      this.price_punish = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.plan_time = null; } else {
      this.plan_time = java.sql.Date.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.success_time = null; } else {
      this.success_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_pay = null; } else {
      this.is_pay = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.owner_rate = null; } else {
      this.owner_rate = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_lender = null; } else {
      this.is_lender = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.expect_num = null; } else {
      this.expect_num = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ba_transfer = null; } else {
      this.ba_transfer = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ba_is_transfer = null; } else {
      this.ba_is_transfer = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.seri_no = null; } else {
      this.seri_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.version = null; } else {
      this.version = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.update_time = null; } else {
      this.update_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.id = null; } else {
      this.id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.user_id = null; } else {
      this.user_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.bo_id = null; } else {
      this.bo_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_vip = null; } else {
      this.is_vip = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.va_id = null; } else {
      this.va_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.original_principal = null; } else {
      this.original_principal = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_principal = null; } else {
      this.price_principal = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_interest = null; } else {
      this.price_interest = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price = null; } else {
      this.price = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_punish = null; } else {
      this.price_punish = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.plan_time = null; } else {
      this.plan_time = java.sql.Date.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.success_time = null; } else {
      this.success_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_pay = null; } else {
      this.is_pay = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.owner_rate = null; } else {
      this.owner_rate = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_lender = null; } else {
      this.is_lender = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.expect_num = null; } else {
      this.expect_num = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ba_transfer = null; } else {
      this.ba_transfer = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ba_is_transfer = null; } else {
      this.ba_is_transfer = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.seri_no = null; } else {
      this.seri_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.version = null; } else {
      this.version = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.update_time = null; } else {
      this.update_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    borrows_accept o = (borrows_accept) super.clone();
    o.plan_time = (o.plan_time != null) ? (java.sql.Date) o.plan_time.clone() : null;
    o.success_time = (o.success_time != null) ? (java.sql.Timestamp) o.success_time.clone() : null;
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    return o;
  }

  public void clone0(borrows_accept o) throws CloneNotSupportedException {
    o.plan_time = (o.plan_time != null) ? (java.sql.Date) o.plan_time.clone() : null;
    o.success_time = (o.success_time != null) ? (java.sql.Timestamp) o.success_time.clone() : null;
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("bo_id", this.bo_id);
    __sqoop$field_map.put("is_vip", this.is_vip);
    __sqoop$field_map.put("va_id", this.va_id);
    __sqoop$field_map.put("original_principal", this.original_principal);
    __sqoop$field_map.put("price_principal", this.price_principal);
    __sqoop$field_map.put("price_interest", this.price_interest);
    __sqoop$field_map.put("price", this.price);
    __sqoop$field_map.put("price_punish", this.price_punish);
    __sqoop$field_map.put("plan_time", this.plan_time);
    __sqoop$field_map.put("success_time", this.success_time);
    __sqoop$field_map.put("is_pay", this.is_pay);
    __sqoop$field_map.put("owner_rate", this.owner_rate);
    __sqoop$field_map.put("is_lender", this.is_lender);
    __sqoop$field_map.put("expect_num", this.expect_num);
    __sqoop$field_map.put("ba_transfer", this.ba_transfer);
    __sqoop$field_map.put("ba_is_transfer", this.ba_is_transfer);
    __sqoop$field_map.put("seri_no", this.seri_no);
    __sqoop$field_map.put("version", this.version);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("bo_id", this.bo_id);
    __sqoop$field_map.put("is_vip", this.is_vip);
    __sqoop$field_map.put("va_id", this.va_id);
    __sqoop$field_map.put("original_principal", this.original_principal);
    __sqoop$field_map.put("price_principal", this.price_principal);
    __sqoop$field_map.put("price_interest", this.price_interest);
    __sqoop$field_map.put("price", this.price);
    __sqoop$field_map.put("price_punish", this.price_punish);
    __sqoop$field_map.put("plan_time", this.plan_time);
    __sqoop$field_map.put("success_time", this.success_time);
    __sqoop$field_map.put("is_pay", this.is_pay);
    __sqoop$field_map.put("owner_rate", this.owner_rate);
    __sqoop$field_map.put("is_lender", this.is_lender);
    __sqoop$field_map.put("expect_num", this.expect_num);
    __sqoop$field_map.put("ba_transfer", this.ba_transfer);
    __sqoop$field_map.put("ba_is_transfer", this.ba_is_transfer);
    __sqoop$field_map.put("seri_no", this.seri_no);
    __sqoop$field_map.put("version", this.version);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("id".equals(__fieldName)) {
      this.id = (Long) __fieldVal;
    }
    else    if ("user_id".equals(__fieldName)) {
      this.user_id = (Long) __fieldVal;
    }
    else    if ("bo_id".equals(__fieldName)) {
      this.bo_id = (Long) __fieldVal;
    }
    else    if ("is_vip".equals(__fieldName)) {
      this.is_vip = (Integer) __fieldVal;
    }
    else    if ("va_id".equals(__fieldName)) {
      this.va_id = (Long) __fieldVal;
    }
    else    if ("original_principal".equals(__fieldName)) {
      this.original_principal = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price_principal".equals(__fieldName)) {
      this.price_principal = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price_interest".equals(__fieldName)) {
      this.price_interest = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price".equals(__fieldName)) {
      this.price = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price_punish".equals(__fieldName)) {
      this.price_punish = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("plan_time".equals(__fieldName)) {
      this.plan_time = (java.sql.Date) __fieldVal;
    }
    else    if ("success_time".equals(__fieldName)) {
      this.success_time = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("is_pay".equals(__fieldName)) {
      this.is_pay = (Integer) __fieldVal;
    }
    else    if ("owner_rate".equals(__fieldName)) {
      this.owner_rate = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("is_lender".equals(__fieldName)) {
      this.is_lender = (Integer) __fieldVal;
    }
    else    if ("expect_num".equals(__fieldName)) {
      this.expect_num = (Integer) __fieldVal;
    }
    else    if ("ba_transfer".equals(__fieldName)) {
      this.ba_transfer = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("ba_is_transfer".equals(__fieldName)) {
      this.ba_is_transfer = (Integer) __fieldVal;
    }
    else    if ("seri_no".equals(__fieldName)) {
      this.seri_no = (String) __fieldVal;
    }
    else    if ("version".equals(__fieldName)) {
      this.version = (Integer) __fieldVal;
    }
    else    if ("create_time".equals(__fieldName)) {
      this.create_time = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("update_time".equals(__fieldName)) {
      this.update_time = (java.sql.Timestamp) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("id".equals(__fieldName)) {
      this.id = (Long) __fieldVal;
      return true;
    }
    else    if ("user_id".equals(__fieldName)) {
      this.user_id = (Long) __fieldVal;
      return true;
    }
    else    if ("bo_id".equals(__fieldName)) {
      this.bo_id = (Long) __fieldVal;
      return true;
    }
    else    if ("is_vip".equals(__fieldName)) {
      this.is_vip = (Integer) __fieldVal;
      return true;
    }
    else    if ("va_id".equals(__fieldName)) {
      this.va_id = (Long) __fieldVal;
      return true;
    }
    else    if ("original_principal".equals(__fieldName)) {
      this.original_principal = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price_principal".equals(__fieldName)) {
      this.price_principal = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price_interest".equals(__fieldName)) {
      this.price_interest = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price".equals(__fieldName)) {
      this.price = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price_punish".equals(__fieldName)) {
      this.price_punish = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("plan_time".equals(__fieldName)) {
      this.plan_time = (java.sql.Date) __fieldVal;
      return true;
    }
    else    if ("success_time".equals(__fieldName)) {
      this.success_time = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("is_pay".equals(__fieldName)) {
      this.is_pay = (Integer) __fieldVal;
      return true;
    }
    else    if ("owner_rate".equals(__fieldName)) {
      this.owner_rate = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("is_lender".equals(__fieldName)) {
      this.is_lender = (Integer) __fieldVal;
      return true;
    }
    else    if ("expect_num".equals(__fieldName)) {
      this.expect_num = (Integer) __fieldVal;
      return true;
    }
    else    if ("ba_transfer".equals(__fieldName)) {
      this.ba_transfer = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("ba_is_transfer".equals(__fieldName)) {
      this.ba_is_transfer = (Integer) __fieldVal;
      return true;
    }
    else    if ("seri_no".equals(__fieldName)) {
      this.seri_no = (String) __fieldVal;
      return true;
    }
    else    if ("version".equals(__fieldName)) {
      this.version = (Integer) __fieldVal;
      return true;
    }
    else    if ("create_time".equals(__fieldName)) {
      this.create_time = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("update_time".equals(__fieldName)) {
      this.update_time = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
