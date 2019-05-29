// ORM class for table 'user_action_log'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Thu Jun 15 19:47:59 CST 2017
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

public class user_action_log extends SqoopRecord  implements DBWritable, Writable {
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
  public user_action_log with_id(Long id) {
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
  public user_action_log with_user_id(Long user_id) {
    this.user_id = user_id;
    return this;
  }
  private String action_content;
  public String get_action_content() {
    return action_content;
  }
  public void set_action_content(String action_content) {
    this.action_content = action_content;
  }
  public user_action_log with_action_content(String action_content) {
    this.action_content = action_content;
    return this;
  }
  private Integer action_type;
  public Integer get_action_type() {
    return action_type;
  }
  public void set_action_type(Integer action_type) {
    this.action_type = action_type;
  }
  public user_action_log with_action_type(Integer action_type) {
    this.action_type = action_type;
    return this;
  }
  private String terminal;
  public String get_terminal() {
    return terminal;
  }
  public void set_terminal(String terminal) {
    this.terminal = terminal;
  }
  public user_action_log with_terminal(String terminal) {
    this.terminal = terminal;
    return this;
  }
  private String ip;
  public String get_ip() {
    return ip;
  }
  public void set_ip(String ip) {
    this.ip = ip;
  }
  public user_action_log with_ip(String ip) {
    this.ip = ip;
    return this;
  }
  private java.sql.Timestamp create_time;
  public java.sql.Timestamp get_create_time() {
    return create_time;
  }
  public void set_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
  }
  public user_action_log with_create_time(java.sql.Timestamp create_time) {
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
  public user_action_log with_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
    return this;
  }
  private Long creater;
  public Long get_creater() {
    return creater;
  }
  public void set_creater(Long creater) {
    this.creater = creater;
  }
  public user_action_log with_creater(Long creater) {
    this.creater = creater;
    return this;
  }
  private Long updater;
  public Long get_updater() {
    return updater;
  }
  public void set_updater(Long updater) {
    this.updater = updater;
  }
  public user_action_log with_updater(Long updater) {
    this.updater = updater;
    return this;
  }
  private Integer version;
  public Integer get_version() {
    return version;
  }
  public void set_version(Integer version) {
    this.version = version;
  }
  public user_action_log with_version(Integer version) {
    this.version = version;
    return this;
  }
  private String action_from;
  public String get_action_from() {
    return action_from;
  }
  public void set_action_from(String action_from) {
    this.action_from = action_from;
  }
  public user_action_log with_action_from(String action_from) {
    this.action_from = action_from;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof user_action_log)) {
      return false;
    }
    user_action_log that = (user_action_log) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.action_content == null ? that.action_content == null : this.action_content.equals(that.action_content));
    equal = equal && (this.action_type == null ? that.action_type == null : this.action_type.equals(that.action_type));
    equal = equal && (this.terminal == null ? that.terminal == null : this.terminal.equals(that.terminal));
    equal = equal && (this.ip == null ? that.ip == null : this.ip.equals(that.ip));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.creater == null ? that.creater == null : this.creater.equals(that.creater));
    equal = equal && (this.updater == null ? that.updater == null : this.updater.equals(that.updater));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.action_from == null ? that.action_from == null : this.action_from.equals(that.action_from));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof user_action_log)) {
      return false;
    }
    user_action_log that = (user_action_log) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.action_content == null ? that.action_content == null : this.action_content.equals(that.action_content));
    equal = equal && (this.action_type == null ? that.action_type == null : this.action_type.equals(that.action_type));
    equal = equal && (this.terminal == null ? that.terminal == null : this.terminal.equals(that.terminal));
    equal = equal && (this.ip == null ? that.ip == null : this.ip.equals(that.ip));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.creater == null ? that.creater == null : this.creater.equals(that.creater));
    equal = equal && (this.updater == null ? that.updater == null : this.updater.equals(that.updater));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.action_from == null ? that.action_from == null : this.action_from.equals(that.action_from));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.action_content = JdbcWritableBridge.readString(3, __dbResults);
    this.action_type = JdbcWritableBridge.readInteger(4, __dbResults);
    this.terminal = JdbcWritableBridge.readString(5, __dbResults);
    this.ip = JdbcWritableBridge.readString(6, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(7, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(8, __dbResults);
    this.creater = JdbcWritableBridge.readLong(9, __dbResults);
    this.updater = JdbcWritableBridge.readLong(10, __dbResults);
    this.version = JdbcWritableBridge.readInteger(11, __dbResults);
    this.action_from = JdbcWritableBridge.readString(12, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.action_content = JdbcWritableBridge.readString(3, __dbResults);
    this.action_type = JdbcWritableBridge.readInteger(4, __dbResults);
    this.terminal = JdbcWritableBridge.readString(5, __dbResults);
    this.ip = JdbcWritableBridge.readString(6, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(7, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(8, __dbResults);
    this.creater = JdbcWritableBridge.readLong(9, __dbResults);
    this.updater = JdbcWritableBridge.readLong(10, __dbResults);
    this.version = JdbcWritableBridge.readInteger(11, __dbResults);
    this.action_from = JdbcWritableBridge.readString(12, __dbResults);
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
    JdbcWritableBridge.writeString(action_content, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(action_type, 4 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(terminal, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(ip, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 7 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 8 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeLong(creater, 9 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(updater, 10 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 11 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(action_from, 12 + __off, 12, __dbStmt);
    return 12;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(user_id, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(action_content, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(action_type, 4 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(terminal, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(ip, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 7 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 8 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeLong(creater, 9 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(updater, 10 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 11 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(action_from, 12 + __off, 12, __dbStmt);
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
        this.action_content = null;
    } else {
    this.action_content = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.action_type = null;
    } else {
    this.action_type = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.terminal = null;
    } else {
    this.terminal = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ip = null;
    } else {
    this.ip = Text.readString(__dataIn);
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
    if (__dataIn.readBoolean()) { 
        this.creater = null;
    } else {
    this.creater = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.updater = null;
    } else {
    this.updater = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.version = null;
    } else {
    this.version = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.action_from = null;
    } else {
    this.action_from = Text.readString(__dataIn);
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
    if (null == this.action_content) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, action_content);
    }
    if (null == this.action_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.action_type);
    }
    if (null == this.terminal) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, terminal);
    }
    if (null == this.ip) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ip);
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
    if (null == this.creater) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.creater);
    }
    if (null == this.updater) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.updater);
    }
    if (null == this.version) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.version);
    }
    if (null == this.action_from) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, action_from);
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
    if (null == this.action_content) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, action_content);
    }
    if (null == this.action_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.action_type);
    }
    if (null == this.terminal) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, terminal);
    }
    if (null == this.ip) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ip);
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
    if (null == this.creater) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.creater);
    }
    if (null == this.updater) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.updater);
    }
    if (null == this.version) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.version);
    }
    if (null == this.action_from) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, action_from);
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
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(action_content==null?"\\N":action_content, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(action_type==null?"\\N":"" + action_type, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(terminal==null?"\\N":terminal, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(ip==null?"\\N":ip, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"\\N":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"\\N":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(creater==null?"\\N":"" + creater, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(updater==null?"\\N":"" + updater, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"\\N":"" + version, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(action_from==null?"\\N":action_from, delimiters));
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
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(action_content==null?"\\N":action_content, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(action_type==null?"\\N":"" + action_type, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(terminal==null?"\\N":terminal, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(ip==null?"\\N":ip, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"\\N":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"\\N":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(creater==null?"\\N":"" + creater, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(updater==null?"\\N":"" + updater, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"\\N":"" + version, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(action_from==null?"\\N":action_from, delimiters));
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
    if (__cur_str.equals("null")) { this.action_content = null; } else {
      this.action_content = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.action_type = null; } else {
      this.action_type = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.terminal = null; } else {
      this.terminal = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.ip = null; } else {
      this.ip = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.update_time = null; } else {
      this.update_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.creater = null; } else {
      this.creater = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.updater = null; } else {
      this.updater = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.version = null; } else {
      this.version = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.action_from = null; } else {
      this.action_from = __cur_str;
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
    if (__cur_str.equals("null")) { this.action_content = null; } else {
      this.action_content = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.action_type = null; } else {
      this.action_type = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.terminal = null; } else {
      this.terminal = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.ip = null; } else {
      this.ip = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.update_time = null; } else {
      this.update_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.creater = null; } else {
      this.creater = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.updater = null; } else {
      this.updater = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.version = null; } else {
      this.version = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.action_from = null; } else {
      this.action_from = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    user_action_log o = (user_action_log) super.clone();
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    return o;
  }

  public void clone0(user_action_log o) throws CloneNotSupportedException {
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("action_content", this.action_content);
    __sqoop$field_map.put("action_type", this.action_type);
    __sqoop$field_map.put("terminal", this.terminal);
    __sqoop$field_map.put("ip", this.ip);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("creater", this.creater);
    __sqoop$field_map.put("updater", this.updater);
    __sqoop$field_map.put("version", this.version);
    __sqoop$field_map.put("action_from", this.action_from);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("action_content", this.action_content);
    __sqoop$field_map.put("action_type", this.action_type);
    __sqoop$field_map.put("terminal", this.terminal);
    __sqoop$field_map.put("ip", this.ip);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("creater", this.creater);
    __sqoop$field_map.put("updater", this.updater);
    __sqoop$field_map.put("version", this.version);
    __sqoop$field_map.put("action_from", this.action_from);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("id".equals(__fieldName)) {
      this.id = (Long) __fieldVal;
    }
    else    if ("user_id".equals(__fieldName)) {
      this.user_id = (Long) __fieldVal;
    }
    else    if ("action_content".equals(__fieldName)) {
      this.action_content = (String) __fieldVal;
    }
    else    if ("action_type".equals(__fieldName)) {
      this.action_type = (Integer) __fieldVal;
    }
    else    if ("terminal".equals(__fieldName)) {
      this.terminal = (String) __fieldVal;
    }
    else    if ("ip".equals(__fieldName)) {
      this.ip = (String) __fieldVal;
    }
    else    if ("create_time".equals(__fieldName)) {
      this.create_time = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("update_time".equals(__fieldName)) {
      this.update_time = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("creater".equals(__fieldName)) {
      this.creater = (Long) __fieldVal;
    }
    else    if ("updater".equals(__fieldName)) {
      this.updater = (Long) __fieldVal;
    }
    else    if ("version".equals(__fieldName)) {
      this.version = (Integer) __fieldVal;
    }
    else    if ("action_from".equals(__fieldName)) {
      this.action_from = (String) __fieldVal;
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
    else    if ("action_content".equals(__fieldName)) {
      this.action_content = (String) __fieldVal;
      return true;
    }
    else    if ("action_type".equals(__fieldName)) {
      this.action_type = (Integer) __fieldVal;
      return true;
    }
    else    if ("terminal".equals(__fieldName)) {
      this.terminal = (String) __fieldVal;
      return true;
    }
    else    if ("ip".equals(__fieldName)) {
      this.ip = (String) __fieldVal;
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
    else    if ("creater".equals(__fieldName)) {
      this.creater = (Long) __fieldVal;
      return true;
    }
    else    if ("updater".equals(__fieldName)) {
      this.updater = (Long) __fieldVal;
      return true;
    }
    else    if ("version".equals(__fieldName)) {
      this.version = (Integer) __fieldVal;
      return true;
    }
    else    if ("action_from".equals(__fieldName)) {
      this.action_from = (String) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
