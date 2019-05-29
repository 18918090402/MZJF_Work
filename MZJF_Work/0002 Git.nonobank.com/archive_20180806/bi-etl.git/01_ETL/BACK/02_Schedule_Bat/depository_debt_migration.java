// ORM class for table 'depository_debt_migration'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Mon May 22 15:59:34 CST 2017
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

public class depository_debt_migration extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private Long user_id;
  public Long get_user_id() {
    return user_id;
  }
  public void set_user_id(Long user_id) {
    this.user_id = user_id;
  }
  public depository_debt_migration with_user_id(Long user_id) {
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
  public depository_debt_migration with_bo_id(Long bo_id) {
    this.bo_id = bo_id;
    return this;
  }
  private Long va_id;
  public Long get_va_id() {
    return va_id;
  }
  public void set_va_id(Long va_id) {
    this.va_id = va_id;
  }
  public depository_debt_migration with_va_id(Long va_id) {
    this.va_id = va_id;
    return this;
  }
  private Integer BATCH;
  public Integer get_BATCH() {
    return BATCH;
  }
  public void set_BATCH(Integer BATCH) {
    this.BATCH = BATCH;
  }
  public depository_debt_migration with_BATCH(Integer BATCH) {
    this.BATCH = BATCH;
    return this;
  }
  private String CARDNNBR;
  public String get_CARDNNBR() {
    return CARDNNBR;
  }
  public void set_CARDNNBR(String CARDNNBR) {
    this.CARDNNBR = CARDNNBR;
  }
  public depository_debt_migration with_CARDNNBR(String CARDNNBR) {
    this.CARDNNBR = CARDNNBR;
    return this;
  }
  private String PRODUCT;
  public String get_PRODUCT() {
    return PRODUCT;
  }
  public void set_PRODUCT(String PRODUCT) {
    this.PRODUCT = PRODUCT;
  }
  public depository_debt_migration with_PRODUCT(String PRODUCT) {
    this.PRODUCT = PRODUCT;
    return this;
  }
  private String SERI_NO;
  public String get_SERI_NO() {
    return SERI_NO;
  }
  public void set_SERI_NO(String SERI_NO) {
    this.SERI_NO = SERI_NO;
  }
  public depository_debt_migration with_SERI_NO(String SERI_NO) {
    this.SERI_NO = SERI_NO;
    return this;
  }
  private java.math.BigDecimal AMOUNT;
  public java.math.BigDecimal get_AMOUNT() {
    return AMOUNT;
  }
  public void set_AMOUNT(java.math.BigDecimal AMOUNT) {
    this.AMOUNT = AMOUNT;
  }
  public depository_debt_migration with_AMOUNT(java.math.BigDecimal AMOUNT) {
    this.AMOUNT = AMOUNT;
    return this;
  }
  private Integer ENDDATE;
  public Integer get_ENDDATE() {
    return ENDDATE;
  }
  public void set_ENDDATE(Integer ENDDATE) {
    this.ENDDATE = ENDDATE;
  }
  public depository_debt_migration with_ENDDATE(Integer ENDDATE) {
    this.ENDDATE = ENDDATE;
    return this;
  }
  private java.math.BigDecimal YIELD;
  public java.math.BigDecimal get_YIELD() {
    return YIELD;
  }
  public void set_YIELD(java.math.BigDecimal YIELD) {
    this.YIELD = YIELD;
  }
  public depository_debt_migration with_YIELD(java.math.BigDecimal YIELD) {
    this.YIELD = YIELD;
    return this;
  }
  private java.sql.Timestamp create_time;
  public java.sql.Timestamp get_create_time() {
    return create_time;
  }
  public void set_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
  }
  public depository_debt_migration with_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof depository_debt_migration)) {
      return false;
    }
    depository_debt_migration that = (depository_debt_migration) o;
    boolean equal = true;
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.bo_id == null ? that.bo_id == null : this.bo_id.equals(that.bo_id));
    equal = equal && (this.va_id == null ? that.va_id == null : this.va_id.equals(that.va_id));
    equal = equal && (this.BATCH == null ? that.BATCH == null : this.BATCH.equals(that.BATCH));
    equal = equal && (this.CARDNNBR == null ? that.CARDNNBR == null : this.CARDNNBR.equals(that.CARDNNBR));
    equal = equal && (this.PRODUCT == null ? that.PRODUCT == null : this.PRODUCT.equals(that.PRODUCT));
    equal = equal && (this.SERI_NO == null ? that.SERI_NO == null : this.SERI_NO.equals(that.SERI_NO));
    equal = equal && (this.AMOUNT == null ? that.AMOUNT == null : this.AMOUNT.equals(that.AMOUNT));
    equal = equal && (this.ENDDATE == null ? that.ENDDATE == null : this.ENDDATE.equals(that.ENDDATE));
    equal = equal && (this.YIELD == null ? that.YIELD == null : this.YIELD.equals(that.YIELD));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof depository_debt_migration)) {
      return false;
    }
    depository_debt_migration that = (depository_debt_migration) o;
    boolean equal = true;
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.bo_id == null ? that.bo_id == null : this.bo_id.equals(that.bo_id));
    equal = equal && (this.va_id == null ? that.va_id == null : this.va_id.equals(that.va_id));
    equal = equal && (this.BATCH == null ? that.BATCH == null : this.BATCH.equals(that.BATCH));
    equal = equal && (this.CARDNNBR == null ? that.CARDNNBR == null : this.CARDNNBR.equals(that.CARDNNBR));
    equal = equal && (this.PRODUCT == null ? that.PRODUCT == null : this.PRODUCT.equals(that.PRODUCT));
    equal = equal && (this.SERI_NO == null ? that.SERI_NO == null : this.SERI_NO.equals(that.SERI_NO));
    equal = equal && (this.AMOUNT == null ? that.AMOUNT == null : this.AMOUNT.equals(that.AMOUNT));
    equal = equal && (this.ENDDATE == null ? that.ENDDATE == null : this.ENDDATE.equals(that.ENDDATE));
    equal = equal && (this.YIELD == null ? that.YIELD == null : this.YIELD.equals(that.YIELD));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.user_id = JdbcWritableBridge.readLong(1, __dbResults);
    this.bo_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.va_id = JdbcWritableBridge.readLong(3, __dbResults);
    this.BATCH = JdbcWritableBridge.readInteger(4, __dbResults);
    this.CARDNNBR = JdbcWritableBridge.readString(5, __dbResults);
    this.PRODUCT = JdbcWritableBridge.readString(6, __dbResults);
    this.SERI_NO = JdbcWritableBridge.readString(7, __dbResults);
    this.AMOUNT = JdbcWritableBridge.readBigDecimal(8, __dbResults);
    this.ENDDATE = JdbcWritableBridge.readInteger(9, __dbResults);
    this.YIELD = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(11, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.user_id = JdbcWritableBridge.readLong(1, __dbResults);
    this.bo_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.va_id = JdbcWritableBridge.readLong(3, __dbResults);
    this.BATCH = JdbcWritableBridge.readInteger(4, __dbResults);
    this.CARDNNBR = JdbcWritableBridge.readString(5, __dbResults);
    this.PRODUCT = JdbcWritableBridge.readString(6, __dbResults);
    this.SERI_NO = JdbcWritableBridge.readString(7, __dbResults);
    this.AMOUNT = JdbcWritableBridge.readBigDecimal(8, __dbResults);
    this.ENDDATE = JdbcWritableBridge.readInteger(9, __dbResults);
    this.YIELD = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(11, __dbResults);
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
    JdbcWritableBridge.writeLong(user_id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(bo_id, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(va_id, 3 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(BATCH, 4 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(CARDNNBR, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(PRODUCT, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(SERI_NO, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(AMOUNT, 8 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(ENDDATE, 9 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(YIELD, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 11 + __off, 93, __dbStmt);
    return 11;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(user_id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(bo_id, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(va_id, 3 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(BATCH, 4 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(CARDNNBR, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(PRODUCT, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(SERI_NO, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(AMOUNT, 8 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(ENDDATE, 9 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(YIELD, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 11 + __off, 93, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
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
        this.va_id = null;
    } else {
    this.va_id = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.BATCH = null;
    } else {
    this.BATCH = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.CARDNNBR = null;
    } else {
    this.CARDNNBR = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PRODUCT = null;
    } else {
    this.PRODUCT = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.SERI_NO = null;
    } else {
    this.SERI_NO = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.AMOUNT = null;
    } else {
    this.AMOUNT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ENDDATE = null;
    } else {
    this.ENDDATE = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.YIELD = null;
    } else {
    this.YIELD = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.create_time = null;
    } else {
    this.create_time = new Timestamp(__dataIn.readLong());
    this.create_time.setNanos(__dataIn.readInt());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
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
    if (null == this.va_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.va_id);
    }
    if (null == this.BATCH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.BATCH);
    }
    if (null == this.CARDNNBR) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, CARDNNBR);
    }
    if (null == this.PRODUCT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PRODUCT);
    }
    if (null == this.SERI_NO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, SERI_NO);
    }
    if (null == this.AMOUNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.AMOUNT, __dataOut);
    }
    if (null == this.ENDDATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ENDDATE);
    }
    if (null == this.YIELD) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.YIELD, __dataOut);
    }
    if (null == this.create_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.create_time.getTime());
    __dataOut.writeInt(this.create_time.getNanos());
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
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
    if (null == this.va_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.va_id);
    }
    if (null == this.BATCH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.BATCH);
    }
    if (null == this.CARDNNBR) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, CARDNNBR);
    }
    if (null == this.PRODUCT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PRODUCT);
    }
    if (null == this.SERI_NO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, SERI_NO);
    }
    if (null == this.AMOUNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.AMOUNT, __dataOut);
    }
    if (null == this.ENDDATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ENDDATE);
    }
    if (null == this.YIELD) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.YIELD, __dataOut);
    }
    if (null == this.create_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.create_time.getTime());
    __dataOut.writeInt(this.create_time.getNanos());
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
    __sb.append(FieldFormatter.escapeAndEnclose(user_id==null?"null":"" + user_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bo_id==null?"null":"" + bo_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(va_id==null?"null":"" + va_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BATCH==null?"null":"" + BATCH, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CARDNNBR==null?"null":CARDNNBR, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRODUCT==null?"null":PRODUCT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SERI_NO==null?"null":SERI_NO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(AMOUNT==null?"null":AMOUNT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ENDDATE==null?"null":"" + ENDDATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(YIELD==null?"null":YIELD.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"null":"" + create_time, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(user_id==null?"null":"" + user_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bo_id==null?"null":"" + bo_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(va_id==null?"null":"" + va_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BATCH==null?"null":"" + BATCH, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CARDNNBR==null?"null":CARDNNBR, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PRODUCT==null?"null":PRODUCT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SERI_NO==null?"null":SERI_NO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(AMOUNT==null?"null":AMOUNT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ENDDATE==null?"null":"" + ENDDATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(YIELD==null?"null":YIELD.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"null":"" + create_time, delimiters));
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
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.user_id = null; } else {
      this.user_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.bo_id = null; } else {
      this.bo_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.va_id = null; } else {
      this.va_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BATCH = null; } else {
      this.BATCH = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.CARDNNBR = null; } else {
      this.CARDNNBR = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.PRODUCT = null; } else {
      this.PRODUCT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.SERI_NO = null; } else {
      this.SERI_NO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.AMOUNT = null; } else {
      this.AMOUNT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ENDDATE = null; } else {
      this.ENDDATE = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.YIELD = null; } else {
      this.YIELD = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.user_id = null; } else {
      this.user_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.bo_id = null; } else {
      this.bo_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.va_id = null; } else {
      this.va_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.BATCH = null; } else {
      this.BATCH = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.CARDNNBR = null; } else {
      this.CARDNNBR = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.PRODUCT = null; } else {
      this.PRODUCT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.SERI_NO = null; } else {
      this.SERI_NO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.AMOUNT = null; } else {
      this.AMOUNT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ENDDATE = null; } else {
      this.ENDDATE = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.YIELD = null; } else {
      this.YIELD = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    depository_debt_migration o = (depository_debt_migration) super.clone();
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    return o;
  }

  public void clone0(depository_debt_migration o) throws CloneNotSupportedException {
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("bo_id", this.bo_id);
    __sqoop$field_map.put("va_id", this.va_id);
    __sqoop$field_map.put("BATCH", this.BATCH);
    __sqoop$field_map.put("CARDNNBR", this.CARDNNBR);
    __sqoop$field_map.put("PRODUCT", this.PRODUCT);
    __sqoop$field_map.put("SERI_NO", this.SERI_NO);
    __sqoop$field_map.put("AMOUNT", this.AMOUNT);
    __sqoop$field_map.put("ENDDATE", this.ENDDATE);
    __sqoop$field_map.put("YIELD", this.YIELD);
    __sqoop$field_map.put("create_time", this.create_time);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("bo_id", this.bo_id);
    __sqoop$field_map.put("va_id", this.va_id);
    __sqoop$field_map.put("BATCH", this.BATCH);
    __sqoop$field_map.put("CARDNNBR", this.CARDNNBR);
    __sqoop$field_map.put("PRODUCT", this.PRODUCT);
    __sqoop$field_map.put("SERI_NO", this.SERI_NO);
    __sqoop$field_map.put("AMOUNT", this.AMOUNT);
    __sqoop$field_map.put("ENDDATE", this.ENDDATE);
    __sqoop$field_map.put("YIELD", this.YIELD);
    __sqoop$field_map.put("create_time", this.create_time);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("user_id".equals(__fieldName)) {
      this.user_id = (Long) __fieldVal;
    }
    else    if ("bo_id".equals(__fieldName)) {
      this.bo_id = (Long) __fieldVal;
    }
    else    if ("va_id".equals(__fieldName)) {
      this.va_id = (Long) __fieldVal;
    }
    else    if ("BATCH".equals(__fieldName)) {
      this.BATCH = (Integer) __fieldVal;
    }
    else    if ("CARDNNBR".equals(__fieldName)) {
      this.CARDNNBR = (String) __fieldVal;
    }
    else    if ("PRODUCT".equals(__fieldName)) {
      this.PRODUCT = (String) __fieldVal;
    }
    else    if ("SERI_NO".equals(__fieldName)) {
      this.SERI_NO = (String) __fieldVal;
    }
    else    if ("AMOUNT".equals(__fieldName)) {
      this.AMOUNT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("ENDDATE".equals(__fieldName)) {
      this.ENDDATE = (Integer) __fieldVal;
    }
    else    if ("YIELD".equals(__fieldName)) {
      this.YIELD = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("create_time".equals(__fieldName)) {
      this.create_time = (java.sql.Timestamp) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("user_id".equals(__fieldName)) {
      this.user_id = (Long) __fieldVal;
      return true;
    }
    else    if ("bo_id".equals(__fieldName)) {
      this.bo_id = (Long) __fieldVal;
      return true;
    }
    else    if ("va_id".equals(__fieldName)) {
      this.va_id = (Long) __fieldVal;
      return true;
    }
    else    if ("BATCH".equals(__fieldName)) {
      this.BATCH = (Integer) __fieldVal;
      return true;
    }
    else    if ("CARDNNBR".equals(__fieldName)) {
      this.CARDNNBR = (String) __fieldVal;
      return true;
    }
    else    if ("PRODUCT".equals(__fieldName)) {
      this.PRODUCT = (String) __fieldVal;
      return true;
    }
    else    if ("SERI_NO".equals(__fieldName)) {
      this.SERI_NO = (String) __fieldVal;
      return true;
    }
    else    if ("AMOUNT".equals(__fieldName)) {
      this.AMOUNT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("ENDDATE".equals(__fieldName)) {
      this.ENDDATE = (Integer) __fieldVal;
      return true;
    }
    else    if ("YIELD".equals(__fieldName)) {
      this.YIELD = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("create_time".equals(__fieldName)) {
      this.create_time = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
