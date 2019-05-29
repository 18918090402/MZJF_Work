// ORM class for table 'pengyuan_recharge_log'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Thu Aug 03 11:35:26 CST 2017
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

public class pengyuan_recharge_log extends SqoopRecord  implements DBWritable, Writable {
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
  public pengyuan_recharge_log with_id(Long id) {
    this.id = id;
    return this;
  }
  private String query_id;
  public String get_query_id() {
    return query_id;
  }
  public void set_query_id(String query_id) {
    this.query_id = query_id;
  }
  public pengyuan_recharge_log with_query_id(String query_id) {
    this.query_id = query_id;
    return this;
  }
  private String name;
  public String get_name() {
    return name;
  }
  public void set_name(String name) {
    this.name = name;
  }
  public pengyuan_recharge_log with_name(String name) {
    this.name = name;
    return this;
  }
  private String idnum;
  public String get_idnum() {
    return idnum;
  }
  public void set_idnum(String idnum) {
    this.idnum = idnum;
  }
  public pengyuan_recharge_log with_idnum(String idnum) {
    this.idnum = idnum;
    return this;
  }
  private String ref_id;
  public String get_ref_id() {
    return ref_id;
  }
  public void set_ref_id(String ref_id) {
    this.ref_id = ref_id;
  }
  public pengyuan_recharge_log with_ref_id(String ref_id) {
    this.ref_id = ref_id;
    return this;
  }
  private String subreport_ids;
  public String get_subreport_ids() {
    return subreport_ids;
  }
  public void set_subreport_ids(String subreport_ids) {
    this.subreport_ids = subreport_ids;
  }
  public pengyuan_recharge_log with_subreport_ids(String subreport_ids) {
    this.subreport_ids = subreport_ids;
    return this;
  }
  private String level_no;
  public String get_level_no() {
    return level_no;
  }
  public void set_level_no(String level_no) {
    this.level_no = level_no;
  }
  public pengyuan_recharge_log with_level_no(String level_no) {
    this.level_no = level_no;
    return this;
  }
  private String graduate_time;
  public String get_graduate_time() {
    return graduate_time;
  }
  public void set_graduate_time(String graduate_time) {
    this.graduate_time = graduate_time;
  }
  public pengyuan_recharge_log with_graduate_time(String graduate_time) {
    this.graduate_time = graduate_time;
    return this;
  }
  private String college_level;
  public String get_college_level() {
    return college_level;
  }
  public void set_college_level(String college_level) {
    this.college_level = college_level;
  }
  public pengyuan_recharge_log with_college_level(String college_level) {
    this.college_level = college_level;
    return this;
  }
  private String college;
  public String get_college() {
    return college;
  }
  public void set_college(String college) {
    this.college = college;
  }
  public pengyuan_recharge_log with_college(String college) {
    this.college = college;
    return this;
  }
  private String start_time;
  public String get_start_time() {
    return start_time;
  }
  public void set_start_time(String start_time) {
    this.start_time = start_time;
  }
  public pengyuan_recharge_log with_start_time(String start_time) {
    this.start_time = start_time;
    return this;
  }
  private String telephone;
  public String get_telephone() {
    return telephone;
  }
  public void set_telephone(String telephone) {
    this.telephone = telephone;
  }
  public pengyuan_recharge_log with_telephone(String telephone) {
    this.telephone = telephone;
    return this;
  }
  private String org_code;
  public String get_org_code() {
    return org_code;
  }
  public void set_org_code(String org_code) {
    this.org_code = org_code;
  }
  public pengyuan_recharge_log with_org_code(String org_code) {
    this.org_code = org_code;
    return this;
  }
  private String corp_name;
  public String get_corp_name() {
    return corp_name;
  }
  public void set_corp_name(String corp_name) {
    this.corp_name = corp_name;
  }
  public pengyuan_recharge_log with_corp_name(String corp_name) {
    this.corp_name = corp_name;
    return this;
  }
  private String request;
  public String get_request() {
    return request;
  }
  public void set_request(String request) {
    this.request = request;
  }
  public pengyuan_recharge_log with_request(String request) {
    this.request = request;
    return this;
  }
  private String response;
  public String get_response() {
    return response;
  }
  public void set_response(String response) {
    this.response = response;
  }
  public pengyuan_recharge_log with_response(String response) {
    this.response = response;
    return this;
  }
  private Integer status;
  public Integer get_status() {
    return status;
  }
  public void set_status(Integer status) {
    this.status = status;
  }
  public pengyuan_recharge_log with_status(Integer status) {
    this.status = status;
    return this;
  }
  private java.sql.Timestamp create_time;
  public java.sql.Timestamp get_create_time() {
    return create_time;
  }
  public void set_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
  }
  public pengyuan_recharge_log with_create_time(java.sql.Timestamp create_time) {
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
  public pengyuan_recharge_log with_update_time(java.sql.Timestamp update_time) {
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
  public pengyuan_recharge_log with_creater(Long creater) {
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
  public pengyuan_recharge_log with_updater(Long updater) {
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
  public pengyuan_recharge_log with_version(Integer version) {
    this.version = version;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof pengyuan_recharge_log)) {
      return false;
    }
    pengyuan_recharge_log that = (pengyuan_recharge_log) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.query_id == null ? that.query_id == null : this.query_id.equals(that.query_id));
    equal = equal && (this.name == null ? that.name == null : this.name.equals(that.name));
    equal = equal && (this.idnum == null ? that.idnum == null : this.idnum.equals(that.idnum));
    equal = equal && (this.ref_id == null ? that.ref_id == null : this.ref_id.equals(that.ref_id));
    equal = equal && (this.subreport_ids == null ? that.subreport_ids == null : this.subreport_ids.equals(that.subreport_ids));
    equal = equal && (this.level_no == null ? that.level_no == null : this.level_no.equals(that.level_no));
    equal = equal && (this.graduate_time == null ? that.graduate_time == null : this.graduate_time.equals(that.graduate_time));
    equal = equal && (this.college_level == null ? that.college_level == null : this.college_level.equals(that.college_level));
    equal = equal && (this.college == null ? that.college == null : this.college.equals(that.college));
    equal = equal && (this.start_time == null ? that.start_time == null : this.start_time.equals(that.start_time));
    equal = equal && (this.telephone == null ? that.telephone == null : this.telephone.equals(that.telephone));
    equal = equal && (this.org_code == null ? that.org_code == null : this.org_code.equals(that.org_code));
    equal = equal && (this.corp_name == null ? that.corp_name == null : this.corp_name.equals(that.corp_name));
    equal = equal && (this.request == null ? that.request == null : this.request.equals(that.request));
    equal = equal && (this.response == null ? that.response == null : this.response.equals(that.response));
    equal = equal && (this.status == null ? that.status == null : this.status.equals(that.status));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.creater == null ? that.creater == null : this.creater.equals(that.creater));
    equal = equal && (this.updater == null ? that.updater == null : this.updater.equals(that.updater));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof pengyuan_recharge_log)) {
      return false;
    }
    pengyuan_recharge_log that = (pengyuan_recharge_log) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.query_id == null ? that.query_id == null : this.query_id.equals(that.query_id));
    equal = equal && (this.name == null ? that.name == null : this.name.equals(that.name));
    equal = equal && (this.idnum == null ? that.idnum == null : this.idnum.equals(that.idnum));
    equal = equal && (this.ref_id == null ? that.ref_id == null : this.ref_id.equals(that.ref_id));
    equal = equal && (this.subreport_ids == null ? that.subreport_ids == null : this.subreport_ids.equals(that.subreport_ids));
    equal = equal && (this.level_no == null ? that.level_no == null : this.level_no.equals(that.level_no));
    equal = equal && (this.graduate_time == null ? that.graduate_time == null : this.graduate_time.equals(that.graduate_time));
    equal = equal && (this.college_level == null ? that.college_level == null : this.college_level.equals(that.college_level));
    equal = equal && (this.college == null ? that.college == null : this.college.equals(that.college));
    equal = equal && (this.start_time == null ? that.start_time == null : this.start_time.equals(that.start_time));
    equal = equal && (this.telephone == null ? that.telephone == null : this.telephone.equals(that.telephone));
    equal = equal && (this.org_code == null ? that.org_code == null : this.org_code.equals(that.org_code));
    equal = equal && (this.corp_name == null ? that.corp_name == null : this.corp_name.equals(that.corp_name));
    equal = equal && (this.request == null ? that.request == null : this.request.equals(that.request));
    equal = equal && (this.response == null ? that.response == null : this.response.equals(that.response));
    equal = equal && (this.status == null ? that.status == null : this.status.equals(that.status));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.creater == null ? that.creater == null : this.creater.equals(that.creater));
    equal = equal && (this.updater == null ? that.updater == null : this.updater.equals(that.updater));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.query_id = JdbcWritableBridge.readString(2, __dbResults);
    this.name = JdbcWritableBridge.readString(3, __dbResults);
    this.idnum = JdbcWritableBridge.readString(4, __dbResults);
    this.ref_id = JdbcWritableBridge.readString(5, __dbResults);
    this.subreport_ids = JdbcWritableBridge.readString(6, __dbResults);
    this.level_no = JdbcWritableBridge.readString(7, __dbResults);
    this.graduate_time = JdbcWritableBridge.readString(8, __dbResults);
    this.college_level = JdbcWritableBridge.readString(9, __dbResults);
    this.college = JdbcWritableBridge.readString(10, __dbResults);
    this.start_time = JdbcWritableBridge.readString(11, __dbResults);
    this.telephone = JdbcWritableBridge.readString(12, __dbResults);
    this.org_code = JdbcWritableBridge.readString(13, __dbResults);
    this.corp_name = JdbcWritableBridge.readString(14, __dbResults);
    this.request = JdbcWritableBridge.readString(15, __dbResults);
    this.response = JdbcWritableBridge.readString(16, __dbResults);
    this.status = JdbcWritableBridge.readInteger(17, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(18, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(19, __dbResults);
    this.creater = JdbcWritableBridge.readLong(20, __dbResults);
    this.updater = JdbcWritableBridge.readLong(21, __dbResults);
    this.version = JdbcWritableBridge.readInteger(22, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.query_id = JdbcWritableBridge.readString(2, __dbResults);
    this.name = JdbcWritableBridge.readString(3, __dbResults);
    this.idnum = JdbcWritableBridge.readString(4, __dbResults);
    this.ref_id = JdbcWritableBridge.readString(5, __dbResults);
    this.subreport_ids = JdbcWritableBridge.readString(6, __dbResults);
    this.level_no = JdbcWritableBridge.readString(7, __dbResults);
    this.graduate_time = JdbcWritableBridge.readString(8, __dbResults);
    this.college_level = JdbcWritableBridge.readString(9, __dbResults);
    this.college = JdbcWritableBridge.readString(10, __dbResults);
    this.start_time = JdbcWritableBridge.readString(11, __dbResults);
    this.telephone = JdbcWritableBridge.readString(12, __dbResults);
    this.org_code = JdbcWritableBridge.readString(13, __dbResults);
    this.corp_name = JdbcWritableBridge.readString(14, __dbResults);
    this.request = JdbcWritableBridge.readString(15, __dbResults);
    this.response = JdbcWritableBridge.readString(16, __dbResults);
    this.status = JdbcWritableBridge.readInteger(17, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(18, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(19, __dbResults);
    this.creater = JdbcWritableBridge.readLong(20, __dbResults);
    this.updater = JdbcWritableBridge.readLong(21, __dbResults);
    this.version = JdbcWritableBridge.readInteger(22, __dbResults);
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
    JdbcWritableBridge.writeString(query_id, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(name, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(idnum, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(ref_id, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(subreport_ids, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(level_no, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(graduate_time, 8 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(college_level, 9 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(college, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(start_time, 11 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(telephone, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(org_code, 13 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(corp_name, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(request, 15 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(response, 16 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeInteger(status, 17 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 18 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 19 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeLong(creater, 20 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(updater, 21 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 22 + __off, 4, __dbStmt);
    return 22;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(query_id, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(name, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(idnum, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(ref_id, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(subreport_ids, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(level_no, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(graduate_time, 8 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(college_level, 9 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(college, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(start_time, 11 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(telephone, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(org_code, 13 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(corp_name, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(request, 15 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(response, 16 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeInteger(status, 17 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 18 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 19 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeLong(creater, 20 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(updater, 21 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 22 + __off, 4, __dbStmt);
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
        this.query_id = null;
    } else {
    this.query_id = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.name = null;
    } else {
    this.name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.idnum = null;
    } else {
    this.idnum = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ref_id = null;
    } else {
    this.ref_id = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.subreport_ids = null;
    } else {
    this.subreport_ids = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.level_no = null;
    } else {
    this.level_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.graduate_time = null;
    } else {
    this.graduate_time = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.college_level = null;
    } else {
    this.college_level = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.college = null;
    } else {
    this.college = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.start_time = null;
    } else {
    this.start_time = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.telephone = null;
    } else {
    this.telephone = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.org_code = null;
    } else {
    this.org_code = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.corp_name = null;
    } else {
    this.corp_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.request = null;
    } else {
    this.request = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.response = null;
    } else {
    this.response = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.status = null;
    } else {
    this.status = Integer.valueOf(__dataIn.readInt());
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
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.id);
    }
    if (null == this.query_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, query_id);
    }
    if (null == this.name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, name);
    }
    if (null == this.idnum) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, idnum);
    }
    if (null == this.ref_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ref_id);
    }
    if (null == this.subreport_ids) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, subreport_ids);
    }
    if (null == this.level_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, level_no);
    }
    if (null == this.graduate_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, graduate_time);
    }
    if (null == this.college_level) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, college_level);
    }
    if (null == this.college) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, college);
    }
    if (null == this.start_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, start_time);
    }
    if (null == this.telephone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, telephone);
    }
    if (null == this.org_code) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, org_code);
    }
    if (null == this.corp_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, corp_name);
    }
    if (null == this.request) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, request);
    }
    if (null == this.response) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, response);
    }
    if (null == this.status) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.status);
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
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.id);
    }
    if (null == this.query_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, query_id);
    }
    if (null == this.name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, name);
    }
    if (null == this.idnum) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, idnum);
    }
    if (null == this.ref_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ref_id);
    }
    if (null == this.subreport_ids) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, subreport_ids);
    }
    if (null == this.level_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, level_no);
    }
    if (null == this.graduate_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, graduate_time);
    }
    if (null == this.college_level) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, college_level);
    }
    if (null == this.college) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, college);
    }
    if (null == this.start_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, start_time);
    }
    if (null == this.telephone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, telephone);
    }
    if (null == this.org_code) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, org_code);
    }
    if (null == this.corp_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, corp_name);
    }
    if (null == this.request) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, request);
    }
    if (null == this.response) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, response);
    }
    if (null == this.status) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.status);
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
    __sb.append(FieldFormatter.escapeAndEnclose(query_id==null?"null":query_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(name==null?"null":name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(idnum==null?"null":idnum, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ref_id==null?"null":ref_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(subreport_ids==null?"null":subreport_ids, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(level_no==null?"null":level_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(graduate_time==null?"null":graduate_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(college_level==null?"null":college_level, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(college==null?"null":college, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(start_time==null?"null":start_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(telephone==null?"null":telephone, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(org_code==null?"null":org_code, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(corp_name==null?"null":corp_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(request==null?"null":request, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(response==null?"null":response, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(status==null?"null":"" + status, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"null":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"null":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(creater==null?"null":"" + creater, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(updater==null?"null":"" + updater, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"null":"" + version, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(id==null?"null":"" + id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(query_id==null?"null":query_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(name==null?"null":name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(idnum==null?"null":idnum, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ref_id==null?"null":ref_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(subreport_ids==null?"null":subreport_ids, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(level_no==null?"null":level_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(graduate_time==null?"null":graduate_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(college_level==null?"null":college_level, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(college==null?"null":college, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(start_time==null?"null":start_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(telephone==null?"null":telephone, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(org_code==null?"null":org_code, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(corp_name==null?"null":corp_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(request==null?"null":request, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(response==null?"null":response, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(status==null?"null":"" + status, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"null":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"null":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(creater==null?"null":"" + creater, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(updater==null?"null":"" + updater, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"null":"" + version, delimiters));
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
    if (__cur_str.equals("\\N")) { this.query_id = null; } else {
      this.query_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.name = null; } else {
      this.name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.idnum = null; } else {
      this.idnum = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.ref_id = null; } else {
      this.ref_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.subreport_ids = null; } else {
      this.subreport_ids = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.level_no = null; } else {
      this.level_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.graduate_time = null; } else {
      this.graduate_time = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.college_level = null; } else {
      this.college_level = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.college = null; } else {
      this.college = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.start_time = null; } else {
      this.start_time = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.telephone = null; } else {
      this.telephone = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.org_code = null; } else {
      this.org_code = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.corp_name = null; } else {
      this.corp_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.request = null; } else {
      this.request = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.response = null; } else {
      this.response = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.status = null; } else {
      this.status = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.update_time = null; } else {
      this.update_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.creater = null; } else {
      this.creater = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.updater = null; } else {
      this.updater = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.version = null; } else {
      this.version = Integer.valueOf(__cur_str);
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
    if (__cur_str.equals("\\N")) { this.query_id = null; } else {
      this.query_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.name = null; } else {
      this.name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.idnum = null; } else {
      this.idnum = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.ref_id = null; } else {
      this.ref_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.subreport_ids = null; } else {
      this.subreport_ids = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.level_no = null; } else {
      this.level_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.graduate_time = null; } else {
      this.graduate_time = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.college_level = null; } else {
      this.college_level = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.college = null; } else {
      this.college = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.start_time = null; } else {
      this.start_time = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.telephone = null; } else {
      this.telephone = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.org_code = null; } else {
      this.org_code = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.corp_name = null; } else {
      this.corp_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.request = null; } else {
      this.request = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.response = null; } else {
      this.response = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.status = null; } else {
      this.status = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.create_time = null; } else {
      this.create_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.update_time = null; } else {
      this.update_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.creater = null; } else {
      this.creater = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.updater = null; } else {
      this.updater = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.version = null; } else {
      this.version = Integer.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    pengyuan_recharge_log o = (pengyuan_recharge_log) super.clone();
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    return o;
  }

  public void clone0(pengyuan_recharge_log o) throws CloneNotSupportedException {
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("query_id", this.query_id);
    __sqoop$field_map.put("name", this.name);
    __sqoop$field_map.put("idnum", this.idnum);
    __sqoop$field_map.put("ref_id", this.ref_id);
    __sqoop$field_map.put("subreport_ids", this.subreport_ids);
    __sqoop$field_map.put("level_no", this.level_no);
    __sqoop$field_map.put("graduate_time", this.graduate_time);
    __sqoop$field_map.put("college_level", this.college_level);
    __sqoop$field_map.put("college", this.college);
    __sqoop$field_map.put("start_time", this.start_time);
    __sqoop$field_map.put("telephone", this.telephone);
    __sqoop$field_map.put("org_code", this.org_code);
    __sqoop$field_map.put("corp_name", this.corp_name);
    __sqoop$field_map.put("request", this.request);
    __sqoop$field_map.put("response", this.response);
    __sqoop$field_map.put("status", this.status);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("creater", this.creater);
    __sqoop$field_map.put("updater", this.updater);
    __sqoop$field_map.put("version", this.version);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("query_id", this.query_id);
    __sqoop$field_map.put("name", this.name);
    __sqoop$field_map.put("idnum", this.idnum);
    __sqoop$field_map.put("ref_id", this.ref_id);
    __sqoop$field_map.put("subreport_ids", this.subreport_ids);
    __sqoop$field_map.put("level_no", this.level_no);
    __sqoop$field_map.put("graduate_time", this.graduate_time);
    __sqoop$field_map.put("college_level", this.college_level);
    __sqoop$field_map.put("college", this.college);
    __sqoop$field_map.put("start_time", this.start_time);
    __sqoop$field_map.put("telephone", this.telephone);
    __sqoop$field_map.put("org_code", this.org_code);
    __sqoop$field_map.put("corp_name", this.corp_name);
    __sqoop$field_map.put("request", this.request);
    __sqoop$field_map.put("response", this.response);
    __sqoop$field_map.put("status", this.status);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("creater", this.creater);
    __sqoop$field_map.put("updater", this.updater);
    __sqoop$field_map.put("version", this.version);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("id".equals(__fieldName)) {
      this.id = (Long) __fieldVal;
    }
    else    if ("query_id".equals(__fieldName)) {
      this.query_id = (String) __fieldVal;
    }
    else    if ("name".equals(__fieldName)) {
      this.name = (String) __fieldVal;
    }
    else    if ("idnum".equals(__fieldName)) {
      this.idnum = (String) __fieldVal;
    }
    else    if ("ref_id".equals(__fieldName)) {
      this.ref_id = (String) __fieldVal;
    }
    else    if ("subreport_ids".equals(__fieldName)) {
      this.subreport_ids = (String) __fieldVal;
    }
    else    if ("level_no".equals(__fieldName)) {
      this.level_no = (String) __fieldVal;
    }
    else    if ("graduate_time".equals(__fieldName)) {
      this.graduate_time = (String) __fieldVal;
    }
    else    if ("college_level".equals(__fieldName)) {
      this.college_level = (String) __fieldVal;
    }
    else    if ("college".equals(__fieldName)) {
      this.college = (String) __fieldVal;
    }
    else    if ("start_time".equals(__fieldName)) {
      this.start_time = (String) __fieldVal;
    }
    else    if ("telephone".equals(__fieldName)) {
      this.telephone = (String) __fieldVal;
    }
    else    if ("org_code".equals(__fieldName)) {
      this.org_code = (String) __fieldVal;
    }
    else    if ("corp_name".equals(__fieldName)) {
      this.corp_name = (String) __fieldVal;
    }
    else    if ("request".equals(__fieldName)) {
      this.request = (String) __fieldVal;
    }
    else    if ("response".equals(__fieldName)) {
      this.response = (String) __fieldVal;
    }
    else    if ("status".equals(__fieldName)) {
      this.status = (Integer) __fieldVal;
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
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
  public boolean setField0(String __fieldName, Object __fieldVal) {
    if ("id".equals(__fieldName)) {
      this.id = (Long) __fieldVal;
      return true;
    }
    else    if ("query_id".equals(__fieldName)) {
      this.query_id = (String) __fieldVal;
      return true;
    }
    else    if ("name".equals(__fieldName)) {
      this.name = (String) __fieldVal;
      return true;
    }
    else    if ("idnum".equals(__fieldName)) {
      this.idnum = (String) __fieldVal;
      return true;
    }
    else    if ("ref_id".equals(__fieldName)) {
      this.ref_id = (String) __fieldVal;
      return true;
    }
    else    if ("subreport_ids".equals(__fieldName)) {
      this.subreport_ids = (String) __fieldVal;
      return true;
    }
    else    if ("level_no".equals(__fieldName)) {
      this.level_no = (String) __fieldVal;
      return true;
    }
    else    if ("graduate_time".equals(__fieldName)) {
      this.graduate_time = (String) __fieldVal;
      return true;
    }
    else    if ("college_level".equals(__fieldName)) {
      this.college_level = (String) __fieldVal;
      return true;
    }
    else    if ("college".equals(__fieldName)) {
      this.college = (String) __fieldVal;
      return true;
    }
    else    if ("start_time".equals(__fieldName)) {
      this.start_time = (String) __fieldVal;
      return true;
    }
    else    if ("telephone".equals(__fieldName)) {
      this.telephone = (String) __fieldVal;
      return true;
    }
    else    if ("org_code".equals(__fieldName)) {
      this.org_code = (String) __fieldVal;
      return true;
    }
    else    if ("corp_name".equals(__fieldName)) {
      this.corp_name = (String) __fieldVal;
      return true;
    }
    else    if ("request".equals(__fieldName)) {
      this.request = (String) __fieldVal;
      return true;
    }
    else    if ("response".equals(__fieldName)) {
      this.response = (String) __fieldVal;
      return true;
    }
    else    if ("status".equals(__fieldName)) {
      this.status = (Integer) __fieldVal;
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
    else {
      return false;    }
  }
}
