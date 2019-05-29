// ORM class for table 'acc_depository_batch_create_ebank_result'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Mon May 22 14:58:39 CST 2017
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

public class acc_depository_batch_create_ebank_result extends SqoopRecord  implements DBWritable, Writable {
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
  public acc_depository_batch_create_ebank_result with_id(Long id) {
    this.id = id;
    return this;
  }
  private String card_nbr;
  public String get_card_nbr() {
    return card_nbr;
  }
  public void set_card_nbr(String card_nbr) {
    this.card_nbr = card_nbr;
  }
  public acc_depository_batch_create_ebank_result with_card_nbr(String card_nbr) {
    this.card_nbr = card_nbr;
    return this;
  }
  private String id_no;
  public String get_id_no() {
    return id_no;
  }
  public void set_id_no(String id_no) {
    this.id_no = id_no;
  }
  public acc_depository_batch_create_ebank_result with_id_no(String id_no) {
    this.id_no = id_no;
    return this;
  }
  private String id_type;
  public String get_id_type() {
    return id_type;
  }
  public void set_id_type(String id_type) {
    this.id_type = id_type;
  }
  public acc_depository_batch_create_ebank_result with_id_type(String id_type) {
    this.id_type = id_type;
    return this;
  }
  private String flag;
  public String get_flag() {
    return flag;
  }
  public void set_flag(String flag) {
    this.flag = flag;
  }
  public acc_depository_batch_create_ebank_result with_flag(String flag) {
    this.flag = flag;
    return this;
  }
  private String err_code;
  public String get_err_code() {
    return err_code;
  }
  public void set_err_code(String err_code) {
    this.err_code = err_code;
  }
  public acc_depository_batch_create_ebank_result with_err_code(String err_code) {
    this.err_code = err_code;
    return this;
  }
  private String name;
  public String get_name() {
    return name;
  }
  public void set_name(String name) {
    this.name = name;
  }
  public acc_depository_batch_create_ebank_result with_name(String name) {
    this.name = name;
    return this;
  }
  private String acc_type;
  public String get_acc_type() {
    return acc_type;
  }
  public void set_acc_type(String acc_type) {
    this.acc_type = acc_type;
  }
  public acc_depository_batch_create_ebank_result with_acc_type(String acc_type) {
    this.acc_type = acc_type;
    return this;
  }
  private String app_id;
  public String get_app_id() {
    return app_id;
  }
  public void set_app_id(String app_id) {
    this.app_id = app_id;
  }
  public acc_depository_batch_create_ebank_result with_app_id(String app_id) {
    this.app_id = app_id;
    return this;
  }
  private String mo_phone;
  public String get_mo_phone() {
    return mo_phone;
  }
  public void set_mo_phone(String mo_phone) {
    this.mo_phone = mo_phone;
  }
  public acc_depository_batch_create_ebank_result with_mo_phone(String mo_phone) {
    this.mo_phone = mo_phone;
    return this;
  }
  private String info;
  public String get_info() {
    return info;
  }
  public void set_info(String info) {
    this.info = info;
  }
  public acc_depository_batch_create_ebank_result with_info(String info) {
    this.info = info;
    return this;
  }
  private String revers;
  public String get_revers() {
    return revers;
  }
  public void set_revers(String revers) {
    this.revers = revers;
  }
  public acc_depository_batch_create_ebank_result with_revers(String revers) {
    this.revers = revers;
    return this;
  }
  private String status;
  public String get_status() {
    return status;
  }
  public void set_status(String status) {
    this.status = status;
  }
  public acc_depository_batch_create_ebank_result with_status(String status) {
    this.status = status;
    return this;
  }
  private String error_code;
  public String get_error_code() {
    return error_code;
  }
  public void set_error_code(String error_code) {
    this.error_code = error_code;
  }
  public acc_depository_batch_create_ebank_result with_error_code(String error_code) {
    this.error_code = error_code;
    return this;
  }
  private String error_message;
  public String get_error_message() {
    return error_message;
  }
  public void set_error_message(String error_message) {
    this.error_message = error_message;
  }
  public acc_depository_batch_create_ebank_result with_error_message(String error_message) {
    this.error_message = error_message;
    return this;
  }
  private java.sql.Timestamp create_time;
  public java.sql.Timestamp get_create_time() {
    return create_time;
  }
  public void set_create_time(java.sql.Timestamp create_time) {
    this.create_time = create_time;
  }
  public acc_depository_batch_create_ebank_result with_create_time(java.sql.Timestamp create_time) {
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
  public acc_depository_batch_create_ebank_result with_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
    return this;
  }
  private Integer version;
  public Integer get_version() {
    return version;
  }
  public void set_version(Integer version) {
    this.version = version;
  }
  public acc_depository_batch_create_ebank_result with_version(Integer version) {
    this.version = version;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof acc_depository_batch_create_ebank_result)) {
      return false;
    }
    acc_depository_batch_create_ebank_result that = (acc_depository_batch_create_ebank_result) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.card_nbr == null ? that.card_nbr == null : this.card_nbr.equals(that.card_nbr));
    equal = equal && (this.id_no == null ? that.id_no == null : this.id_no.equals(that.id_no));
    equal = equal && (this.id_type == null ? that.id_type == null : this.id_type.equals(that.id_type));
    equal = equal && (this.flag == null ? that.flag == null : this.flag.equals(that.flag));
    equal = equal && (this.err_code == null ? that.err_code == null : this.err_code.equals(that.err_code));
    equal = equal && (this.name == null ? that.name == null : this.name.equals(that.name));
    equal = equal && (this.acc_type == null ? that.acc_type == null : this.acc_type.equals(that.acc_type));
    equal = equal && (this.app_id == null ? that.app_id == null : this.app_id.equals(that.app_id));
    equal = equal && (this.mo_phone == null ? that.mo_phone == null : this.mo_phone.equals(that.mo_phone));
    equal = equal && (this.info == null ? that.info == null : this.info.equals(that.info));
    equal = equal && (this.revers == null ? that.revers == null : this.revers.equals(that.revers));
    equal = equal && (this.status == null ? that.status == null : this.status.equals(that.status));
    equal = equal && (this.error_code == null ? that.error_code == null : this.error_code.equals(that.error_code));
    equal = equal && (this.error_message == null ? that.error_message == null : this.error_message.equals(that.error_message));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof acc_depository_batch_create_ebank_result)) {
      return false;
    }
    acc_depository_batch_create_ebank_result that = (acc_depository_batch_create_ebank_result) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.card_nbr == null ? that.card_nbr == null : this.card_nbr.equals(that.card_nbr));
    equal = equal && (this.id_no == null ? that.id_no == null : this.id_no.equals(that.id_no));
    equal = equal && (this.id_type == null ? that.id_type == null : this.id_type.equals(that.id_type));
    equal = equal && (this.flag == null ? that.flag == null : this.flag.equals(that.flag));
    equal = equal && (this.err_code == null ? that.err_code == null : this.err_code.equals(that.err_code));
    equal = equal && (this.name == null ? that.name == null : this.name.equals(that.name));
    equal = equal && (this.acc_type == null ? that.acc_type == null : this.acc_type.equals(that.acc_type));
    equal = equal && (this.app_id == null ? that.app_id == null : this.app_id.equals(that.app_id));
    equal = equal && (this.mo_phone == null ? that.mo_phone == null : this.mo_phone.equals(that.mo_phone));
    equal = equal && (this.info == null ? that.info == null : this.info.equals(that.info));
    equal = equal && (this.revers == null ? that.revers == null : this.revers.equals(that.revers));
    equal = equal && (this.status == null ? that.status == null : this.status.equals(that.status));
    equal = equal && (this.error_code == null ? that.error_code == null : this.error_code.equals(that.error_code));
    equal = equal && (this.error_message == null ? that.error_message == null : this.error_message.equals(that.error_message));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.card_nbr = JdbcWritableBridge.readString(2, __dbResults);
    this.id_no = JdbcWritableBridge.readString(3, __dbResults);
    this.id_type = JdbcWritableBridge.readString(4, __dbResults);
    this.flag = JdbcWritableBridge.readString(5, __dbResults);
    this.err_code = JdbcWritableBridge.readString(6, __dbResults);
    this.name = JdbcWritableBridge.readString(7, __dbResults);
    this.acc_type = JdbcWritableBridge.readString(8, __dbResults);
    this.app_id = JdbcWritableBridge.readString(9, __dbResults);
    this.mo_phone = JdbcWritableBridge.readString(10, __dbResults);
    this.info = JdbcWritableBridge.readString(11, __dbResults);
    this.revers = JdbcWritableBridge.readString(12, __dbResults);
    this.status = JdbcWritableBridge.readString(13, __dbResults);
    this.error_code = JdbcWritableBridge.readString(14, __dbResults);
    this.error_message = JdbcWritableBridge.readString(15, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(16, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(17, __dbResults);
    this.version = JdbcWritableBridge.readInteger(18, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.card_nbr = JdbcWritableBridge.readString(2, __dbResults);
    this.id_no = JdbcWritableBridge.readString(3, __dbResults);
    this.id_type = JdbcWritableBridge.readString(4, __dbResults);
    this.flag = JdbcWritableBridge.readString(5, __dbResults);
    this.err_code = JdbcWritableBridge.readString(6, __dbResults);
    this.name = JdbcWritableBridge.readString(7, __dbResults);
    this.acc_type = JdbcWritableBridge.readString(8, __dbResults);
    this.app_id = JdbcWritableBridge.readString(9, __dbResults);
    this.mo_phone = JdbcWritableBridge.readString(10, __dbResults);
    this.info = JdbcWritableBridge.readString(11, __dbResults);
    this.revers = JdbcWritableBridge.readString(12, __dbResults);
    this.status = JdbcWritableBridge.readString(13, __dbResults);
    this.error_code = JdbcWritableBridge.readString(14, __dbResults);
    this.error_message = JdbcWritableBridge.readString(15, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(16, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(17, __dbResults);
    this.version = JdbcWritableBridge.readInteger(18, __dbResults);
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
    JdbcWritableBridge.writeString(card_nbr, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(id_no, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(id_type, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(flag, 5 + __off, 1, __dbStmt);
    JdbcWritableBridge.writeString(err_code, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(name, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(acc_type, 8 + __off, 1, __dbStmt);
    JdbcWritableBridge.writeString(app_id, 9 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(mo_phone, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(info, 11 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(revers, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(status, 13 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(error_code, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(error_message, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 16 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 17 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 18 + __off, 4, __dbStmt);
    return 18;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(card_nbr, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(id_no, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(id_type, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(flag, 5 + __off, 1, __dbStmt);
    JdbcWritableBridge.writeString(err_code, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(name, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(acc_type, 8 + __off, 1, __dbStmt);
    JdbcWritableBridge.writeString(app_id, 9 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(mo_phone, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(info, 11 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(revers, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(status, 13 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(error_code, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(error_message, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 16 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 17 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 18 + __off, 4, __dbStmt);
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
        this.card_nbr = null;
    } else {
    this.card_nbr = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.id_no = null;
    } else {
    this.id_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.id_type = null;
    } else {
    this.id_type = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.flag = null;
    } else {
    this.flag = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.err_code = null;
    } else {
    this.err_code = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.name = null;
    } else {
    this.name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.acc_type = null;
    } else {
    this.acc_type = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.app_id = null;
    } else {
    this.app_id = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.mo_phone = null;
    } else {
    this.mo_phone = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.info = null;
    } else {
    this.info = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.revers = null;
    } else {
    this.revers = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.status = null;
    } else {
    this.status = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.error_code = null;
    } else {
    this.error_code = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.error_message = null;
    } else {
    this.error_message = Text.readString(__dataIn);
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
    if (null == this.card_nbr) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, card_nbr);
    }
    if (null == this.id_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, id_no);
    }
    if (null == this.id_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, id_type);
    }
    if (null == this.flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, flag);
    }
    if (null == this.err_code) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, err_code);
    }
    if (null == this.name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, name);
    }
    if (null == this.acc_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, acc_type);
    }
    if (null == this.app_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, app_id);
    }
    if (null == this.mo_phone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, mo_phone);
    }
    if (null == this.info) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, info);
    }
    if (null == this.revers) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, revers);
    }
    if (null == this.status) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, status);
    }
    if (null == this.error_code) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, error_code);
    }
    if (null == this.error_message) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, error_message);
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
    if (null == this.card_nbr) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, card_nbr);
    }
    if (null == this.id_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, id_no);
    }
    if (null == this.id_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, id_type);
    }
    if (null == this.flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, flag);
    }
    if (null == this.err_code) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, err_code);
    }
    if (null == this.name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, name);
    }
    if (null == this.acc_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, acc_type);
    }
    if (null == this.app_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, app_id);
    }
    if (null == this.mo_phone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, mo_phone);
    }
    if (null == this.info) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, info);
    }
    if (null == this.revers) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, revers);
    }
    if (null == this.status) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, status);
    }
    if (null == this.error_code) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, error_code);
    }
    if (null == this.error_message) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, error_message);
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
    if (null == this.version) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.version);
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
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(card_nbr==null?"\\N":card_nbr, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(id_no==null?"\\N":id_no, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(id_type==null?"\\N":id_type, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(flag==null?"\\N":flag, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(err_code==null?"\\N":err_code, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(name==null?"\\N":name, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(acc_type==null?"\\N":acc_type, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(app_id==null?"\\N":app_id, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(mo_phone==null?"\\N":mo_phone, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(info==null?"\\N":info, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(revers==null?"\\N":revers, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(status==null?"\\N":status, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(error_code==null?"\\N":error_code, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(error_message==null?"\\N":error_message, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"\\N":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"\\N":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"\\N":"" + version, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(id==null?"\\N":"" + id, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(card_nbr==null?"\\N":card_nbr, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(id_no==null?"\\N":id_no, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(id_type==null?"\\N":id_type, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(flag==null?"\\N":flag, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(err_code==null?"\\N":err_code, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(name==null?"\\N":name, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(acc_type==null?"\\N":acc_type, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(app_id==null?"\\N":app_id, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(mo_phone==null?"\\N":mo_phone, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(info==null?"\\N":info, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(revers==null?"\\N":revers, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(status==null?"\\N":status, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(error_code==null?"\\N":error_code, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(error_message==null?"\\N":error_message, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"\\N":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"\\N":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"\\N":"" + version, delimiters));
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
    if (__cur_str.equals("null")) { this.card_nbr = null; } else {
      this.card_nbr = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.id_no = null; } else {
      this.id_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.id_type = null; } else {
      this.id_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.flag = null; } else {
      this.flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.err_code = null; } else {
      this.err_code = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.name = null; } else {
      this.name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.acc_type = null; } else {
      this.acc_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.app_id = null; } else {
      this.app_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.mo_phone = null; } else {
      this.mo_phone = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.info = null; } else {
      this.info = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.revers = null; } else {
      this.revers = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.status = null; } else {
      this.status = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.error_code = null; } else {
      this.error_code = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.error_message = null; } else {
      this.error_message = __cur_str;
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
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.version = null; } else {
      this.version = Integer.valueOf(__cur_str);
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
    if (__cur_str.equals("null")) { this.card_nbr = null; } else {
      this.card_nbr = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.id_no = null; } else {
      this.id_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.id_type = null; } else {
      this.id_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.flag = null; } else {
      this.flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.err_code = null; } else {
      this.err_code = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.name = null; } else {
      this.name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.acc_type = null; } else {
      this.acc_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.app_id = null; } else {
      this.app_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.mo_phone = null; } else {
      this.mo_phone = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.info = null; } else {
      this.info = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.revers = null; } else {
      this.revers = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.status = null; } else {
      this.status = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.error_code = null; } else {
      this.error_code = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.error_message = null; } else {
      this.error_message = __cur_str;
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
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.version = null; } else {
      this.version = Integer.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    acc_depository_batch_create_ebank_result o = (acc_depository_batch_create_ebank_result) super.clone();
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    return o;
  }

  public void clone0(acc_depository_batch_create_ebank_result o) throws CloneNotSupportedException {
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("card_nbr", this.card_nbr);
    __sqoop$field_map.put("id_no", this.id_no);
    __sqoop$field_map.put("id_type", this.id_type);
    __sqoop$field_map.put("flag", this.flag);
    __sqoop$field_map.put("err_code", this.err_code);
    __sqoop$field_map.put("name", this.name);
    __sqoop$field_map.put("acc_type", this.acc_type);
    __sqoop$field_map.put("app_id", this.app_id);
    __sqoop$field_map.put("mo_phone", this.mo_phone);
    __sqoop$field_map.put("info", this.info);
    __sqoop$field_map.put("revers", this.revers);
    __sqoop$field_map.put("status", this.status);
    __sqoop$field_map.put("error_code", this.error_code);
    __sqoop$field_map.put("error_message", this.error_message);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("version", this.version);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("card_nbr", this.card_nbr);
    __sqoop$field_map.put("id_no", this.id_no);
    __sqoop$field_map.put("id_type", this.id_type);
    __sqoop$field_map.put("flag", this.flag);
    __sqoop$field_map.put("err_code", this.err_code);
    __sqoop$field_map.put("name", this.name);
    __sqoop$field_map.put("acc_type", this.acc_type);
    __sqoop$field_map.put("app_id", this.app_id);
    __sqoop$field_map.put("mo_phone", this.mo_phone);
    __sqoop$field_map.put("info", this.info);
    __sqoop$field_map.put("revers", this.revers);
    __sqoop$field_map.put("status", this.status);
    __sqoop$field_map.put("error_code", this.error_code);
    __sqoop$field_map.put("error_message", this.error_message);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("version", this.version);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("id".equals(__fieldName)) {
      this.id = (Long) __fieldVal;
    }
    else    if ("card_nbr".equals(__fieldName)) {
      this.card_nbr = (String) __fieldVal;
    }
    else    if ("id_no".equals(__fieldName)) {
      this.id_no = (String) __fieldVal;
    }
    else    if ("id_type".equals(__fieldName)) {
      this.id_type = (String) __fieldVal;
    }
    else    if ("flag".equals(__fieldName)) {
      this.flag = (String) __fieldVal;
    }
    else    if ("err_code".equals(__fieldName)) {
      this.err_code = (String) __fieldVal;
    }
    else    if ("name".equals(__fieldName)) {
      this.name = (String) __fieldVal;
    }
    else    if ("acc_type".equals(__fieldName)) {
      this.acc_type = (String) __fieldVal;
    }
    else    if ("app_id".equals(__fieldName)) {
      this.app_id = (String) __fieldVal;
    }
    else    if ("mo_phone".equals(__fieldName)) {
      this.mo_phone = (String) __fieldVal;
    }
    else    if ("info".equals(__fieldName)) {
      this.info = (String) __fieldVal;
    }
    else    if ("revers".equals(__fieldName)) {
      this.revers = (String) __fieldVal;
    }
    else    if ("status".equals(__fieldName)) {
      this.status = (String) __fieldVal;
    }
    else    if ("error_code".equals(__fieldName)) {
      this.error_code = (String) __fieldVal;
    }
    else    if ("error_message".equals(__fieldName)) {
      this.error_message = (String) __fieldVal;
    }
    else    if ("create_time".equals(__fieldName)) {
      this.create_time = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("update_time".equals(__fieldName)) {
      this.update_time = (java.sql.Timestamp) __fieldVal;
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
    else    if ("card_nbr".equals(__fieldName)) {
      this.card_nbr = (String) __fieldVal;
      return true;
    }
    else    if ("id_no".equals(__fieldName)) {
      this.id_no = (String) __fieldVal;
      return true;
    }
    else    if ("id_type".equals(__fieldName)) {
      this.id_type = (String) __fieldVal;
      return true;
    }
    else    if ("flag".equals(__fieldName)) {
      this.flag = (String) __fieldVal;
      return true;
    }
    else    if ("err_code".equals(__fieldName)) {
      this.err_code = (String) __fieldVal;
      return true;
    }
    else    if ("name".equals(__fieldName)) {
      this.name = (String) __fieldVal;
      return true;
    }
    else    if ("acc_type".equals(__fieldName)) {
      this.acc_type = (String) __fieldVal;
      return true;
    }
    else    if ("app_id".equals(__fieldName)) {
      this.app_id = (String) __fieldVal;
      return true;
    }
    else    if ("mo_phone".equals(__fieldName)) {
      this.mo_phone = (String) __fieldVal;
      return true;
    }
    else    if ("info".equals(__fieldName)) {
      this.info = (String) __fieldVal;
      return true;
    }
    else    if ("revers".equals(__fieldName)) {
      this.revers = (String) __fieldVal;
      return true;
    }
    else    if ("status".equals(__fieldName)) {
      this.status = (String) __fieldVal;
      return true;
    }
    else    if ("error_code".equals(__fieldName)) {
      this.error_code = (String) __fieldVal;
      return true;
    }
    else    if ("error_message".equals(__fieldName)) {
      this.error_message = (String) __fieldVal;
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
    else    if ("version".equals(__fieldName)) {
      this.version = (Integer) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
