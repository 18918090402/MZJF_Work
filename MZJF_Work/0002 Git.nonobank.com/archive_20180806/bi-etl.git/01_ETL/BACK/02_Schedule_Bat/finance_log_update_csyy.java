// ORM class for table 'finance_log_update_csyy'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Fri Jul 07 18:58:50 CST 2017
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

public class finance_log_update_csyy extends SqoopRecord  implements DBWritable, Writable {
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
  public finance_log_update_csyy with_id(Long id) {
    this.id = id;
    return this;
  }
  private java.sql.Timestamp update_time;
  public java.sql.Timestamp get_update_time() {
    return update_time;
  }
  public void set_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
  }
  public finance_log_update_csyy with_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
    return this;
  }
  private java.math.BigDecimal balance;
  public java.math.BigDecimal get_balance() {
    return balance;
  }
  public void set_balance(java.math.BigDecimal balance) {
    this.balance = balance;
  }
  public finance_log_update_csyy with_balance(java.math.BigDecimal balance) {
    this.balance = balance;
    return this;
  }
  private java.math.BigDecimal balance_new;
  public java.math.BigDecimal get_balance_new() {
    return balance_new;
  }
  public void set_balance_new(java.math.BigDecimal balance_new) {
    this.balance_new = balance_new;
  }
  public finance_log_update_csyy with_balance_new(java.math.BigDecimal balance_new) {
    this.balance_new = balance_new;
    return this;
  }
  private java.sql.Timestamp DW_CREATE_TIME;
  public java.sql.Timestamp get_DW_CREATE_TIME() {
    return DW_CREATE_TIME;
  }
  public void set_DW_CREATE_TIME(java.sql.Timestamp DW_CREATE_TIME) {
    this.DW_CREATE_TIME = DW_CREATE_TIME;
  }
  public finance_log_update_csyy with_DW_CREATE_TIME(java.sql.Timestamp DW_CREATE_TIME) {
    this.DW_CREATE_TIME = DW_CREATE_TIME;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof finance_log_update_csyy)) {
      return false;
    }
    finance_log_update_csyy that = (finance_log_update_csyy) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.balance == null ? that.balance == null : this.balance.equals(that.balance));
    equal = equal && (this.balance_new == null ? that.balance_new == null : this.balance_new.equals(that.balance_new));
    equal = equal && (this.DW_CREATE_TIME == null ? that.DW_CREATE_TIME == null : this.DW_CREATE_TIME.equals(that.DW_CREATE_TIME));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof finance_log_update_csyy)) {
      return false;
    }
    finance_log_update_csyy that = (finance_log_update_csyy) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.balance == null ? that.balance == null : this.balance.equals(that.balance));
    equal = equal && (this.balance_new == null ? that.balance_new == null : this.balance_new.equals(that.balance_new));
    equal = equal && (this.DW_CREATE_TIME == null ? that.DW_CREATE_TIME == null : this.DW_CREATE_TIME.equals(that.DW_CREATE_TIME));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(2, __dbResults);
    this.balance = JdbcWritableBridge.readBigDecimal(3, __dbResults);
    this.balance_new = JdbcWritableBridge.readBigDecimal(4, __dbResults);
    this.DW_CREATE_TIME = JdbcWritableBridge.readTimestamp(5, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(2, __dbResults);
    this.balance = JdbcWritableBridge.readBigDecimal(3, __dbResults);
    this.balance_new = JdbcWritableBridge.readBigDecimal(4, __dbResults);
    this.DW_CREATE_TIME = JdbcWritableBridge.readTimestamp(5, __dbResults);
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
    JdbcWritableBridge.writeTimestamp(update_time, 2 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(balance, 3 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(balance_new, 4 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeTimestamp(DW_CREATE_TIME, 5 + __off, 93, __dbStmt);
    return 5;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 2 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(balance, 3 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(balance_new, 4 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeTimestamp(DW_CREATE_TIME, 5 + __off, 93, __dbStmt);
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
        this.update_time = null;
    } else {
    this.update_time = new Timestamp(__dataIn.readLong());
    this.update_time.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.balance = null;
    } else {
    this.balance = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.balance_new = null;
    } else {
    this.balance_new = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.DW_CREATE_TIME = null;
    } else {
    this.DW_CREATE_TIME = new Timestamp(__dataIn.readLong());
    this.DW_CREATE_TIME.setNanos(__dataIn.readInt());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.id);
    }
    if (null == this.update_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.update_time.getTime());
    __dataOut.writeInt(this.update_time.getNanos());
    }
    if (null == this.balance) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.balance, __dataOut);
    }
    if (null == this.balance_new) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.balance_new, __dataOut);
    }
    if (null == this.DW_CREATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.DW_CREATE_TIME.getTime());
    __dataOut.writeInt(this.DW_CREATE_TIME.getNanos());
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.id);
    }
    if (null == this.update_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.update_time.getTime());
    __dataOut.writeInt(this.update_time.getNanos());
    }
    if (null == this.balance) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.balance, __dataOut);
    }
    if (null == this.balance_new) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.balance_new, __dataOut);
    }
    if (null == this.DW_CREATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.DW_CREATE_TIME.getTime());
    __dataOut.writeInt(this.DW_CREATE_TIME.getNanos());
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
    __sb.append(FieldFormatter.escapeAndEnclose(id==null?"null":"" + id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"null":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(balance==null?"null":balance.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(balance_new==null?"null":balance_new.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_CREATE_TIME==null?"null":"" + DW_CREATE_TIME, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(id==null?"null":"" + id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"null":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(balance==null?"null":balance.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(balance_new==null?"null":balance_new.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DW_CREATE_TIME==null?"null":"" + DW_CREATE_TIME, delimiters));
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
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.id = null; } else {
      this.id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.update_time = null; } else {
      this.update_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.balance = null; } else {
      this.balance = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.balance_new = null; } else {
      this.balance_new = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.DW_CREATE_TIME = null; } else {
      this.DW_CREATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.id = null; } else {
      this.id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.update_time = null; } else {
      this.update_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.balance = null; } else {
      this.balance = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.balance_new = null; } else {
      this.balance_new = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.DW_CREATE_TIME = null; } else {
      this.DW_CREATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    finance_log_update_csyy o = (finance_log_update_csyy) super.clone();
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    o.DW_CREATE_TIME = (o.DW_CREATE_TIME != null) ? (java.sql.Timestamp) o.DW_CREATE_TIME.clone() : null;
    return o;
  }

  public void clone0(finance_log_update_csyy o) throws CloneNotSupportedException {
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    o.DW_CREATE_TIME = (o.DW_CREATE_TIME != null) ? (java.sql.Timestamp) o.DW_CREATE_TIME.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("balance", this.balance);
    __sqoop$field_map.put("balance_new", this.balance_new);
    __sqoop$field_map.put("DW_CREATE_TIME", this.DW_CREATE_TIME);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("balance", this.balance);
    __sqoop$field_map.put("balance_new", this.balance_new);
    __sqoop$field_map.put("DW_CREATE_TIME", this.DW_CREATE_TIME);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("id".equals(__fieldName)) {
      this.id = (Long) __fieldVal;
    }
    else    if ("update_time".equals(__fieldName)) {
      this.update_time = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("balance".equals(__fieldName)) {
      this.balance = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("balance_new".equals(__fieldName)) {
      this.balance_new = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("DW_CREATE_TIME".equals(__fieldName)) {
      this.DW_CREATE_TIME = (java.sql.Timestamp) __fieldVal;
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
    else    if ("update_time".equals(__fieldName)) {
      this.update_time = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("balance".equals(__fieldName)) {
      this.balance = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("balance_new".equals(__fieldName)) {
      this.balance_new = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("DW_CREATE_TIME".equals(__fieldName)) {
      this.DW_CREATE_TIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
