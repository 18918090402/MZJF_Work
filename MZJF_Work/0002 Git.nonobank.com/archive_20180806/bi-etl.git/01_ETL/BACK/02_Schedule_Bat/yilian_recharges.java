// ORM class for table 'yilian_recharges'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Thu Jul 20 13:12:31 CST 2017
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

public class yilian_recharges extends SqoopRecord  implements DBWritable, Writable {
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
  public yilian_recharges with_id(Long id) {
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
  public yilian_recharges with_user_id(Long user_id) {
    this.user_id = user_id;
    return this;
  }
  private String batchNo;
  public String get_batchNo() {
    return batchNo;
  }
  public void set_batchNo(String batchNo) {
    this.batchNo = batchNo;
  }
  public yilian_recharges with_batchNo(String batchNo) {
    this.batchNo = batchNo;
    return this;
  }
  private String sn;
  public String get_sn() {
    return sn;
  }
  public void set_sn(String sn) {
    this.sn = sn;
  }
  public yilian_recharges with_sn(String sn) {
    this.sn = sn;
    return this;
  }
  private String banksAccount;
  public String get_banksAccount() {
    return banksAccount;
  }
  public void set_banksAccount(String banksAccount) {
    this.banksAccount = banksAccount;
  }
  public yilian_recharges with_banksAccount(String banksAccount) {
    this.banksAccount = banksAccount;
    return this;
  }
  private String realname;
  public String get_realname() {
    return realname;
  }
  public void set_realname(String realname) {
    this.realname = realname;
  }
  public yilian_recharges with_realname(String realname) {
    this.realname = realname;
    return this;
  }
  private org.apache.hadoop.io.BytesWritable idNo;
  public org.apache.hadoop.io.BytesWritable get_idNo() {
    return idNo;
  }
  public void set_idNo(org.apache.hadoop.io.BytesWritable idNo) {
    this.idNo = idNo;
  }
  public yilian_recharges with_idNo(org.apache.hadoop.io.BytesWritable idNo) {
    this.idNo = idNo;
    return this;
  }
  private Integer isAuth;
  public Integer get_isAuth() {
    return isAuth;
  }
  public void set_isAuth(Integer isAuth) {
    this.isAuth = isAuth;
  }
  public yilian_recharges with_isAuth(Integer isAuth) {
    this.isAuth = isAuth;
    return this;
  }
  private java.math.BigDecimal amount;
  public java.math.BigDecimal get_amount() {
    return amount;
  }
  public void set_amount(java.math.BigDecimal amount) {
    this.amount = amount;
  }
  public yilian_recharges with_amount(java.math.BigDecimal amount) {
    this.amount = amount;
    return this;
  }
  private java.math.BigDecimal settAmount;
  public java.math.BigDecimal get_settAmount() {
    return settAmount;
  }
  public void set_settAmount(java.math.BigDecimal settAmount) {
    this.settAmount = settAmount;
  }
  public yilian_recharges with_settAmount(java.math.BigDecimal settAmount) {
    this.settAmount = settAmount;
    return this;
  }
  private String sendXml;
  public String get_sendXml() {
    return sendXml;
  }
  public void set_sendXml(String sendXml) {
    this.sendXml = sendXml;
  }
  public yilian_recharges with_sendXml(String sendXml) {
    this.sendXml = sendXml;
    return this;
  }
  private String resultXml;
  public String get_resultXml() {
    return resultXml;
  }
  public void set_resultXml(String resultXml) {
    this.resultXml = resultXml;
  }
  public yilian_recharges with_resultXml(String resultXml) {
    this.resultXml = resultXml;
    return this;
  }
  private String queryXml;
  public String get_queryXml() {
    return queryXml;
  }
  public void set_queryXml(String queryXml) {
    this.queryXml = queryXml;
  }
  public yilian_recharges with_queryXml(String queryXml) {
    this.queryXml = queryXml;
    return this;
  }
  private String receiveXml;
  public String get_receiveXml() {
    return receiveXml;
  }
  public void set_receiveXml(String receiveXml) {
    this.receiveXml = receiveXml;
  }
  public yilian_recharges with_receiveXml(String receiveXml) {
    this.receiveXml = receiveXml;
    return this;
  }
  private String transState;
  public String get_transState() {
    return transState;
  }
  public void set_transState(String transState) {
    this.transState = transState;
  }
  public yilian_recharges with_transState(String transState) {
    this.transState = transState;
    return this;
  }
  private java.sql.Timestamp orderTime;
  public java.sql.Timestamp get_orderTime() {
    return orderTime;
  }
  public void set_orderTime(java.sql.Timestamp orderTime) {
    this.orderTime = orderTime;
  }
  public yilian_recharges with_orderTime(java.sql.Timestamp orderTime) {
    this.orderTime = orderTime;
    return this;
  }
  private String payState;
  public String get_payState() {
    return payState;
  }
  public void set_payState(String payState) {
    this.payState = payState;
  }
  public yilian_recharges with_payState(String payState) {
    this.payState = payState;
    return this;
  }
  private String respCode;
  public String get_respCode() {
    return respCode;
  }
  public void set_respCode(String respCode) {
    this.respCode = respCode;
  }
  public yilian_recharges with_respCode(String respCode) {
    this.respCode = respCode;
    return this;
  }
  private String respRemark;
  public String get_respRemark() {
    return respRemark;
  }
  public void set_respRemark(String respRemark) {
    this.respRemark = respRemark;
  }
  public yilian_recharges with_respRemark(String respRemark) {
    this.respRemark = respRemark;
    return this;
  }
  private String notifyJson;
  public String get_notifyJson() {
    return notifyJson;
  }
  public void set_notifyJson(String notifyJson) {
    this.notifyJson = notifyJson;
  }
  public yilian_recharges with_notifyJson(String notifyJson) {
    this.notifyJson = notifyJson;
    return this;
  }
  private java.sql.Timestamp notifyTime;
  public java.sql.Timestamp get_notifyTime() {
    return notifyTime;
  }
  public void set_notifyTime(java.sql.Timestamp notifyTime) {
    this.notifyTime = notifyTime;
  }
  public yilian_recharges with_notifyTime(java.sql.Timestamp notifyTime) {
    this.notifyTime = notifyTime;
    return this;
  }
  private String ylBatchNo;
  public String get_ylBatchNo() {
    return ylBatchNo;
  }
  public void set_ylBatchNo(String ylBatchNo) {
    this.ylBatchNo = ylBatchNo;
  }
  public yilian_recharges with_ylBatchNo(String ylBatchNo) {
    this.ylBatchNo = ylBatchNo;
    return this;
  }
  private Integer faoped;
  public Integer get_faoped() {
    return faoped;
  }
  public void set_faoped(Integer faoped) {
    this.faoped = faoped;
  }
  public yilian_recharges with_faoped(Integer faoped) {
    this.faoped = faoped;
    return this;
  }
  private Integer yr_money_status;
  public Integer get_yr_money_status() {
    return yr_money_status;
  }
  public void set_yr_money_status(Integer yr_money_status) {
    this.yr_money_status = yr_money_status;
  }
  public yilian_recharges with_yr_money_status(Integer yr_money_status) {
    this.yr_money_status = yr_money_status;
    return this;
  }
  private Integer version;
  public Integer get_version() {
    return version;
  }
  public void set_version(Integer version) {
    this.version = version;
  }
  public yilian_recharges with_version(Integer version) {
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
  public yilian_recharges with_create_time(java.sql.Timestamp create_time) {
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
  public yilian_recharges with_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof yilian_recharges)) {
      return false;
    }
    yilian_recharges that = (yilian_recharges) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.batchNo == null ? that.batchNo == null : this.batchNo.equals(that.batchNo));
    equal = equal && (this.sn == null ? that.sn == null : this.sn.equals(that.sn));
    equal = equal && (this.banksAccount == null ? that.banksAccount == null : this.banksAccount.equals(that.banksAccount));
    equal = equal && (this.realname == null ? that.realname == null : this.realname.equals(that.realname));
    equal = equal && (this.idNo == null ? that.idNo == null : this.idNo.equals(that.idNo));
    equal = equal && (this.isAuth == null ? that.isAuth == null : this.isAuth.equals(that.isAuth));
    equal = equal && (this.amount == null ? that.amount == null : this.amount.equals(that.amount));
    equal = equal && (this.settAmount == null ? that.settAmount == null : this.settAmount.equals(that.settAmount));
    equal = equal && (this.sendXml == null ? that.sendXml == null : this.sendXml.equals(that.sendXml));
    equal = equal && (this.resultXml == null ? that.resultXml == null : this.resultXml.equals(that.resultXml));
    equal = equal && (this.queryXml == null ? that.queryXml == null : this.queryXml.equals(that.queryXml));
    equal = equal && (this.receiveXml == null ? that.receiveXml == null : this.receiveXml.equals(that.receiveXml));
    equal = equal && (this.transState == null ? that.transState == null : this.transState.equals(that.transState));
    equal = equal && (this.orderTime == null ? that.orderTime == null : this.orderTime.equals(that.orderTime));
    equal = equal && (this.payState == null ? that.payState == null : this.payState.equals(that.payState));
    equal = equal && (this.respCode == null ? that.respCode == null : this.respCode.equals(that.respCode));
    equal = equal && (this.respRemark == null ? that.respRemark == null : this.respRemark.equals(that.respRemark));
    equal = equal && (this.notifyJson == null ? that.notifyJson == null : this.notifyJson.equals(that.notifyJson));
    equal = equal && (this.notifyTime == null ? that.notifyTime == null : this.notifyTime.equals(that.notifyTime));
    equal = equal && (this.ylBatchNo == null ? that.ylBatchNo == null : this.ylBatchNo.equals(that.ylBatchNo));
    equal = equal && (this.faoped == null ? that.faoped == null : this.faoped.equals(that.faoped));
    equal = equal && (this.yr_money_status == null ? that.yr_money_status == null : this.yr_money_status.equals(that.yr_money_status));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof yilian_recharges)) {
      return false;
    }
    yilian_recharges that = (yilian_recharges) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.batchNo == null ? that.batchNo == null : this.batchNo.equals(that.batchNo));
    equal = equal && (this.sn == null ? that.sn == null : this.sn.equals(that.sn));
    equal = equal && (this.banksAccount == null ? that.banksAccount == null : this.banksAccount.equals(that.banksAccount));
    equal = equal && (this.realname == null ? that.realname == null : this.realname.equals(that.realname));
    equal = equal && (this.idNo == null ? that.idNo == null : this.idNo.equals(that.idNo));
    equal = equal && (this.isAuth == null ? that.isAuth == null : this.isAuth.equals(that.isAuth));
    equal = equal && (this.amount == null ? that.amount == null : this.amount.equals(that.amount));
    equal = equal && (this.settAmount == null ? that.settAmount == null : this.settAmount.equals(that.settAmount));
    equal = equal && (this.sendXml == null ? that.sendXml == null : this.sendXml.equals(that.sendXml));
    equal = equal && (this.resultXml == null ? that.resultXml == null : this.resultXml.equals(that.resultXml));
    equal = equal && (this.queryXml == null ? that.queryXml == null : this.queryXml.equals(that.queryXml));
    equal = equal && (this.receiveXml == null ? that.receiveXml == null : this.receiveXml.equals(that.receiveXml));
    equal = equal && (this.transState == null ? that.transState == null : this.transState.equals(that.transState));
    equal = equal && (this.orderTime == null ? that.orderTime == null : this.orderTime.equals(that.orderTime));
    equal = equal && (this.payState == null ? that.payState == null : this.payState.equals(that.payState));
    equal = equal && (this.respCode == null ? that.respCode == null : this.respCode.equals(that.respCode));
    equal = equal && (this.respRemark == null ? that.respRemark == null : this.respRemark.equals(that.respRemark));
    equal = equal && (this.notifyJson == null ? that.notifyJson == null : this.notifyJson.equals(that.notifyJson));
    equal = equal && (this.notifyTime == null ? that.notifyTime == null : this.notifyTime.equals(that.notifyTime));
    equal = equal && (this.ylBatchNo == null ? that.ylBatchNo == null : this.ylBatchNo.equals(that.ylBatchNo));
    equal = equal && (this.faoped == null ? that.faoped == null : this.faoped.equals(that.faoped));
    equal = equal && (this.yr_money_status == null ? that.yr_money_status == null : this.yr_money_status.equals(that.yr_money_status));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.batchNo = JdbcWritableBridge.readString(3, __dbResults);
    this.sn = JdbcWritableBridge.readString(4, __dbResults);
    this.banksAccount = JdbcWritableBridge.readString(5, __dbResults);
    this.realname = JdbcWritableBridge.readString(6, __dbResults);
    this.idNo = JdbcWritableBridge.readBytesWritable(7, __dbResults);
    this.isAuth = JdbcWritableBridge.readInteger(8, __dbResults);
    this.amount = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.settAmount = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.sendXml = JdbcWritableBridge.readString(11, __dbResults);
    this.resultXml = JdbcWritableBridge.readString(12, __dbResults);
    this.queryXml = JdbcWritableBridge.readString(13, __dbResults);
    this.receiveXml = JdbcWritableBridge.readString(14, __dbResults);
    this.transState = JdbcWritableBridge.readString(15, __dbResults);
    this.orderTime = JdbcWritableBridge.readTimestamp(16, __dbResults);
    this.payState = JdbcWritableBridge.readString(17, __dbResults);
    this.respCode = JdbcWritableBridge.readString(18, __dbResults);
    this.respRemark = JdbcWritableBridge.readString(19, __dbResults);
    this.notifyJson = JdbcWritableBridge.readString(20, __dbResults);
    this.notifyTime = JdbcWritableBridge.readTimestamp(21, __dbResults);
    this.ylBatchNo = JdbcWritableBridge.readString(22, __dbResults);
    this.faoped = JdbcWritableBridge.readInteger(23, __dbResults);
    this.yr_money_status = JdbcWritableBridge.readInteger(24, __dbResults);
    this.version = JdbcWritableBridge.readInteger(25, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(26, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(27, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(2, __dbResults);
    this.batchNo = JdbcWritableBridge.readString(3, __dbResults);
    this.sn = JdbcWritableBridge.readString(4, __dbResults);
    this.banksAccount = JdbcWritableBridge.readString(5, __dbResults);
    this.realname = JdbcWritableBridge.readString(6, __dbResults);
    this.idNo = JdbcWritableBridge.readBytesWritable(7, __dbResults);
    this.isAuth = JdbcWritableBridge.readInteger(8, __dbResults);
    this.amount = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.settAmount = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.sendXml = JdbcWritableBridge.readString(11, __dbResults);
    this.resultXml = JdbcWritableBridge.readString(12, __dbResults);
    this.queryXml = JdbcWritableBridge.readString(13, __dbResults);
    this.receiveXml = JdbcWritableBridge.readString(14, __dbResults);
    this.transState = JdbcWritableBridge.readString(15, __dbResults);
    this.orderTime = JdbcWritableBridge.readTimestamp(16, __dbResults);
    this.payState = JdbcWritableBridge.readString(17, __dbResults);
    this.respCode = JdbcWritableBridge.readString(18, __dbResults);
    this.respRemark = JdbcWritableBridge.readString(19, __dbResults);
    this.notifyJson = JdbcWritableBridge.readString(20, __dbResults);
    this.notifyTime = JdbcWritableBridge.readTimestamp(21, __dbResults);
    this.ylBatchNo = JdbcWritableBridge.readString(22, __dbResults);
    this.faoped = JdbcWritableBridge.readInteger(23, __dbResults);
    this.yr_money_status = JdbcWritableBridge.readInteger(24, __dbResults);
    this.version = JdbcWritableBridge.readInteger(25, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(26, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(27, __dbResults);
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
    JdbcWritableBridge.writeString(batchNo, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(sn, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(banksAccount, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(realname, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBytesWritable(idNo, 7 + __off, -3, __dbStmt);
    JdbcWritableBridge.writeInteger(isAuth, 8 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(amount, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(settAmount, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(sendXml, 11 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(resultXml, 12 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(queryXml, 13 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(receiveXml, 14 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(transState, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(orderTime, 16 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(payState, 17 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(respCode, 18 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(respRemark, 19 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(notifyJson, 20 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeTimestamp(notifyTime, 21 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(ylBatchNo, 22 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(faoped, 23 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeInteger(yr_money_status, 24 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 25 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 26 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 27 + __off, 93, __dbStmt);
    return 27;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(user_id, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(batchNo, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(sn, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(banksAccount, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(realname, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBytesWritable(idNo, 7 + __off, -3, __dbStmt);
    JdbcWritableBridge.writeInteger(isAuth, 8 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(amount, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(settAmount, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(sendXml, 11 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(resultXml, 12 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(queryXml, 13 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(receiveXml, 14 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeString(transState, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(orderTime, 16 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(payState, 17 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(respCode, 18 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(respRemark, 19 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(notifyJson, 20 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeTimestamp(notifyTime, 21 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(ylBatchNo, 22 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(faoped, 23 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeInteger(yr_money_status, 24 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 25 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 26 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 27 + __off, 93, __dbStmt);
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
        this.batchNo = null;
    } else {
    this.batchNo = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.sn = null;
    } else {
    this.sn = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.banksAccount = null;
    } else {
    this.banksAccount = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.realname = null;
    } else {
    this.realname = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.idNo = null;
    } else {
    this.idNo = new BytesWritable();
    this.idNo.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.isAuth = null;
    } else {
    this.isAuth = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.amount = null;
    } else {
    this.amount = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.settAmount = null;
    } else {
    this.settAmount = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.sendXml = null;
    } else {
    this.sendXml = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.resultXml = null;
    } else {
    this.resultXml = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.queryXml = null;
    } else {
    this.queryXml = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.receiveXml = null;
    } else {
    this.receiveXml = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.transState = null;
    } else {
    this.transState = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.orderTime = null;
    } else {
    this.orderTime = new Timestamp(__dataIn.readLong());
    this.orderTime.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.payState = null;
    } else {
    this.payState = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.respCode = null;
    } else {
    this.respCode = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.respRemark = null;
    } else {
    this.respRemark = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.notifyJson = null;
    } else {
    this.notifyJson = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.notifyTime = null;
    } else {
    this.notifyTime = new Timestamp(__dataIn.readLong());
    this.notifyTime.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.ylBatchNo = null;
    } else {
    this.ylBatchNo = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.faoped = null;
    } else {
    this.faoped = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.yr_money_status = null;
    } else {
    this.yr_money_status = Integer.valueOf(__dataIn.readInt());
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
    if (null == this.batchNo) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, batchNo);
    }
    if (null == this.sn) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, sn);
    }
    if (null == this.banksAccount) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, banksAccount);
    }
    if (null == this.realname) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, realname);
    }
    if (null == this.idNo) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    this.idNo.write(__dataOut);
    }
    if (null == this.isAuth) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.isAuth);
    }
    if (null == this.amount) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.amount, __dataOut);
    }
    if (null == this.settAmount) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.settAmount, __dataOut);
    }
    if (null == this.sendXml) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, sendXml);
    }
    if (null == this.resultXml) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, resultXml);
    }
    if (null == this.queryXml) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, queryXml);
    }
    if (null == this.receiveXml) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, receiveXml);
    }
    if (null == this.transState) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, transState);
    }
    if (null == this.orderTime) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.orderTime.getTime());
    __dataOut.writeInt(this.orderTime.getNanos());
    }
    if (null == this.payState) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, payState);
    }
    if (null == this.respCode) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, respCode);
    }
    if (null == this.respRemark) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, respRemark);
    }
    if (null == this.notifyJson) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, notifyJson);
    }
    if (null == this.notifyTime) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.notifyTime.getTime());
    __dataOut.writeInt(this.notifyTime.getNanos());
    }
    if (null == this.ylBatchNo) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ylBatchNo);
    }
    if (null == this.faoped) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.faoped);
    }
    if (null == this.yr_money_status) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.yr_money_status);
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
    if (null == this.batchNo) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, batchNo);
    }
    if (null == this.sn) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, sn);
    }
    if (null == this.banksAccount) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, banksAccount);
    }
    if (null == this.realname) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, realname);
    }
    if (null == this.idNo) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    this.idNo.write(__dataOut);
    }
    if (null == this.isAuth) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.isAuth);
    }
    if (null == this.amount) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.amount, __dataOut);
    }
    if (null == this.settAmount) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.settAmount, __dataOut);
    }
    if (null == this.sendXml) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, sendXml);
    }
    if (null == this.resultXml) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, resultXml);
    }
    if (null == this.queryXml) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, queryXml);
    }
    if (null == this.receiveXml) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, receiveXml);
    }
    if (null == this.transState) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, transState);
    }
    if (null == this.orderTime) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.orderTime.getTime());
    __dataOut.writeInt(this.orderTime.getNanos());
    }
    if (null == this.payState) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, payState);
    }
    if (null == this.respCode) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, respCode);
    }
    if (null == this.respRemark) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, respRemark);
    }
    if (null == this.notifyJson) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, notifyJson);
    }
    if (null == this.notifyTime) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.notifyTime.getTime());
    __dataOut.writeInt(this.notifyTime.getNanos());
    }
    if (null == this.ylBatchNo) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ylBatchNo);
    }
    if (null == this.faoped) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.faoped);
    }
    if (null == this.yr_money_status) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.yr_money_status);
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
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(batchNo==null?"\\N":batchNo, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(sn==null?"\\N":sn, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(banksAccount==null?"\\N":banksAccount, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(realname==null?"\\N":realname, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(idNo==null?"\\N":"" + idNo, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(isAuth==null?"\\N":"" + isAuth, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(amount==null?"\\N":amount.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(settAmount==null?"\\N":settAmount.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(sendXml==null?"\\N":sendXml, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(resultXml==null?"\\N":resultXml, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(queryXml==null?"\\N":queryXml, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(receiveXml==null?"\\N":receiveXml, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(transState==null?"\\N":transState, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(orderTime==null?"\\N":"" + orderTime, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(payState==null?"\\N":payState, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(respCode==null?"\\N":respCode, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(respRemark==null?"\\N":respRemark, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(notifyJson==null?"\\N":notifyJson, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(notifyTime==null?"\\N":"" + notifyTime, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(ylBatchNo==null?"\\N":ylBatchNo, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(faoped==null?"\\N":"" + faoped, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(yr_money_status==null?"\\N":"" + yr_money_status, delimiters));
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
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(batchNo==null?"\\N":batchNo, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(sn==null?"\\N":sn, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(banksAccount==null?"\\N":banksAccount, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(realname==null?"\\N":realname, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(idNo==null?"\\N":"" + idNo, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(isAuth==null?"\\N":"" + isAuth, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(amount==null?"\\N":amount.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(settAmount==null?"\\N":settAmount.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(sendXml==null?"\\N":sendXml, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(resultXml==null?"\\N":resultXml, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(queryXml==null?"\\N":queryXml, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(receiveXml==null?"\\N":receiveXml, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(transState==null?"\\N":transState, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(orderTime==null?"\\N":"" + orderTime, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(payState==null?"\\N":payState, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(respCode==null?"\\N":respCode, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(respRemark==null?"\\N":respRemark, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(notifyJson==null?"\\N":notifyJson, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(notifyTime==null?"\\N":"" + notifyTime, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(ylBatchNo==null?"\\N":ylBatchNo, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(faoped==null?"\\N":"" + faoped, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(yr_money_status==null?"\\N":"" + yr_money_status, delimiters));
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
    if (__cur_str.equals("null")) { this.batchNo = null; } else {
      this.batchNo = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.sn = null; } else {
      this.sn = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.banksAccount = null; } else {
      this.banksAccount = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.realname = null; } else {
      this.realname = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.idNo = null; } else {
      String[] strByteVal = __cur_str.trim().split(" ");
      byte [] byteVal = new byte[strByteVal.length];
      for (int i = 0; i < byteVal.length; ++i) {
          byteVal[i] = (byte)Integer.parseInt(strByteVal[i], 16);
      }
      this.idNo = new BytesWritable(byteVal);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.isAuth = null; } else {
      this.isAuth = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.amount = null; } else {
      this.amount = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.settAmount = null; } else {
      this.settAmount = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.sendXml = null; } else {
      this.sendXml = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.resultXml = null; } else {
      this.resultXml = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.queryXml = null; } else {
      this.queryXml = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.receiveXml = null; } else {
      this.receiveXml = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.transState = null; } else {
      this.transState = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.orderTime = null; } else {
      this.orderTime = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.payState = null; } else {
      this.payState = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.respCode = null; } else {
      this.respCode = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.respRemark = null; } else {
      this.respRemark = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.notifyJson = null; } else {
      this.notifyJson = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.notifyTime = null; } else {
      this.notifyTime = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.ylBatchNo = null; } else {
      this.ylBatchNo = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.faoped = null; } else {
      this.faoped = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.yr_money_status = null; } else {
      this.yr_money_status = Integer.valueOf(__cur_str);
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
    if (__cur_str.equals("null")) { this.batchNo = null; } else {
      this.batchNo = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.sn = null; } else {
      this.sn = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.banksAccount = null; } else {
      this.banksAccount = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.realname = null; } else {
      this.realname = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.idNo = null; } else {
      String[] strByteVal = __cur_str.trim().split(" ");
      byte [] byteVal = new byte[strByteVal.length];
      for (int i = 0; i < byteVal.length; ++i) {
          byteVal[i] = (byte)Integer.parseInt(strByteVal[i], 16);
      }
      this.idNo = new BytesWritable(byteVal);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.isAuth = null; } else {
      this.isAuth = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.amount = null; } else {
      this.amount = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.settAmount = null; } else {
      this.settAmount = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.sendXml = null; } else {
      this.sendXml = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.resultXml = null; } else {
      this.resultXml = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.queryXml = null; } else {
      this.queryXml = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.receiveXml = null; } else {
      this.receiveXml = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.transState = null; } else {
      this.transState = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.orderTime = null; } else {
      this.orderTime = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.payState = null; } else {
      this.payState = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.respCode = null; } else {
      this.respCode = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.respRemark = null; } else {
      this.respRemark = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.notifyJson = null; } else {
      this.notifyJson = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.notifyTime = null; } else {
      this.notifyTime = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.ylBatchNo = null; } else {
      this.ylBatchNo = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.faoped = null; } else {
      this.faoped = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.yr_money_status = null; } else {
      this.yr_money_status = Integer.valueOf(__cur_str);
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
    yilian_recharges o = (yilian_recharges) super.clone();
    o.idNo = (o.idNo != null) ? new BytesWritable(Arrays.copyOf(idNo.getBytes(), idNo.getLength())) : null;
    o.orderTime = (o.orderTime != null) ? (java.sql.Timestamp) o.orderTime.clone() : null;
    o.notifyTime = (o.notifyTime != null) ? (java.sql.Timestamp) o.notifyTime.clone() : null;
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    return o;
  }

  public void clone0(yilian_recharges o) throws CloneNotSupportedException {
    o.idNo = (o.idNo != null) ? new BytesWritable(Arrays.copyOf(idNo.getBytes(), idNo.getLength())) : null;
    o.orderTime = (o.orderTime != null) ? (java.sql.Timestamp) o.orderTime.clone() : null;
    o.notifyTime = (o.notifyTime != null) ? (java.sql.Timestamp) o.notifyTime.clone() : null;
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("batchNo", this.batchNo);
    __sqoop$field_map.put("sn", this.sn);
    __sqoop$field_map.put("banksAccount", this.banksAccount);
    __sqoop$field_map.put("realname", this.realname);
    __sqoop$field_map.put("idNo", this.idNo);
    __sqoop$field_map.put("isAuth", this.isAuth);
    __sqoop$field_map.put("amount", this.amount);
    __sqoop$field_map.put("settAmount", this.settAmount);
    __sqoop$field_map.put("sendXml", this.sendXml);
    __sqoop$field_map.put("resultXml", this.resultXml);
    __sqoop$field_map.put("queryXml", this.queryXml);
    __sqoop$field_map.put("receiveXml", this.receiveXml);
    __sqoop$field_map.put("transState", this.transState);
    __sqoop$field_map.put("orderTime", this.orderTime);
    __sqoop$field_map.put("payState", this.payState);
    __sqoop$field_map.put("respCode", this.respCode);
    __sqoop$field_map.put("respRemark", this.respRemark);
    __sqoop$field_map.put("notifyJson", this.notifyJson);
    __sqoop$field_map.put("notifyTime", this.notifyTime);
    __sqoop$field_map.put("ylBatchNo", this.ylBatchNo);
    __sqoop$field_map.put("faoped", this.faoped);
    __sqoop$field_map.put("yr_money_status", this.yr_money_status);
    __sqoop$field_map.put("version", this.version);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("batchNo", this.batchNo);
    __sqoop$field_map.put("sn", this.sn);
    __sqoop$field_map.put("banksAccount", this.banksAccount);
    __sqoop$field_map.put("realname", this.realname);
    __sqoop$field_map.put("idNo", this.idNo);
    __sqoop$field_map.put("isAuth", this.isAuth);
    __sqoop$field_map.put("amount", this.amount);
    __sqoop$field_map.put("settAmount", this.settAmount);
    __sqoop$field_map.put("sendXml", this.sendXml);
    __sqoop$field_map.put("resultXml", this.resultXml);
    __sqoop$field_map.put("queryXml", this.queryXml);
    __sqoop$field_map.put("receiveXml", this.receiveXml);
    __sqoop$field_map.put("transState", this.transState);
    __sqoop$field_map.put("orderTime", this.orderTime);
    __sqoop$field_map.put("payState", this.payState);
    __sqoop$field_map.put("respCode", this.respCode);
    __sqoop$field_map.put("respRemark", this.respRemark);
    __sqoop$field_map.put("notifyJson", this.notifyJson);
    __sqoop$field_map.put("notifyTime", this.notifyTime);
    __sqoop$field_map.put("ylBatchNo", this.ylBatchNo);
    __sqoop$field_map.put("faoped", this.faoped);
    __sqoop$field_map.put("yr_money_status", this.yr_money_status);
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
    else    if ("batchNo".equals(__fieldName)) {
      this.batchNo = (String) __fieldVal;
    }
    else    if ("sn".equals(__fieldName)) {
      this.sn = (String) __fieldVal;
    }
    else    if ("banksAccount".equals(__fieldName)) {
      this.banksAccount = (String) __fieldVal;
    }
    else    if ("realname".equals(__fieldName)) {
      this.realname = (String) __fieldVal;
    }
    else    if ("idNo".equals(__fieldName)) {
      this.idNo = (org.apache.hadoop.io.BytesWritable) __fieldVal;
    }
    else    if ("isAuth".equals(__fieldName)) {
      this.isAuth = (Integer) __fieldVal;
    }
    else    if ("amount".equals(__fieldName)) {
      this.amount = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("settAmount".equals(__fieldName)) {
      this.settAmount = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("sendXml".equals(__fieldName)) {
      this.sendXml = (String) __fieldVal;
    }
    else    if ("resultXml".equals(__fieldName)) {
      this.resultXml = (String) __fieldVal;
    }
    else    if ("queryXml".equals(__fieldName)) {
      this.queryXml = (String) __fieldVal;
    }
    else    if ("receiveXml".equals(__fieldName)) {
      this.receiveXml = (String) __fieldVal;
    }
    else    if ("transState".equals(__fieldName)) {
      this.transState = (String) __fieldVal;
    }
    else    if ("orderTime".equals(__fieldName)) {
      this.orderTime = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("payState".equals(__fieldName)) {
      this.payState = (String) __fieldVal;
    }
    else    if ("respCode".equals(__fieldName)) {
      this.respCode = (String) __fieldVal;
    }
    else    if ("respRemark".equals(__fieldName)) {
      this.respRemark = (String) __fieldVal;
    }
    else    if ("notifyJson".equals(__fieldName)) {
      this.notifyJson = (String) __fieldVal;
    }
    else    if ("notifyTime".equals(__fieldName)) {
      this.notifyTime = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("ylBatchNo".equals(__fieldName)) {
      this.ylBatchNo = (String) __fieldVal;
    }
    else    if ("faoped".equals(__fieldName)) {
      this.faoped = (Integer) __fieldVal;
    }
    else    if ("yr_money_status".equals(__fieldName)) {
      this.yr_money_status = (Integer) __fieldVal;
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
    else    if ("batchNo".equals(__fieldName)) {
      this.batchNo = (String) __fieldVal;
      return true;
    }
    else    if ("sn".equals(__fieldName)) {
      this.sn = (String) __fieldVal;
      return true;
    }
    else    if ("banksAccount".equals(__fieldName)) {
      this.banksAccount = (String) __fieldVal;
      return true;
    }
    else    if ("realname".equals(__fieldName)) {
      this.realname = (String) __fieldVal;
      return true;
    }
    else    if ("idNo".equals(__fieldName)) {
      this.idNo = (org.apache.hadoop.io.BytesWritable) __fieldVal;
      return true;
    }
    else    if ("isAuth".equals(__fieldName)) {
      this.isAuth = (Integer) __fieldVal;
      return true;
    }
    else    if ("amount".equals(__fieldName)) {
      this.amount = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("settAmount".equals(__fieldName)) {
      this.settAmount = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("sendXml".equals(__fieldName)) {
      this.sendXml = (String) __fieldVal;
      return true;
    }
    else    if ("resultXml".equals(__fieldName)) {
      this.resultXml = (String) __fieldVal;
      return true;
    }
    else    if ("queryXml".equals(__fieldName)) {
      this.queryXml = (String) __fieldVal;
      return true;
    }
    else    if ("receiveXml".equals(__fieldName)) {
      this.receiveXml = (String) __fieldVal;
      return true;
    }
    else    if ("transState".equals(__fieldName)) {
      this.transState = (String) __fieldVal;
      return true;
    }
    else    if ("orderTime".equals(__fieldName)) {
      this.orderTime = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("payState".equals(__fieldName)) {
      this.payState = (String) __fieldVal;
      return true;
    }
    else    if ("respCode".equals(__fieldName)) {
      this.respCode = (String) __fieldVal;
      return true;
    }
    else    if ("respRemark".equals(__fieldName)) {
      this.respRemark = (String) __fieldVal;
      return true;
    }
    else    if ("notifyJson".equals(__fieldName)) {
      this.notifyJson = (String) __fieldVal;
      return true;
    }
    else    if ("notifyTime".equals(__fieldName)) {
      this.notifyTime = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("ylBatchNo".equals(__fieldName)) {
      this.ylBatchNo = (String) __fieldVal;
      return true;
    }
    else    if ("faoped".equals(__fieldName)) {
      this.faoped = (Integer) __fieldVal;
      return true;
    }
    else    if ("yr_money_status".equals(__fieldName)) {
      this.yr_money_status = (Integer) __fieldVal;
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
