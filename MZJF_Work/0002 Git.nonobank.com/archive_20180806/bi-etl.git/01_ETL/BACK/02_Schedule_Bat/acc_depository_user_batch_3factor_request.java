// ORM class for table 'acc_depository_user_batch_3factor_request'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Mon May 22 16:26:51 CST 2017
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

public class acc_depository_user_batch_3factor_request extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private String id_type;
  public String get_id_type() {
    return id_type;
  }
  public void set_id_type(String id_type) {
    this.id_type = id_type;
  }
  public acc_depository_user_batch_3factor_request with_id_type(String id_type) {
    this.id_type = id_type;
    return this;
  }
  private String id_no;
  public String get_id_no() {
    return id_no;
  }
  public void set_id_no(String id_no) {
    this.id_no = id_no;
  }
  public acc_depository_user_batch_3factor_request with_id_no(String id_no) {
    this.id_no = id_no;
    return this;
  }
  private String name;
  public String get_name() {
    return name;
  }
  public void set_name(String name) {
    this.name = name;
  }
  public acc_depository_user_batch_3factor_request with_name(String name) {
    this.name = name;
    return this;
  }
  private String mobile;
  public String get_mobile() {
    return mobile;
  }
  public void set_mobile(String mobile) {
    this.mobile = mobile;
  }
  public acc_depository_user_batch_3factor_request with_mobile(String mobile) {
    this.mobile = mobile;
    return this;
  }
  private String gen;
  public String get_gen() {
    return gen;
  }
  public void set_gen(String gen) {
    this.gen = gen;
  }
  public acc_depository_user_batch_3factor_request with_gen(String gen) {
    this.gen = gen;
    return this;
  }
  private String user_no;
  public String get_user_no() {
    return user_no;
  }
  public void set_user_no(String user_no) {
    this.user_no = user_no;
  }
  public acc_depository_user_batch_3factor_request with_user_no(String user_no) {
    this.user_no = user_no;
    return this;
  }
  private java.sql.Timestamp create_time;
  public java.sql.Timestamp get_create_time() {
    return create_time;
  }
  public void set_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
  }
  public acc_depository_user_batch_3factor_request with_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof acc_depository_user_batch_3factor_request)) {
      return false;
    }
    acc_depository_user_batch_3factor_request that = (acc_depository_user_batch_3factor_request) o;
    boolean equal = true;
    equal = equal && (this.id_type == null ? that.id_type == null : this.id_type.equals(that.id_type));
    equal = equal && (this.id_no == null ? that.id_no == null : this.id_no.equals(that.id_no));
    equal = equal && (this.name == null ? that.name == null : this.name.equals(that.name));
    equal = equal && (this.mobile == null ? that.mobile == null : this.mobile.equals(that.mobile));
    equal = equal && (this.gen == null ? that.gen == null : this.gen.equals(that.gen));
    equal = equal && (this.user_no == null ? that.user_no == null : this.user_no.equals(that.user_no));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof acc_depository_user_batch_3factor_request)) {
      return false;
    }
    acc_depository_user_batch_3factor_request that = (acc_depository_user_batch_3factor_request) o;
    boolean equal = true;
    equal = equal && (this.id_type == null ? that.id_type == null : this.id_type.equals(that.id_type));
    equal = equal && (this.id_no == null ? that.id_no == null : this.id_no.equals(that.id_no));
    equal = equal && (this.name == null ? that.name == null : this.name.equals(that.name));
    equal = equal && (this.mobile == null ? that.mobile == null : this.mobile.equals(that.mobile));
    equal = equal && (this.gen == null ? that.gen == null : this.gen.equals(that.gen));
    equal = equal && (this.user_no == null ? that.user_no == null : this.user_no.equals(that.user_no));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id_type = JdbcWritableBridge.readString(1, __dbResults);
    this.id_no = JdbcWritableBridge.readString(2, __dbResults);
    this.name = JdbcWritableBridge.readString(3, __dbResults);
    this.mobile = JdbcWritableBridge.readString(4, __dbResults);
    this.gen = JdbcWritableBridge.readString(5, __dbResults);
    this.user_no = JdbcWritableBridge.readString(6, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(7, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id_type = JdbcWritableBridge.readString(1, __dbResults);
    this.id_no = JdbcWritableBridge.readString(2, __dbResults);
    this.name = JdbcWritableBridge.readString(3, __dbResults);
    this.mobile = JdbcWritableBridge.readString(4, __dbResults);
    this.gen = JdbcWritableBridge.readString(5, __dbResults);
    this.user_no = JdbcWritableBridge.readString(6, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(7, __dbResults);
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
    JdbcWritableBridge.writeString(id_type, 1 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(id_no, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(name, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(mobile, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(gen, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(user_no, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 7 + __off, 93, __dbStmt);
    return 7;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeString(id_type, 1 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(id_no, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(name, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(mobile, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(gen, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(user_no, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 7 + __off, 93, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.id_type = null;
    } else {
    this.id_type = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.id_no = null;
    } else {
    this.id_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.name = null;
    } else {
    this.name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.mobile = null;
    } else {
    this.mobile = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.gen = null;
    } else {
    this.gen = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.user_no = null;
    } else {
    this.user_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.create_time = null;
    } else {
    this.create_time = new Timestamp(__dataIn.readLong());
    this.create_time.setNanos(__dataIn.readInt());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.id_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, id_type);
    }
    if (null == this.id_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, id_no);
    }
    if (null == this.name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, name);
    }
    if (null == this.mobile) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, mobile);
    }
    if (null == this.gen) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, gen);
    }
    if (null == this.user_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, user_no);
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
    if (null == this.id_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, id_type);
    }
    if (null == this.id_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, id_no);
    }
    if (null == this.name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, name);
    }
    if (null == this.mobile) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, mobile);
    }
    if (null == this.gen) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, gen);
    }
    if (null == this.user_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, user_no);
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
    __sb.append(FieldFormatter.escapeAndEnclose(id_type==null?"null":id_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(id_no==null?"null":id_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(name==null?"null":name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(mobile==null?"null":mobile, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(gen==null?"null":gen, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(user_no==null?"null":user_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"null":"" + create_time, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(id_type==null?"null":id_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(id_no==null?"null":id_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(name==null?"null":name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(mobile==null?"null":mobile, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(gen==null?"null":gen, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(user_no==null?"null":user_no, delimiters));
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
    if (__cur_str.equals("\\N")) { this.id_type = null; } else {
      this.id_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.id_no = null; } else {
      this.id_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.name = null; } else {
      this.name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.mobile = null; } else {
      this.mobile = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.gen = null; } else {
      this.gen = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.user_no = null; } else {
      this.user_no = __cur_str;
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
    if (__cur_str.equals("\\N")) { this.id_type = null; } else {
      this.id_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.id_no = null; } else {
      this.id_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.name = null; } else {
      this.name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.mobile = null; } else {
      this.mobile = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.gen = null; } else {
      this.gen = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.user_no = null; } else {
      this.user_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    acc_depository_user_batch_3factor_request o = (acc_depository_user_batch_3factor_request) super.clone();
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    return o;
  }

  public void clone0(acc_depository_user_batch_3factor_request o) throws CloneNotSupportedException {
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id_type", this.id_type);
    __sqoop$field_map.put("id_no", this.id_no);
    __sqoop$field_map.put("name", this.name);
    __sqoop$field_map.put("mobile", this.mobile);
    __sqoop$field_map.put("gen", this.gen);
    __sqoop$field_map.put("user_no", this.user_no);
    __sqoop$field_map.put("create_time", this.create_time);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id_type", this.id_type);
    __sqoop$field_map.put("id_no", this.id_no);
    __sqoop$field_map.put("name", this.name);
    __sqoop$field_map.put("mobile", this.mobile);
    __sqoop$field_map.put("gen", this.gen);
    __sqoop$field_map.put("user_no", this.user_no);
    __sqoop$field_map.put("create_time", this.create_time);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("id_type".equals(__fieldName)) {
      this.id_type = (String) __fieldVal;
    }
    else    if ("id_no".equals(__fieldName)) {
      this.id_no = (String) __fieldVal;
    }
    else    if ("name".equals(__fieldName)) {
      this.name = (String) __fieldVal;
    }
    else    if ("mobile".equals(__fieldName)) {
      this.mobile = (String) __fieldVal;
    }
    else    if ("gen".equals(__fieldName)) {
      this.gen = (String) __fieldVal;
    }
    else    if ("user_no".equals(__fieldName)) {
      this.user_no = (String) __fieldVal;
    }
    else    if ("create_time".equals(__fieldName)) {
      this.create_time = (java.sql.Timestamp) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("id_type".equals(__fieldName)) {
      this.id_type = (String) __fieldVal;
      return true;
    }
    else    if ("id_no".equals(__fieldName)) {
      this.id_no = (String) __fieldVal;
      return true;
    }
    else    if ("name".equals(__fieldName)) {
      this.name = (String) __fieldVal;
      return true;
    }
    else    if ("mobile".equals(__fieldName)) {
      this.mobile = (String) __fieldVal;
      return true;
    }
    else    if ("gen".equals(__fieldName)) {
      this.gen = (String) __fieldVal;
      return true;
    }
    else    if ("user_no".equals(__fieldName)) {
      this.user_no = (String) __fieldVal;
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
