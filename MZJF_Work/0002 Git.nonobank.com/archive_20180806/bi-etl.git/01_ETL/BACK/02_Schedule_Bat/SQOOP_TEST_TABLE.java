// ORM class for table 'SQOOP_TEST_TABLE'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Wed Jun 21 17:32:58 CST 2017
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

public class SQOOP_TEST_TABLE extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private Integer stat_date;
  public Integer get_stat_date() {
    return stat_date;
  }
  public void set_stat_date(Integer stat_date) {
    this.stat_date = stat_date;
  }
  public SQOOP_TEST_TABLE with_stat_date(Integer stat_date) {
    this.stat_date = stat_date;
    return this;
  }
  private Long apply_no;
  public Long get_apply_no() {
    return apply_no;
  }
  public void set_apply_no(Long apply_no) {
    this.apply_no = apply_no;
  }
  public SQOOP_TEST_TABLE with_apply_no(Long apply_no) {
    this.apply_no = apply_no;
    return this;
  }
  private String apply_name;
  public String get_apply_name() {
    return apply_name;
  }
  public void set_apply_name(String apply_name) {
    this.apply_name = apply_name;
  }
  public SQOOP_TEST_TABLE with_apply_name(String apply_name) {
    this.apply_name = apply_name;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof SQOOP_TEST_TABLE)) {
      return false;
    }
    SQOOP_TEST_TABLE that = (SQOOP_TEST_TABLE) o;
    boolean equal = true;
    equal = equal && (this.stat_date == null ? that.stat_date == null : this.stat_date.equals(that.stat_date));
    equal = equal && (this.apply_no == null ? that.apply_no == null : this.apply_no.equals(that.apply_no));
    equal = equal && (this.apply_name == null ? that.apply_name == null : this.apply_name.equals(that.apply_name));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof SQOOP_TEST_TABLE)) {
      return false;
    }
    SQOOP_TEST_TABLE that = (SQOOP_TEST_TABLE) o;
    boolean equal = true;
    equal = equal && (this.stat_date == null ? that.stat_date == null : this.stat_date.equals(that.stat_date));
    equal = equal && (this.apply_no == null ? that.apply_no == null : this.apply_no.equals(that.apply_no));
    equal = equal && (this.apply_name == null ? that.apply_name == null : this.apply_name.equals(that.apply_name));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.stat_date = JdbcWritableBridge.readInteger(1, __dbResults);
    this.apply_no = JdbcWritableBridge.readLong(2, __dbResults);
    this.apply_name = JdbcWritableBridge.readString(3, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.stat_date = JdbcWritableBridge.readInteger(1, __dbResults);
    this.apply_no = JdbcWritableBridge.readLong(2, __dbResults);
    this.apply_name = JdbcWritableBridge.readString(3, __dbResults);
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
    JdbcWritableBridge.writeInteger(stat_date, 1 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeLong(apply_no, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(apply_name, 3 + __off, 12, __dbStmt);
    return 3;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeInteger(stat_date, 1 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeLong(apply_no, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(apply_name, 3 + __off, 12, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.stat_date = null;
    } else {
    this.stat_date = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.apply_no = null;
    } else {
    this.apply_no = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.apply_name = null;
    } else {
    this.apply_name = Text.readString(__dataIn);
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.stat_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.stat_date);
    }
    if (null == this.apply_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.apply_no);
    }
    if (null == this.apply_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, apply_name);
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.stat_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.stat_date);
    }
    if (null == this.apply_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.apply_no);
    }
    if (null == this.apply_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, apply_name);
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
    __sb.append(FieldFormatter.escapeAndEnclose(stat_date==null?"null":"" + stat_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_no==null?"null":"" + apply_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_name==null?"null":apply_name, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(stat_date==null?"null":"" + stat_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_no==null?"null":"" + apply_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_name==null?"null":apply_name, delimiters));
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
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.stat_date = null; } else {
      this.stat_date = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.apply_no = null; } else {
      this.apply_no = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.apply_name = null; } else {
      this.apply_name = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.stat_date = null; } else {
      this.stat_date = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.apply_no = null; } else {
      this.apply_no = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.apply_name = null; } else {
      this.apply_name = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    SQOOP_TEST_TABLE o = (SQOOP_TEST_TABLE) super.clone();
    return o;
  }

  public void clone0(SQOOP_TEST_TABLE o) throws CloneNotSupportedException {
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("stat_date", this.stat_date);
    __sqoop$field_map.put("apply_no", this.apply_no);
    __sqoop$field_map.put("apply_name", this.apply_name);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("stat_date", this.stat_date);
    __sqoop$field_map.put("apply_no", this.apply_no);
    __sqoop$field_map.put("apply_name", this.apply_name);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("stat_date".equals(__fieldName)) {
      this.stat_date = (Integer) __fieldVal;
    }
    else    if ("apply_no".equals(__fieldName)) {
      this.apply_no = (Long) __fieldVal;
    }
    else    if ("apply_name".equals(__fieldName)) {
      this.apply_name = (String) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("stat_date".equals(__fieldName)) {
      this.stat_date = (Integer) __fieldVal;
      return true;
    }
    else    if ("apply_no".equals(__fieldName)) {
      this.apply_no = (Long) __fieldVal;
      return true;
    }
    else    if ("apply_name".equals(__fieldName)) {
      this.apply_name = (String) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
