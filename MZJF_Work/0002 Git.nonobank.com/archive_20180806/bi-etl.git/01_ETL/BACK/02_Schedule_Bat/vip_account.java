// ORM class for table 'vip_account'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Mon May 22 14:49:51 CST 2017
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

public class vip_account extends SqoopRecord  implements DBWritable, Writable {
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
  public vip_account with_id(Long id) {
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
  public vip_account with_user_id(Long user_id) {
    this.user_id = user_id;
    return this;
  }
  private Integer type;
  public Integer get_type() {
    return type;
  }
  public void set_type(Integer type) {
    this.type = type;
  }
  public vip_account with_type(Integer type) {
    this.type = type;
    return this;
  }
  private Long fp_id;
  public Long get_fp_id() {
    return fp_id;
  }
  public void set_fp_id(Long fp_id) {
    this.fp_id = fp_id;
  }
  public vip_account with_fp_id(Long fp_id) {
    this.fp_id = fp_id;
    return this;
  }
  private java.math.BigDecimal amount;
  public java.math.BigDecimal get_amount() {
    return amount;
  }
  public void set_amount(java.math.BigDecimal amount) {
    this.amount = amount;
  }
  public vip_account with_amount(java.math.BigDecimal amount) {
    this.amount = amount;
    return this;
  }
  private String extno;
  public String get_extno() {
    return extno;
  }
  public void set_extno(String extno) {
    this.extno = extno;
  }
  public vip_account with_extno(String extno) {
    this.extno = extno;
    return this;
  }
  private String dscrpt;
  public String get_dscrpt() {
    return dscrpt;
  }
  public void set_dscrpt(String dscrpt) {
    this.dscrpt = dscrpt;
  }
  public vip_account with_dscrpt(String dscrpt) {
    this.dscrpt = dscrpt;
    return this;
  }
  private Integer is_cash;
  public Integer get_is_cash() {
    return is_cash;
  }
  public void set_is_cash(Integer is_cash) {
    this.is_cash = is_cash;
  }
  public vip_account with_is_cash(Integer is_cash) {
    this.is_cash = is_cash;
    return this;
  }
  private java.sql.Timestamp cash_time;
  public java.sql.Timestamp get_cash_time() {
    return cash_time;
  }
  public void set_cash_time(java.sql.Timestamp cash_time) {
    this.cash_time = cash_time;
  }
  public vip_account with_cash_time(java.sql.Timestamp cash_time) {
    this.cash_time = cash_time;
    return this;
  }
  private Boolean is_transfer;
  public Boolean get_is_transfer() {
    return is_transfer;
  }
  public void set_is_transfer(Boolean is_transfer) {
    this.is_transfer = is_transfer;
  }
  public vip_account with_is_transfer(Boolean is_transfer) {
    this.is_transfer = is_transfer;
    return this;
  }
  private Boolean is_quit;
  public Boolean get_is_quit() {
    return is_quit;
  }
  public void set_is_quit(Boolean is_quit) {
    this.is_quit = is_quit;
  }
  public vip_account with_is_quit(Boolean is_quit) {
    this.is_quit = is_quit;
    return this;
  }
  private Integer version;
  public Integer get_version() {
    return version;
  }
  public void set_version(Integer version) {
    this.version = version;
  }
  public vip_account with_version(Integer version) {
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
  public vip_account with_create_time(java.sql.Timestamp create_time) {
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
  public vip_account with_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof vip_account)) {
      return false;
    }
    vip_account that = (vip_account) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.type == null ? that.type == null : this.type.equals(that.type));
    equal = equal && (this.fp_id == null ? that.fp_id == null : this.fp_id.equals(that.fp_id));
    equal = equal && (this.amount == null ? that.amount == null : this.amount.equals(that.amount));
    equal = equal && (this.extno == null ? that.extno == null : this.extno.equals(that.extno));
    equal = equal && (this.dscrpt == null ? that.dscrpt == null : this.dscrpt.equals(that.dscrpt));
    equal = equal && (this.is_cash == null ? that.is_cash == null : this.is_cash.equals(that.is_cash));
    equal = equal && (this.cash_time == null ? that.cash_time == null : this.cash_time.equals(that.cash_time));
    equal = equal && (this.is_transfer == null ? that.is_transfer == null : this.is_transfer.equals(that.is_transfer));
    equal = equal && (this.is_quit == null ? that.is_quit == null : this.is_quit.equals(that.is_quit));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof vip_account)) {
      return false;
    }
    vip_account that = (vip_account) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.type == null ? that.type == null : this.type.equals(that.type));
    equal = equal && (this.fp_id == null ? that.fp_id == null : this.fp_id.equals(that.fp_id));
    equal = equal && (this.amount == null ? that.amount == null : this.amount.equals(that.amount));
    equal = equal && (this.extno == null ? that.extno == null : this.extno.equals(that.extno));
    equal = equal && (this.dscrpt == null ? that.dscrpt == null : this.dscrpt.equals(that.dscrpt));
    equal = equal && (this.is_cash == null ? that.is_cash == null : this.is_cash.equals(that.is_cash));
    equal = equal && (this.cash_time == null ? that.cash_time == null : this.cash_time.equals(that.cash_time));
    equal = equal && (this.is_transfer == null ? that.is_transfer == null : this.is_transfer.equals(that.is_transfer));
    equal = equal && (this.is_quit == null ? that.is_quit == null : this.is_quit.equals(that.is_quit));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.type = JdbcWritableBridge.readInteger(3, __dbResults);
    this.fp_id = JdbcWritableBridge.readLong(4, __dbResults);
    this.amount = JdbcWritableBridge.readBigDecimal(5, __dbResults);
    this.extno = JdbcWritableBridge.readString(6, __dbResults);
    this.dscrpt = JdbcWritableBridge.readString(7, __dbResults);
    this.is_cash = JdbcWritableBridge.readInteger(8, __dbResults);
    this.cash_time = JdbcWritableBridge.readTimestamp(9, __dbResults);
    this.is_transfer = JdbcWritableBridge.readBoolean(10, __dbResults);
    this.is_quit = JdbcWritableBridge.readBoolean(11, __dbResults);
    this.version = JdbcWritableBridge.readInteger(12, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(13, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(14, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.type = JdbcWritableBridge.readInteger(3, __dbResults);
    this.fp_id = JdbcWritableBridge.readLong(4, __dbResults);
    this.amount = JdbcWritableBridge.readBigDecimal(5, __dbResults);
    this.extno = JdbcWritableBridge.readString(6, __dbResults);
    this.dscrpt = JdbcWritableBridge.readString(7, __dbResults);
    this.is_cash = JdbcWritableBridge.readInteger(8, __dbResults);
    this.cash_time = JdbcWritableBridge.readTimestamp(9, __dbResults);
    this.is_transfer = JdbcWritableBridge.readBoolean(10, __dbResults);
    this.is_quit = JdbcWritableBridge.readBoolean(11, __dbResults);
    this.version = JdbcWritableBridge.readInteger(12, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(13, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(14, __dbResults);
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
    JdbcWritableBridge.writeInteger(type, 3 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeLong(fp_id, 4 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(amount, 5 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(extno, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(dscrpt, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(is_cash, 8 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeTimestamp(cash_time, 9 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeBoolean(is_transfer, 10 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeBoolean(is_quit, 11 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 13 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 14 + __off, 93, __dbStmt);
    return 14;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(user_id, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(type, 3 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeLong(fp_id, 4 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(amount, 5 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(extno, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(dscrpt, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(is_cash, 8 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeTimestamp(cash_time, 9 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeBoolean(is_transfer, 10 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeBoolean(is_quit, 11 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 13 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 14 + __off, 93, __dbStmt);
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
        this.type = null;
    } else {
    this.type = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.fp_id = null;
    } else {
    this.fp_id = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.amount = null;
    } else {
    this.amount = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.extno = null;
    } else {
    this.extno = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.dscrpt = null;
    } else {
    this.dscrpt = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.is_cash = null;
    } else {
    this.is_cash = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.cash_time = null;
    } else {
    this.cash_time = new Timestamp(__dataIn.readLong());
    this.cash_time.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.is_transfer = null;
    } else {
    this.is_transfer = Boolean.valueOf(__dataIn.readBoolean());
    }
    if (__dataIn.readBoolean()) { 
        this.is_quit = null;
    } else {
    this.is_quit = Boolean.valueOf(__dataIn.readBoolean());
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
    if (null == this.type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.type);
    }
    if (null == this.fp_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.fp_id);
    }
    if (null == this.amount) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.amount, __dataOut);
    }
    if (null == this.extno) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, extno);
    }
    if (null == this.dscrpt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, dscrpt);
    }
    if (null == this.is_cash) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_cash);
    }
    if (null == this.cash_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.cash_time.getTime());
    __dataOut.writeInt(this.cash_time.getNanos());
    }
    if (null == this.is_transfer) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.is_transfer);
    }
    if (null == this.is_quit) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.is_quit);
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
    if (null == this.type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.type);
    }
    if (null == this.fp_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.fp_id);
    }
    if (null == this.amount) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.amount, __dataOut);
    }
    if (null == this.extno) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, extno);
    }
    if (null == this.dscrpt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, dscrpt);
    }
    if (null == this.is_cash) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_cash);
    }
    if (null == this.cash_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.cash_time.getTime());
    __dataOut.writeInt(this.cash_time.getNanos());
    }
    if (null == this.is_transfer) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.is_transfer);
    }
    if (null == this.is_quit) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.is_quit);
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
    __sb.append(FieldFormatter.escapeAndEnclose(type==null?"\\N":"" + type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(fp_id==null?"\\N":"" + fp_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(amount==null?"\\N":amount.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(extno==null?"\\N":extno, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(dscrpt==null?"\\N":dscrpt, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_cash==null?"\\N":"" + is_cash, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(cash_time==null?"\\N":"" + cash_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_transfer==null?"\\N":"" + is_transfer, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_quit==null?"\\N":"" + is_quit, delimiters));
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
    __sb.append(FieldFormatter.escapeAndEnclose(type==null?"\\N":"" + type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(fp_id==null?"\\N":"" + fp_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(amount==null?"\\N":amount.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(extno==null?"\\N":extno, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(dscrpt==null?"\\N":dscrpt, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_cash==null?"\\N":"" + is_cash, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(cash_time==null?"\\N":"" + cash_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_transfer==null?"\\N":"" + is_transfer, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_quit==null?"\\N":"" + is_quit, delimiters));
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
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.type = null; } else {
      this.type = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.fp_id = null; } else {
      this.fp_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.amount = null; } else {
      this.amount = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.extno = null; } else {
      this.extno = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.dscrpt = null; } else {
      this.dscrpt = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_cash = null; } else {
      this.is_cash = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.cash_time = null; } else {
      this.cash_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_transfer = null; } else {
      this.is_transfer = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_quit = null; } else {
      this.is_quit = BooleanParser.valueOf(__cur_str);
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
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.type = null; } else {
      this.type = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.fp_id = null; } else {
      this.fp_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.amount = null; } else {
      this.amount = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.extno = null; } else {
      this.extno = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.dscrpt = null; } else {
      this.dscrpt = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_cash = null; } else {
      this.is_cash = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.cash_time = null; } else {
      this.cash_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_transfer = null; } else {
      this.is_transfer = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_quit = null; } else {
      this.is_quit = BooleanParser.valueOf(__cur_str);
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
    vip_account o = (vip_account) super.clone();
    o.cash_time = (o.cash_time != null) ? (java.sql.Timestamp) o.cash_time.clone() : null;
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    return o;
  }

  public void clone0(vip_account o) throws CloneNotSupportedException {
    o.cash_time = (o.cash_time != null) ? (java.sql.Timestamp) o.cash_time.clone() : null;
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("type", this.type);
    __sqoop$field_map.put("fp_id", this.fp_id);
    __sqoop$field_map.put("amount", this.amount);
    __sqoop$field_map.put("extno", this.extno);
    __sqoop$field_map.put("dscrpt", this.dscrpt);
    __sqoop$field_map.put("is_cash", this.is_cash);
    __sqoop$field_map.put("cash_time", this.cash_time);
    __sqoop$field_map.put("is_transfer", this.is_transfer);
    __sqoop$field_map.put("is_quit", this.is_quit);
    __sqoop$field_map.put("version", this.version);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("type", this.type);
    __sqoop$field_map.put("fp_id", this.fp_id);
    __sqoop$field_map.put("amount", this.amount);
    __sqoop$field_map.put("extno", this.extno);
    __sqoop$field_map.put("dscrpt", this.dscrpt);
    __sqoop$field_map.put("is_cash", this.is_cash);
    __sqoop$field_map.put("cash_time", this.cash_time);
    __sqoop$field_map.put("is_transfer", this.is_transfer);
    __sqoop$field_map.put("is_quit", this.is_quit);
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
    else    if ("type".equals(__fieldName)) {
      this.type = (Integer) __fieldVal;
    }
    else    if ("fp_id".equals(__fieldName)) {
      this.fp_id = (Long) __fieldVal;
    }
    else    if ("amount".equals(__fieldName)) {
      this.amount = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("extno".equals(__fieldName)) {
      this.extno = (String) __fieldVal;
    }
    else    if ("dscrpt".equals(__fieldName)) {
      this.dscrpt = (String) __fieldVal;
    }
    else    if ("is_cash".equals(__fieldName)) {
      this.is_cash = (Integer) __fieldVal;
    }
    else    if ("cash_time".equals(__fieldName)) {
      this.cash_time = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("is_transfer".equals(__fieldName)) {
      this.is_transfer = (Boolean) __fieldVal;
    }
    else    if ("is_quit".equals(__fieldName)) {
      this.is_quit = (Boolean) __fieldVal;
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
    else    if ("type".equals(__fieldName)) {
      this.type = (Integer) __fieldVal;
      return true;
    }
    else    if ("fp_id".equals(__fieldName)) {
      this.fp_id = (Long) __fieldVal;
      return true;
    }
    else    if ("amount".equals(__fieldName)) {
      this.amount = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("extno".equals(__fieldName)) {
      this.extno = (String) __fieldVal;
      return true;
    }
    else    if ("dscrpt".equals(__fieldName)) {
      this.dscrpt = (String) __fieldVal;
      return true;
    }
    else    if ("is_cash".equals(__fieldName)) {
      this.is_cash = (Integer) __fieldVal;
      return true;
    }
    else    if ("cash_time".equals(__fieldName)) {
      this.cash_time = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("is_transfer".equals(__fieldName)) {
      this.is_transfer = (Boolean) __fieldVal;
      return true;
    }
    else    if ("is_quit".equals(__fieldName)) {
      this.is_quit = (Boolean) __fieldVal;
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
