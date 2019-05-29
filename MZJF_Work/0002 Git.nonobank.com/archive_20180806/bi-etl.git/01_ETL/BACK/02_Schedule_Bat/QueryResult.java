// ORM class for table 'null'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Thu Jul 20 13:33:17 CST 2017
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

public class QueryResult extends SqoopRecord  implements DBWritable, Writable {
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
  public QueryResult with_ID(Long ID) {
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
  public QueryResult with_USER_ID(Long USER_ID) {
    this.USER_ID = USER_ID;
    return this;
  }
  private String BATCHNO;
  public String get_BATCHNO() {
    return BATCHNO;
  }
  public void set_BATCHNO(String BATCHNO) {
    this.BATCHNO = BATCHNO;
  }
  public QueryResult with_BATCHNO(String BATCHNO) {
    this.BATCHNO = BATCHNO;
    return this;
  }
  private String SN;
  public String get_SN() {
    return SN;
  }
  public void set_SN(String SN) {
    this.SN = SN;
  }
  public QueryResult with_SN(String SN) {
    this.SN = SN;
    return this;
  }
  private String BANKSACCOUNT;
  public String get_BANKSACCOUNT() {
    return BANKSACCOUNT;
  }
  public void set_BANKSACCOUNT(String BANKSACCOUNT) {
    this.BANKSACCOUNT = BANKSACCOUNT;
  }
  public QueryResult with_BANKSACCOUNT(String BANKSACCOUNT) {
    this.BANKSACCOUNT = BANKSACCOUNT;
    return this;
  }
  private String REALNAME;
  public String get_REALNAME() {
    return REALNAME;
  }
  public void set_REALNAME(String REALNAME) {
    this.REALNAME = REALNAME;
  }
  public QueryResult with_REALNAME(String REALNAME) {
    this.REALNAME = REALNAME;
    return this;
  }
  private String IDNO;
  public String get_IDNO() {
    return IDNO;
  }
  public void set_IDNO(String IDNO) {
    this.IDNO = IDNO;
  }
  public QueryResult with_IDNO(String IDNO) {
    this.IDNO = IDNO;
    return this;
  }
  private Integer ISAUTH;
  public Integer get_ISAUTH() {
    return ISAUTH;
  }
  public void set_ISAUTH(Integer ISAUTH) {
    this.ISAUTH = ISAUTH;
  }
  public QueryResult with_ISAUTH(Integer ISAUTH) {
    this.ISAUTH = ISAUTH;
    return this;
  }
  private java.math.BigDecimal AMOUNT;
  public java.math.BigDecimal get_AMOUNT() {
    return AMOUNT;
  }
  public void set_AMOUNT(java.math.BigDecimal AMOUNT) {
    this.AMOUNT = AMOUNT;
  }
  public QueryResult with_AMOUNT(java.math.BigDecimal AMOUNT) {
    this.AMOUNT = AMOUNT;
    return this;
  }
  private java.math.BigDecimal SETTAMOUNT;
  public java.math.BigDecimal get_SETTAMOUNT() {
    return SETTAMOUNT;
  }
  public void set_SETTAMOUNT(java.math.BigDecimal SETTAMOUNT) {
    this.SETTAMOUNT = SETTAMOUNT;
  }
  public QueryResult with_SETTAMOUNT(java.math.BigDecimal SETTAMOUNT) {
    this.SETTAMOUNT = SETTAMOUNT;
    return this;
  }
  private String SENDXML;
  public String get_SENDXML() {
    return SENDXML;
  }
  public void set_SENDXML(String SENDXML) {
    this.SENDXML = SENDXML;
  }
  public QueryResult with_SENDXML(String SENDXML) {
    this.SENDXML = SENDXML;
    return this;
  }
  private String RESULTXML;
  public String get_RESULTXML() {
    return RESULTXML;
  }
  public void set_RESULTXML(String RESULTXML) {
    this.RESULTXML = RESULTXML;
  }
  public QueryResult with_RESULTXML(String RESULTXML) {
    this.RESULTXML = RESULTXML;
    return this;
  }
  private String QUERYXML;
  public String get_QUERYXML() {
    return QUERYXML;
  }
  public void set_QUERYXML(String QUERYXML) {
    this.QUERYXML = QUERYXML;
  }
  public QueryResult with_QUERYXML(String QUERYXML) {
    this.QUERYXML = QUERYXML;
    return this;
  }
  private String RECEIVEXML;
  public String get_RECEIVEXML() {
    return RECEIVEXML;
  }
  public void set_RECEIVEXML(String RECEIVEXML) {
    this.RECEIVEXML = RECEIVEXML;
  }
  public QueryResult with_RECEIVEXML(String RECEIVEXML) {
    this.RECEIVEXML = RECEIVEXML;
    return this;
  }
  private String TRANSSTATE;
  public String get_TRANSSTATE() {
    return TRANSSTATE;
  }
  public void set_TRANSSTATE(String TRANSSTATE) {
    this.TRANSSTATE = TRANSSTATE;
  }
  public QueryResult with_TRANSSTATE(String TRANSSTATE) {
    this.TRANSSTATE = TRANSSTATE;
    return this;
  }
  private java.sql.Timestamp ORDERTIME;
  public java.sql.Timestamp get_ORDERTIME() {
    return ORDERTIME;
  }
  public void set_ORDERTIME(java.sql.Timestamp ORDERTIME) {
    this.ORDERTIME = ORDERTIME;
  }
  public QueryResult with_ORDERTIME(java.sql.Timestamp ORDERTIME) {
    this.ORDERTIME = ORDERTIME;
    return this;
  }
  private String PAYSTATE;
  public String get_PAYSTATE() {
    return PAYSTATE;
  }
  public void set_PAYSTATE(String PAYSTATE) {
    this.PAYSTATE = PAYSTATE;
  }
  public QueryResult with_PAYSTATE(String PAYSTATE) {
    this.PAYSTATE = PAYSTATE;
    return this;
  }
  private String RESPCODE;
  public String get_RESPCODE() {
    return RESPCODE;
  }
  public void set_RESPCODE(String RESPCODE) {
    this.RESPCODE = RESPCODE;
  }
  public QueryResult with_RESPCODE(String RESPCODE) {
    this.RESPCODE = RESPCODE;
    return this;
  }
  private String RESPREMARK;
  public String get_RESPREMARK() {
    return RESPREMARK;
  }
  public void set_RESPREMARK(String RESPREMARK) {
    this.RESPREMARK = RESPREMARK;
  }
  public QueryResult with_RESPREMARK(String RESPREMARK) {
    this.RESPREMARK = RESPREMARK;
    return this;
  }
  private String NOTIFYJSON;
  public String get_NOTIFYJSON() {
    return NOTIFYJSON;
  }
  public void set_NOTIFYJSON(String NOTIFYJSON) {
    this.NOTIFYJSON = NOTIFYJSON;
  }
  public QueryResult with_NOTIFYJSON(String NOTIFYJSON) {
    this.NOTIFYJSON = NOTIFYJSON;
    return this;
  }
  private java.sql.Timestamp NOTIFYTIME;
  public java.sql.Timestamp get_NOTIFYTIME() {
    return NOTIFYTIME;
  }
  public void set_NOTIFYTIME(java.sql.Timestamp NOTIFYTIME) {
    this.NOTIFYTIME = NOTIFYTIME;
  }
  public QueryResult with_NOTIFYTIME(java.sql.Timestamp NOTIFYTIME) {
    this.NOTIFYTIME = NOTIFYTIME;
    return this;
  }
  private String YLBATCHNO;
  public String get_YLBATCHNO() {
    return YLBATCHNO;
  }
  public void set_YLBATCHNO(String YLBATCHNO) {
    this.YLBATCHNO = YLBATCHNO;
  }
  public QueryResult with_YLBATCHNO(String YLBATCHNO) {
    this.YLBATCHNO = YLBATCHNO;
    return this;
  }
  private Long FAOPED;
  public Long get_FAOPED() {
    return FAOPED;
  }
  public void set_FAOPED(Long FAOPED) {
    this.FAOPED = FAOPED;
  }
  public QueryResult with_FAOPED(Long FAOPED) {
    this.FAOPED = FAOPED;
    return this;
  }
  private Long YR_MONEY_STATUS;
  public Long get_YR_MONEY_STATUS() {
    return YR_MONEY_STATUS;
  }
  public void set_YR_MONEY_STATUS(Long YR_MONEY_STATUS) {
    this.YR_MONEY_STATUS = YR_MONEY_STATUS;
  }
  public QueryResult with_YR_MONEY_STATUS(Long YR_MONEY_STATUS) {
    this.YR_MONEY_STATUS = YR_MONEY_STATUS;
    return this;
  }
  private Integer VERSION;
  public Integer get_VERSION() {
    return VERSION;
  }
  public void set_VERSION(Integer VERSION) {
    this.VERSION = VERSION;
  }
  public QueryResult with_VERSION(Integer VERSION) {
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
  public QueryResult with_CREATE_TIME(java.sql.Timestamp CREATE_TIME) {
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
  public QueryResult with_UPDATE_TIME(java.sql.Timestamp UPDATE_TIME) {
    this.UPDATE_TIME = UPDATE_TIME;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof QueryResult)) {
      return false;
    }
    QueryResult that = (QueryResult) o;
    boolean equal = true;
    equal = equal && (this.ID == null ? that.ID == null : this.ID.equals(that.ID));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.BATCHNO == null ? that.BATCHNO == null : this.BATCHNO.equals(that.BATCHNO));
    equal = equal && (this.SN == null ? that.SN == null : this.SN.equals(that.SN));
    equal = equal && (this.BANKSACCOUNT == null ? that.BANKSACCOUNT == null : this.BANKSACCOUNT.equals(that.BANKSACCOUNT));
    equal = equal && (this.REALNAME == null ? that.REALNAME == null : this.REALNAME.equals(that.REALNAME));
    equal = equal && (this.IDNO == null ? that.IDNO == null : this.IDNO.equals(that.IDNO));
    equal = equal && (this.ISAUTH == null ? that.ISAUTH == null : this.ISAUTH.equals(that.ISAUTH));
    equal = equal && (this.AMOUNT == null ? that.AMOUNT == null : this.AMOUNT.equals(that.AMOUNT));
    equal = equal && (this.SETTAMOUNT == null ? that.SETTAMOUNT == null : this.SETTAMOUNT.equals(that.SETTAMOUNT));
    equal = equal && (this.SENDXML == null ? that.SENDXML == null : this.SENDXML.equals(that.SENDXML));
    equal = equal && (this.RESULTXML == null ? that.RESULTXML == null : this.RESULTXML.equals(that.RESULTXML));
    equal = equal && (this.QUERYXML == null ? that.QUERYXML == null : this.QUERYXML.equals(that.QUERYXML));
    equal = equal && (this.RECEIVEXML == null ? that.RECEIVEXML == null : this.RECEIVEXML.equals(that.RECEIVEXML));
    equal = equal && (this.TRANSSTATE == null ? that.TRANSSTATE == null : this.TRANSSTATE.equals(that.TRANSSTATE));
    equal = equal && (this.ORDERTIME == null ? that.ORDERTIME == null : this.ORDERTIME.equals(that.ORDERTIME));
    equal = equal && (this.PAYSTATE == null ? that.PAYSTATE == null : this.PAYSTATE.equals(that.PAYSTATE));
    equal = equal && (this.RESPCODE == null ? that.RESPCODE == null : this.RESPCODE.equals(that.RESPCODE));
    equal = equal && (this.RESPREMARK == null ? that.RESPREMARK == null : this.RESPREMARK.equals(that.RESPREMARK));
    equal = equal && (this.NOTIFYJSON == null ? that.NOTIFYJSON == null : this.NOTIFYJSON.equals(that.NOTIFYJSON));
    equal = equal && (this.NOTIFYTIME == null ? that.NOTIFYTIME == null : this.NOTIFYTIME.equals(that.NOTIFYTIME));
    equal = equal && (this.YLBATCHNO == null ? that.YLBATCHNO == null : this.YLBATCHNO.equals(that.YLBATCHNO));
    equal = equal && (this.FAOPED == null ? that.FAOPED == null : this.FAOPED.equals(that.FAOPED));
    equal = equal && (this.YR_MONEY_STATUS == null ? that.YR_MONEY_STATUS == null : this.YR_MONEY_STATUS.equals(that.YR_MONEY_STATUS));
    equal = equal && (this.VERSION == null ? that.VERSION == null : this.VERSION.equals(that.VERSION));
    equal = equal && (this.CREATE_TIME == null ? that.CREATE_TIME == null : this.CREATE_TIME.equals(that.CREATE_TIME));
    equal = equal && (this.UPDATE_TIME == null ? that.UPDATE_TIME == null : this.UPDATE_TIME.equals(that.UPDATE_TIME));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof QueryResult)) {
      return false;
    }
    QueryResult that = (QueryResult) o;
    boolean equal = true;
    equal = equal && (this.ID == null ? that.ID == null : this.ID.equals(that.ID));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.BATCHNO == null ? that.BATCHNO == null : this.BATCHNO.equals(that.BATCHNO));
    equal = equal && (this.SN == null ? that.SN == null : this.SN.equals(that.SN));
    equal = equal && (this.BANKSACCOUNT == null ? that.BANKSACCOUNT == null : this.BANKSACCOUNT.equals(that.BANKSACCOUNT));
    equal = equal && (this.REALNAME == null ? that.REALNAME == null : this.REALNAME.equals(that.REALNAME));
    equal = equal && (this.IDNO == null ? that.IDNO == null : this.IDNO.equals(that.IDNO));
    equal = equal && (this.ISAUTH == null ? that.ISAUTH == null : this.ISAUTH.equals(that.ISAUTH));
    equal = equal && (this.AMOUNT == null ? that.AMOUNT == null : this.AMOUNT.equals(that.AMOUNT));
    equal = equal && (this.SETTAMOUNT == null ? that.SETTAMOUNT == null : this.SETTAMOUNT.equals(that.SETTAMOUNT));
    equal = equal && (this.SENDXML == null ? that.SENDXML == null : this.SENDXML.equals(that.SENDXML));
    equal = equal && (this.RESULTXML == null ? that.RESULTXML == null : this.RESULTXML.equals(that.RESULTXML));
    equal = equal && (this.QUERYXML == null ? that.QUERYXML == null : this.QUERYXML.equals(that.QUERYXML));
    equal = equal && (this.RECEIVEXML == null ? that.RECEIVEXML == null : this.RECEIVEXML.equals(that.RECEIVEXML));
    equal = equal && (this.TRANSSTATE == null ? that.TRANSSTATE == null : this.TRANSSTATE.equals(that.TRANSSTATE));
    equal = equal && (this.ORDERTIME == null ? that.ORDERTIME == null : this.ORDERTIME.equals(that.ORDERTIME));
    equal = equal && (this.PAYSTATE == null ? that.PAYSTATE == null : this.PAYSTATE.equals(that.PAYSTATE));
    equal = equal && (this.RESPCODE == null ? that.RESPCODE == null : this.RESPCODE.equals(that.RESPCODE));
    equal = equal && (this.RESPREMARK == null ? that.RESPREMARK == null : this.RESPREMARK.equals(that.RESPREMARK));
    equal = equal && (this.NOTIFYJSON == null ? that.NOTIFYJSON == null : this.NOTIFYJSON.equals(that.NOTIFYJSON));
    equal = equal && (this.NOTIFYTIME == null ? that.NOTIFYTIME == null : this.NOTIFYTIME.equals(that.NOTIFYTIME));
    equal = equal && (this.YLBATCHNO == null ? that.YLBATCHNO == null : this.YLBATCHNO.equals(that.YLBATCHNO));
    equal = equal && (this.FAOPED == null ? that.FAOPED == null : this.FAOPED.equals(that.FAOPED));
    equal = equal && (this.YR_MONEY_STATUS == null ? that.YR_MONEY_STATUS == null : this.YR_MONEY_STATUS.equals(that.YR_MONEY_STATUS));
    equal = equal && (this.VERSION == null ? that.VERSION == null : this.VERSION.equals(that.VERSION));
    equal = equal && (this.CREATE_TIME == null ? that.CREATE_TIME == null : this.CREATE_TIME.equals(that.CREATE_TIME));
    equal = equal && (this.UPDATE_TIME == null ? that.UPDATE_TIME == null : this.UPDATE_TIME.equals(that.UPDATE_TIME));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.ID = JdbcWritableBridge.readLong(1, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(2, __dbResults);
    this.BATCHNO = JdbcWritableBridge.readString(3, __dbResults);
    this.SN = JdbcWritableBridge.readString(4, __dbResults);
    this.BANKSACCOUNT = JdbcWritableBridge.readString(5, __dbResults);
    this.REALNAME = JdbcWritableBridge.readString(6, __dbResults);
    this.IDNO = JdbcWritableBridge.readString(7, __dbResults);
    this.ISAUTH = JdbcWritableBridge.readInteger(8, __dbResults);
    this.AMOUNT = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.SETTAMOUNT = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.SENDXML = JdbcWritableBridge.readString(11, __dbResults);
    this.RESULTXML = JdbcWritableBridge.readString(12, __dbResults);
    this.QUERYXML = JdbcWritableBridge.readString(13, __dbResults);
    this.RECEIVEXML = JdbcWritableBridge.readString(14, __dbResults);
    this.TRANSSTATE = JdbcWritableBridge.readString(15, __dbResults);
    this.ORDERTIME = JdbcWritableBridge.readTimestamp(16, __dbResults);
    this.PAYSTATE = JdbcWritableBridge.readString(17, __dbResults);
    this.RESPCODE = JdbcWritableBridge.readString(18, __dbResults);
    this.RESPREMARK = JdbcWritableBridge.readString(19, __dbResults);
    this.NOTIFYJSON = JdbcWritableBridge.readString(20, __dbResults);
    this.NOTIFYTIME = JdbcWritableBridge.readTimestamp(21, __dbResults);
    this.YLBATCHNO = JdbcWritableBridge.readString(22, __dbResults);
    this.FAOPED = JdbcWritableBridge.readLong(23, __dbResults);
    this.YR_MONEY_STATUS = JdbcWritableBridge.readLong(24, __dbResults);
    this.VERSION = JdbcWritableBridge.readInteger(25, __dbResults);
    this.CREATE_TIME = JdbcWritableBridge.readTimestamp(26, __dbResults);
    this.UPDATE_TIME = JdbcWritableBridge.readTimestamp(27, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.ID = JdbcWritableBridge.readLong(1, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(2, __dbResults);
    this.BATCHNO = JdbcWritableBridge.readString(3, __dbResults);
    this.SN = JdbcWritableBridge.readString(4, __dbResults);
    this.BANKSACCOUNT = JdbcWritableBridge.readString(5, __dbResults);
    this.REALNAME = JdbcWritableBridge.readString(6, __dbResults);
    this.IDNO = JdbcWritableBridge.readString(7, __dbResults);
    this.ISAUTH = JdbcWritableBridge.readInteger(8, __dbResults);
    this.AMOUNT = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.SETTAMOUNT = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.SENDXML = JdbcWritableBridge.readString(11, __dbResults);
    this.RESULTXML = JdbcWritableBridge.readString(12, __dbResults);
    this.QUERYXML = JdbcWritableBridge.readString(13, __dbResults);
    this.RECEIVEXML = JdbcWritableBridge.readString(14, __dbResults);
    this.TRANSSTATE = JdbcWritableBridge.readString(15, __dbResults);
    this.ORDERTIME = JdbcWritableBridge.readTimestamp(16, __dbResults);
    this.PAYSTATE = JdbcWritableBridge.readString(17, __dbResults);
    this.RESPCODE = JdbcWritableBridge.readString(18, __dbResults);
    this.RESPREMARK = JdbcWritableBridge.readString(19, __dbResults);
    this.NOTIFYJSON = JdbcWritableBridge.readString(20, __dbResults);
    this.NOTIFYTIME = JdbcWritableBridge.readTimestamp(21, __dbResults);
    this.YLBATCHNO = JdbcWritableBridge.readString(22, __dbResults);
    this.FAOPED = JdbcWritableBridge.readLong(23, __dbResults);
    this.YR_MONEY_STATUS = JdbcWritableBridge.readLong(24, __dbResults);
    this.VERSION = JdbcWritableBridge.readInteger(25, __dbResults);
    this.CREATE_TIME = JdbcWritableBridge.readTimestamp(26, __dbResults);
    this.UPDATE_TIME = JdbcWritableBridge.readTimestamp(27, __dbResults);
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
    JdbcWritableBridge.writeString(BATCHNO, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(SN, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(BANKSACCOUNT, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(REALNAME, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(IDNO, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(ISAUTH, 8 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(AMOUNT, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(SETTAMOUNT, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(SENDXML, 11 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(RESULTXML, 12 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(QUERYXML, 13 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(RECEIVEXML, 14 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(TRANSSTATE, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(ORDERTIME, 16 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(PAYSTATE, 17 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(RESPCODE, 18 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(RESPREMARK, 19 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(NOTIFYJSON, 20 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeTimestamp(NOTIFYTIME, 21 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(YLBATCHNO, 22 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeLong(FAOPED, 23 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(YR_MONEY_STATUS, 24 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(VERSION, 25 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(CREATE_TIME, 26 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(UPDATE_TIME, 27 + __off, 93, __dbStmt);
    return 27;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(ID, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(USER_ID, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(BATCHNO, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(SN, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(BANKSACCOUNT, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(REALNAME, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(IDNO, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(ISAUTH, 8 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(AMOUNT, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(SETTAMOUNT, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(SENDXML, 11 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(RESULTXML, 12 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(QUERYXML, 13 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(RECEIVEXML, 14 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(TRANSSTATE, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(ORDERTIME, 16 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(PAYSTATE, 17 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(RESPCODE, 18 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(RESPREMARK, 19 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(NOTIFYJSON, 20 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeTimestamp(NOTIFYTIME, 21 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(YLBATCHNO, 22 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeLong(FAOPED, 23 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(YR_MONEY_STATUS, 24 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(VERSION, 25 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(CREATE_TIME, 26 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(UPDATE_TIME, 27 + __off, 93, __dbStmt);
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
        this.BATCHNO = null;
    } else {
    this.BATCHNO = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.SN = null;
    } else {
    this.SN = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.BANKSACCOUNT = null;
    } else {
    this.BANKSACCOUNT = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.REALNAME = null;
    } else {
    this.REALNAME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.IDNO = null;
    } else {
    this.IDNO = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ISAUTH = null;
    } else {
    this.ISAUTH = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.AMOUNT = null;
    } else {
    this.AMOUNT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.SETTAMOUNT = null;
    } else {
    this.SETTAMOUNT = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.SENDXML = null;
    } else {
    this.SENDXML = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.RESULTXML = null;
    } else {
    this.RESULTXML = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.QUERYXML = null;
    } else {
    this.QUERYXML = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.RECEIVEXML = null;
    } else {
    this.RECEIVEXML = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.TRANSSTATE = null;
    } else {
    this.TRANSSTATE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ORDERTIME = null;
    } else {
    this.ORDERTIME = new Timestamp(__dataIn.readLong());
    this.ORDERTIME.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.PAYSTATE = null;
    } else {
    this.PAYSTATE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.RESPCODE = null;
    } else {
    this.RESPCODE = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.RESPREMARK = null;
    } else {
    this.RESPREMARK = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.NOTIFYJSON = null;
    } else {
    this.NOTIFYJSON = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.NOTIFYTIME = null;
    } else {
    this.NOTIFYTIME = new Timestamp(__dataIn.readLong());
    this.NOTIFYTIME.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.YLBATCHNO = null;
    } else {
    this.YLBATCHNO = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.FAOPED = null;
    } else {
    this.FAOPED = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.YR_MONEY_STATUS = null;
    } else {
    this.YR_MONEY_STATUS = Long.valueOf(__dataIn.readLong());
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
    if (null == this.BATCHNO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, BATCHNO);
    }
    if (null == this.SN) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, SN);
    }
    if (null == this.BANKSACCOUNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, BANKSACCOUNT);
    }
    if (null == this.REALNAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REALNAME);
    }
    if (null == this.IDNO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, IDNO);
    }
    if (null == this.ISAUTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ISAUTH);
    }
    if (null == this.AMOUNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.AMOUNT, __dataOut);
    }
    if (null == this.SETTAMOUNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.SETTAMOUNT, __dataOut);
    }
    if (null == this.SENDXML) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, SENDXML);
    }
    if (null == this.RESULTXML) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, RESULTXML);
    }
    if (null == this.QUERYXML) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, QUERYXML);
    }
    if (null == this.RECEIVEXML) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, RECEIVEXML);
    }
    if (null == this.TRANSSTATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, TRANSSTATE);
    }
    if (null == this.ORDERTIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.ORDERTIME.getTime());
    __dataOut.writeInt(this.ORDERTIME.getNanos());
    }
    if (null == this.PAYSTATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PAYSTATE);
    }
    if (null == this.RESPCODE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, RESPCODE);
    }
    if (null == this.RESPREMARK) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, RESPREMARK);
    }
    if (null == this.NOTIFYJSON) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, NOTIFYJSON);
    }
    if (null == this.NOTIFYTIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.NOTIFYTIME.getTime());
    __dataOut.writeInt(this.NOTIFYTIME.getNanos());
    }
    if (null == this.YLBATCHNO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, YLBATCHNO);
    }
    if (null == this.FAOPED) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.FAOPED);
    }
    if (null == this.YR_MONEY_STATUS) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.YR_MONEY_STATUS);
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
    if (null == this.BATCHNO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, BATCHNO);
    }
    if (null == this.SN) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, SN);
    }
    if (null == this.BANKSACCOUNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, BANKSACCOUNT);
    }
    if (null == this.REALNAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, REALNAME);
    }
    if (null == this.IDNO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, IDNO);
    }
    if (null == this.ISAUTH) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ISAUTH);
    }
    if (null == this.AMOUNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.AMOUNT, __dataOut);
    }
    if (null == this.SETTAMOUNT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.SETTAMOUNT, __dataOut);
    }
    if (null == this.SENDXML) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, SENDXML);
    }
    if (null == this.RESULTXML) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, RESULTXML);
    }
    if (null == this.QUERYXML) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, QUERYXML);
    }
    if (null == this.RECEIVEXML) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, RECEIVEXML);
    }
    if (null == this.TRANSSTATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, TRANSSTATE);
    }
    if (null == this.ORDERTIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.ORDERTIME.getTime());
    __dataOut.writeInt(this.ORDERTIME.getNanos());
    }
    if (null == this.PAYSTATE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PAYSTATE);
    }
    if (null == this.RESPCODE) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, RESPCODE);
    }
    if (null == this.RESPREMARK) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, RESPREMARK);
    }
    if (null == this.NOTIFYJSON) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, NOTIFYJSON);
    }
    if (null == this.NOTIFYTIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.NOTIFYTIME.getTime());
    __dataOut.writeInt(this.NOTIFYTIME.getNanos());
    }
    if (null == this.YLBATCHNO) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, YLBATCHNO);
    }
    if (null == this.FAOPED) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.FAOPED);
    }
    if (null == this.YR_MONEY_STATUS) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.YR_MONEY_STATUS);
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
    __sb.append(FieldFormatter.escapeAndEnclose(ID==null?"\\N":"" + ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"\\N":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(BATCHNO==null?"\\N":BATCHNO, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(SN==null?"\\N":SN, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(BANKSACCOUNT==null?"\\N":BANKSACCOUNT, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(REALNAME==null?"\\N":REALNAME, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(IDNO==null?"\\N":IDNO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ISAUTH==null?"\\N":"" + ISAUTH, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(AMOUNT==null?"\\N":AMOUNT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SETTAMOUNT==null?"\\N":SETTAMOUNT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(SENDXML==null?"\\N":SENDXML, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(RESULTXML==null?"\\N":RESULTXML, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(QUERYXML==null?"\\N":QUERYXML, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(RECEIVEXML==null?"\\N":RECEIVEXML, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(TRANSSTATE==null?"\\N":TRANSSTATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ORDERTIME==null?"\\N":"" + ORDERTIME, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(PAYSTATE==null?"\\N":PAYSTATE, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(RESPCODE==null?"\\N":RESPCODE, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(RESPREMARK==null?"\\N":RESPREMARK, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(NOTIFYJSON==null?"\\N":NOTIFYJSON, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(NOTIFYTIME==null?"\\N":"" + NOTIFYTIME, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(YLBATCHNO==null?"\\N":YLBATCHNO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FAOPED==null?"\\N":"" + FAOPED, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(YR_MONEY_STATUS==null?"\\N":"" + YR_MONEY_STATUS, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(VERSION==null?"\\N":"" + VERSION, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATE_TIME==null?"\\N":"" + CREATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(UPDATE_TIME==null?"\\N":"" + UPDATE_TIME, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(ID==null?"\\N":"" + ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"\\N":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(BATCHNO==null?"\\N":BATCHNO, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(SN==null?"\\N":SN, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(BANKSACCOUNT==null?"\\N":BANKSACCOUNT, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(REALNAME==null?"\\N":REALNAME, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(IDNO==null?"\\N":IDNO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ISAUTH==null?"\\N":"" + ISAUTH, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(AMOUNT==null?"\\N":AMOUNT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(SETTAMOUNT==null?"\\N":SETTAMOUNT.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(SENDXML==null?"\\N":SENDXML, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(RESULTXML==null?"\\N":RESULTXML, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(QUERYXML==null?"\\N":QUERYXML, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(RECEIVEXML==null?"\\N":RECEIVEXML, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(TRANSSTATE==null?"\\N":TRANSSTATE, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ORDERTIME==null?"\\N":"" + ORDERTIME, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(PAYSTATE==null?"\\N":PAYSTATE, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(RESPCODE==null?"\\N":RESPCODE, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(RESPREMARK==null?"\\N":RESPREMARK, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(NOTIFYJSON==null?"\\N":NOTIFYJSON, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(NOTIFYTIME==null?"\\N":"" + NOTIFYTIME, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(YLBATCHNO==null?"\\N":YLBATCHNO, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FAOPED==null?"\\N":"" + FAOPED, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(YR_MONEY_STATUS==null?"\\N":"" + YR_MONEY_STATUS, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(VERSION==null?"\\N":"" + VERSION, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATE_TIME==null?"\\N":"" + CREATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(UPDATE_TIME==null?"\\N":"" + UPDATE_TIME, delimiters));
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
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ID = null; } else {
      this.ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.BATCHNO = null; } else {
      this.BATCHNO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.SN = null; } else {
      this.SN = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.BANKSACCOUNT = null; } else {
      this.BANKSACCOUNT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.REALNAME = null; } else {
      this.REALNAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.IDNO = null; } else {
      this.IDNO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ISAUTH = null; } else {
      this.ISAUTH = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.AMOUNT = null; } else {
      this.AMOUNT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.SETTAMOUNT = null; } else {
      this.SETTAMOUNT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.SENDXML = null; } else {
      this.SENDXML = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.RESULTXML = null; } else {
      this.RESULTXML = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.QUERYXML = null; } else {
      this.QUERYXML = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.RECEIVEXML = null; } else {
      this.RECEIVEXML = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.TRANSSTATE = null; } else {
      this.TRANSSTATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ORDERTIME = null; } else {
      this.ORDERTIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.PAYSTATE = null; } else {
      this.PAYSTATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.RESPCODE = null; } else {
      this.RESPCODE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.RESPREMARK = null; } else {
      this.RESPREMARK = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.NOTIFYJSON = null; } else {
      this.NOTIFYJSON = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.NOTIFYTIME = null; } else {
      this.NOTIFYTIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.YLBATCHNO = null; } else {
      this.YLBATCHNO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.FAOPED = null; } else {
      this.FAOPED = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.YR_MONEY_STATUS = null; } else {
      this.YR_MONEY_STATUS = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.VERSION = null; } else {
      this.VERSION = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.CREATE_TIME = null; } else {
      this.CREATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.UPDATE_TIME = null; } else {
      this.UPDATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ID = null; } else {
      this.ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.BATCHNO = null; } else {
      this.BATCHNO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.SN = null; } else {
      this.SN = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.BANKSACCOUNT = null; } else {
      this.BANKSACCOUNT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.REALNAME = null; } else {
      this.REALNAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.IDNO = null; } else {
      this.IDNO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ISAUTH = null; } else {
      this.ISAUTH = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.AMOUNT = null; } else {
      this.AMOUNT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.SETTAMOUNT = null; } else {
      this.SETTAMOUNT = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.SENDXML = null; } else {
      this.SENDXML = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.RESULTXML = null; } else {
      this.RESULTXML = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.QUERYXML = null; } else {
      this.QUERYXML = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.RECEIVEXML = null; } else {
      this.RECEIVEXML = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.TRANSSTATE = null; } else {
      this.TRANSSTATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.ORDERTIME = null; } else {
      this.ORDERTIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.PAYSTATE = null; } else {
      this.PAYSTATE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.RESPCODE = null; } else {
      this.RESPCODE = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.RESPREMARK = null; } else {
      this.RESPREMARK = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.NOTIFYJSON = null; } else {
      this.NOTIFYJSON = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.NOTIFYTIME = null; } else {
      this.NOTIFYTIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.YLBATCHNO = null; } else {
      this.YLBATCHNO = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.FAOPED = null; } else {
      this.FAOPED = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.YR_MONEY_STATUS = null; } else {
      this.YR_MONEY_STATUS = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.VERSION = null; } else {
      this.VERSION = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.CREATE_TIME = null; } else {
      this.CREATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.UPDATE_TIME = null; } else {
      this.UPDATE_TIME = java.sql.Timestamp.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    QueryResult o = (QueryResult) super.clone();
    o.ORDERTIME = (o.ORDERTIME != null) ? (java.sql.Timestamp) o.ORDERTIME.clone() : null;
    o.NOTIFYTIME = (o.NOTIFYTIME != null) ? (java.sql.Timestamp) o.NOTIFYTIME.clone() : null;
    o.CREATE_TIME = (o.CREATE_TIME != null) ? (java.sql.Timestamp) o.CREATE_TIME.clone() : null;
    o.UPDATE_TIME = (o.UPDATE_TIME != null) ? (java.sql.Timestamp) o.UPDATE_TIME.clone() : null;
    return o;
  }

  public void clone0(QueryResult o) throws CloneNotSupportedException {
    o.ORDERTIME = (o.ORDERTIME != null) ? (java.sql.Timestamp) o.ORDERTIME.clone() : null;
    o.NOTIFYTIME = (o.NOTIFYTIME != null) ? (java.sql.Timestamp) o.NOTIFYTIME.clone() : null;
    o.CREATE_TIME = (o.CREATE_TIME != null) ? (java.sql.Timestamp) o.CREATE_TIME.clone() : null;
    o.UPDATE_TIME = (o.UPDATE_TIME != null) ? (java.sql.Timestamp) o.UPDATE_TIME.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("ID", this.ID);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("BATCHNO", this.BATCHNO);
    __sqoop$field_map.put("SN", this.SN);
    __sqoop$field_map.put("BANKSACCOUNT", this.BANKSACCOUNT);
    __sqoop$field_map.put("REALNAME", this.REALNAME);
    __sqoop$field_map.put("IDNO", this.IDNO);
    __sqoop$field_map.put("ISAUTH", this.ISAUTH);
    __sqoop$field_map.put("AMOUNT", this.AMOUNT);
    __sqoop$field_map.put("SETTAMOUNT", this.SETTAMOUNT);
    __sqoop$field_map.put("SENDXML", this.SENDXML);
    __sqoop$field_map.put("RESULTXML", this.RESULTXML);
    __sqoop$field_map.put("QUERYXML", this.QUERYXML);
    __sqoop$field_map.put("RECEIVEXML", this.RECEIVEXML);
    __sqoop$field_map.put("TRANSSTATE", this.TRANSSTATE);
    __sqoop$field_map.put("ORDERTIME", this.ORDERTIME);
    __sqoop$field_map.put("PAYSTATE", this.PAYSTATE);
    __sqoop$field_map.put("RESPCODE", this.RESPCODE);
    __sqoop$field_map.put("RESPREMARK", this.RESPREMARK);
    __sqoop$field_map.put("NOTIFYJSON", this.NOTIFYJSON);
    __sqoop$field_map.put("NOTIFYTIME", this.NOTIFYTIME);
    __sqoop$field_map.put("YLBATCHNO", this.YLBATCHNO);
    __sqoop$field_map.put("FAOPED", this.FAOPED);
    __sqoop$field_map.put("YR_MONEY_STATUS", this.YR_MONEY_STATUS);
    __sqoop$field_map.put("VERSION", this.VERSION);
    __sqoop$field_map.put("CREATE_TIME", this.CREATE_TIME);
    __sqoop$field_map.put("UPDATE_TIME", this.UPDATE_TIME);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("ID", this.ID);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("BATCHNO", this.BATCHNO);
    __sqoop$field_map.put("SN", this.SN);
    __sqoop$field_map.put("BANKSACCOUNT", this.BANKSACCOUNT);
    __sqoop$field_map.put("REALNAME", this.REALNAME);
    __sqoop$field_map.put("IDNO", this.IDNO);
    __sqoop$field_map.put("ISAUTH", this.ISAUTH);
    __sqoop$field_map.put("AMOUNT", this.AMOUNT);
    __sqoop$field_map.put("SETTAMOUNT", this.SETTAMOUNT);
    __sqoop$field_map.put("SENDXML", this.SENDXML);
    __sqoop$field_map.put("RESULTXML", this.RESULTXML);
    __sqoop$field_map.put("QUERYXML", this.QUERYXML);
    __sqoop$field_map.put("RECEIVEXML", this.RECEIVEXML);
    __sqoop$field_map.put("TRANSSTATE", this.TRANSSTATE);
    __sqoop$field_map.put("ORDERTIME", this.ORDERTIME);
    __sqoop$field_map.put("PAYSTATE", this.PAYSTATE);
    __sqoop$field_map.put("RESPCODE", this.RESPCODE);
    __sqoop$field_map.put("RESPREMARK", this.RESPREMARK);
    __sqoop$field_map.put("NOTIFYJSON", this.NOTIFYJSON);
    __sqoop$field_map.put("NOTIFYTIME", this.NOTIFYTIME);
    __sqoop$field_map.put("YLBATCHNO", this.YLBATCHNO);
    __sqoop$field_map.put("FAOPED", this.FAOPED);
    __sqoop$field_map.put("YR_MONEY_STATUS", this.YR_MONEY_STATUS);
    __sqoop$field_map.put("VERSION", this.VERSION);
    __sqoop$field_map.put("CREATE_TIME", this.CREATE_TIME);
    __sqoop$field_map.put("UPDATE_TIME", this.UPDATE_TIME);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("ID".equals(__fieldName)) {
      this.ID = (Long) __fieldVal;
    }
    else    if ("USER_ID".equals(__fieldName)) {
      this.USER_ID = (Long) __fieldVal;
    }
    else    if ("BATCHNO".equals(__fieldName)) {
      this.BATCHNO = (String) __fieldVal;
    }
    else    if ("SN".equals(__fieldName)) {
      this.SN = (String) __fieldVal;
    }
    else    if ("BANKSACCOUNT".equals(__fieldName)) {
      this.BANKSACCOUNT = (String) __fieldVal;
    }
    else    if ("REALNAME".equals(__fieldName)) {
      this.REALNAME = (String) __fieldVal;
    }
    else    if ("IDNO".equals(__fieldName)) {
      this.IDNO = (String) __fieldVal;
    }
    else    if ("ISAUTH".equals(__fieldName)) {
      this.ISAUTH = (Integer) __fieldVal;
    }
    else    if ("AMOUNT".equals(__fieldName)) {
      this.AMOUNT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("SETTAMOUNT".equals(__fieldName)) {
      this.SETTAMOUNT = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("SENDXML".equals(__fieldName)) {
      this.SENDXML = (String) __fieldVal;
    }
    else    if ("RESULTXML".equals(__fieldName)) {
      this.RESULTXML = (String) __fieldVal;
    }
    else    if ("QUERYXML".equals(__fieldName)) {
      this.QUERYXML = (String) __fieldVal;
    }
    else    if ("RECEIVEXML".equals(__fieldName)) {
      this.RECEIVEXML = (String) __fieldVal;
    }
    else    if ("TRANSSTATE".equals(__fieldName)) {
      this.TRANSSTATE = (String) __fieldVal;
    }
    else    if ("ORDERTIME".equals(__fieldName)) {
      this.ORDERTIME = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("PAYSTATE".equals(__fieldName)) {
      this.PAYSTATE = (String) __fieldVal;
    }
    else    if ("RESPCODE".equals(__fieldName)) {
      this.RESPCODE = (String) __fieldVal;
    }
    else    if ("RESPREMARK".equals(__fieldName)) {
      this.RESPREMARK = (String) __fieldVal;
    }
    else    if ("NOTIFYJSON".equals(__fieldName)) {
      this.NOTIFYJSON = (String) __fieldVal;
    }
    else    if ("NOTIFYTIME".equals(__fieldName)) {
      this.NOTIFYTIME = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("YLBATCHNO".equals(__fieldName)) {
      this.YLBATCHNO = (String) __fieldVal;
    }
    else    if ("FAOPED".equals(__fieldName)) {
      this.FAOPED = (Long) __fieldVal;
    }
    else    if ("YR_MONEY_STATUS".equals(__fieldName)) {
      this.YR_MONEY_STATUS = (Long) __fieldVal;
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
    else    if ("BATCHNO".equals(__fieldName)) {
      this.BATCHNO = (String) __fieldVal;
      return true;
    }
    else    if ("SN".equals(__fieldName)) {
      this.SN = (String) __fieldVal;
      return true;
    }
    else    if ("BANKSACCOUNT".equals(__fieldName)) {
      this.BANKSACCOUNT = (String) __fieldVal;
      return true;
    }
    else    if ("REALNAME".equals(__fieldName)) {
      this.REALNAME = (String) __fieldVal;
      return true;
    }
    else    if ("IDNO".equals(__fieldName)) {
      this.IDNO = (String) __fieldVal;
      return true;
    }
    else    if ("ISAUTH".equals(__fieldName)) {
      this.ISAUTH = (Integer) __fieldVal;
      return true;
    }
    else    if ("AMOUNT".equals(__fieldName)) {
      this.AMOUNT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("SETTAMOUNT".equals(__fieldName)) {
      this.SETTAMOUNT = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("SENDXML".equals(__fieldName)) {
      this.SENDXML = (String) __fieldVal;
      return true;
    }
    else    if ("RESULTXML".equals(__fieldName)) {
      this.RESULTXML = (String) __fieldVal;
      return true;
    }
    else    if ("QUERYXML".equals(__fieldName)) {
      this.QUERYXML = (String) __fieldVal;
      return true;
    }
    else    if ("RECEIVEXML".equals(__fieldName)) {
      this.RECEIVEXML = (String) __fieldVal;
      return true;
    }
    else    if ("TRANSSTATE".equals(__fieldName)) {
      this.TRANSSTATE = (String) __fieldVal;
      return true;
    }
    else    if ("ORDERTIME".equals(__fieldName)) {
      this.ORDERTIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("PAYSTATE".equals(__fieldName)) {
      this.PAYSTATE = (String) __fieldVal;
      return true;
    }
    else    if ("RESPCODE".equals(__fieldName)) {
      this.RESPCODE = (String) __fieldVal;
      return true;
    }
    else    if ("RESPREMARK".equals(__fieldName)) {
      this.RESPREMARK = (String) __fieldVal;
      return true;
    }
    else    if ("NOTIFYJSON".equals(__fieldName)) {
      this.NOTIFYJSON = (String) __fieldVal;
      return true;
    }
    else    if ("NOTIFYTIME".equals(__fieldName)) {
      this.NOTIFYTIME = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("YLBATCHNO".equals(__fieldName)) {
      this.YLBATCHNO = (String) __fieldVal;
      return true;
    }
    else    if ("FAOPED".equals(__fieldName)) {
      this.FAOPED = (Long) __fieldVal;
      return true;
    }
    else    if ("YR_MONEY_STATUS".equals(__fieldName)) {
      this.YR_MONEY_STATUS = (Long) __fieldVal;
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
    else {
      return false;    }
  }
}
