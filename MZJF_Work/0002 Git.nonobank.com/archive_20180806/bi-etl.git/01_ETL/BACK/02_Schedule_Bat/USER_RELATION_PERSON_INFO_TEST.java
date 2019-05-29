// ORM class for table 'USER_RELATION_PERSON_INFO_TEST'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Fri Jul 14 18:39:09 CST 2017
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

public class USER_RELATION_PERSON_INFO_TEST extends SqoopRecord  implements DBWritable, Writable {
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
  public USER_RELATION_PERSON_INFO_TEST with_ID(Long ID) {
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
  public USER_RELATION_PERSON_INFO_TEST with_USER_ID(Long USER_ID) {
    this.USER_ID = USER_ID;
    return this;
  }
  private String LAST_NAME;
  public String get_LAST_NAME() {
    return LAST_NAME;
  }
  public void set_LAST_NAME(String LAST_NAME) {
    this.LAST_NAME = LAST_NAME;
  }
  public USER_RELATION_PERSON_INFO_TEST with_LAST_NAME(String LAST_NAME) {
    this.LAST_NAME = LAST_NAME;
    return this;
  }
  private String FIRST_NAME;
  public String get_FIRST_NAME() {
    return FIRST_NAME;
  }
  public void set_FIRST_NAME(String FIRST_NAME) {
    this.FIRST_NAME = FIRST_NAME;
  }
  public USER_RELATION_PERSON_INFO_TEST with_FIRST_NAME(String FIRST_NAME) {
    this.FIRST_NAME = FIRST_NAME;
    return this;
  }
  private String PHONE_ARR;
  public String get_PHONE_ARR() {
    return PHONE_ARR;
  }
  public void set_PHONE_ARR(String PHONE_ARR) {
    this.PHONE_ARR = PHONE_ARR;
  }
  public USER_RELATION_PERSON_INFO_TEST with_PHONE_ARR(String PHONE_ARR) {
    this.PHONE_ARR = PHONE_ARR;
    return this;
  }
  private String EMAIL_ARR;
  public String get_EMAIL_ARR() {
    return EMAIL_ARR;
  }
  public void set_EMAIL_ARR(String EMAIL_ARR) {
    this.EMAIL_ARR = EMAIL_ARR;
  }
  public USER_RELATION_PERSON_INFO_TEST with_EMAIL_ARR(String EMAIL_ARR) {
    this.EMAIL_ARR = EMAIL_ARR;
    return this;
  }
  private String ADDRESS_ARR;
  public String get_ADDRESS_ARR() {
    return ADDRESS_ARR;
  }
  public void set_ADDRESS_ARR(String ADDRESS_ARR) {
    this.ADDRESS_ARR = ADDRESS_ARR;
  }
  public USER_RELATION_PERSON_INFO_TEST with_ADDRESS_ARR(String ADDRESS_ARR) {
    this.ADDRESS_ARR = ADDRESS_ARR;
    return this;
  }
  private String MIDDLE_NAME;
  public String get_MIDDLE_NAME() {
    return MIDDLE_NAME;
  }
  public void set_MIDDLE_NAME(String MIDDLE_NAME) {
    this.MIDDLE_NAME = MIDDLE_NAME;
  }
  public USER_RELATION_PERSON_INFO_TEST with_MIDDLE_NAME(String MIDDLE_NAME) {
    this.MIDDLE_NAME = MIDDLE_NAME;
    return this;
  }
  private String NOTES;
  public String get_NOTES() {
    return NOTES;
  }
  public void set_NOTES(String NOTES) {
    this.NOTES = NOTES;
  }
  public USER_RELATION_PERSON_INFO_TEST with_NOTES(String NOTES) {
    this.NOTES = NOTES;
    return this;
  }
  private String BIRTHDAY;
  public String get_BIRTHDAY() {
    return BIRTHDAY;
  }
  public void set_BIRTHDAY(String BIRTHDAY) {
    this.BIRTHDAY = BIRTHDAY;
  }
  public USER_RELATION_PERSON_INFO_TEST with_BIRTHDAY(String BIRTHDAY) {
    this.BIRTHDAY = BIRTHDAY;
    return this;
  }
  private String NICK_NAME;
  public String get_NICK_NAME() {
    return NICK_NAME;
  }
  public void set_NICK_NAME(String NICK_NAME) {
    this.NICK_NAME = NICK_NAME;
  }
  public USER_RELATION_PERSON_INFO_TEST with_NICK_NAME(String NICK_NAME) {
    this.NICK_NAME = NICK_NAME;
    return this;
  }
  private String DEPARTMENT;
  public String get_DEPARTMENT() {
    return DEPARTMENT;
  }
  public void set_DEPARTMENT(String DEPARTMENT) {
    this.DEPARTMENT = DEPARTMENT;
  }
  public USER_RELATION_PERSON_INFO_TEST with_DEPARTMENT(String DEPARTMENT) {
    this.DEPARTMENT = DEPARTMENT;
    return this;
  }
  private String JOB;
  public String get_JOB() {
    return JOB;
  }
  public void set_JOB(String JOB) {
    this.JOB = JOB;
  }
  public USER_RELATION_PERSON_INFO_TEST with_JOB(String JOB) {
    this.JOB = JOB;
    return this;
  }
  private String ORGANIZATION;
  public String get_ORGANIZATION() {
    return ORGANIZATION;
  }
  public void set_ORGANIZATION(String ORGANIZATION) {
    this.ORGANIZATION = ORGANIZATION;
  }
  public USER_RELATION_PERSON_INFO_TEST with_ORGANIZATION(String ORGANIZATION) {
    this.ORGANIZATION = ORGANIZATION;
    return this;
  }
  private String FLAG;
  public String get_FLAG() {
    return FLAG;
  }
  public void set_FLAG(String FLAG) {
    this.FLAG = FLAG;
  }
  public USER_RELATION_PERSON_INFO_TEST with_FLAG(String FLAG) {
    this.FLAG = FLAG;
    return this;
  }
  private String CREATE_TIME;
  public String get_CREATE_TIME() {
    return CREATE_TIME;
  }
  public void set_CREATE_TIME(String CREATE_TIME) {
    this.CREATE_TIME = CREATE_TIME;
  }
  public USER_RELATION_PERSON_INFO_TEST with_CREATE_TIME(String CREATE_TIME) {
    this.CREATE_TIME = CREATE_TIME;
    return this;
  }
  private String UPDATE_TIME;
  public String get_UPDATE_TIME() {
    return UPDATE_TIME;
  }
  public void set_UPDATE_TIME(String UPDATE_TIME) {
    this.UPDATE_TIME = UPDATE_TIME;
  }
  public USER_RELATION_PERSON_INFO_TEST with_UPDATE_TIME(String UPDATE_TIME) {
    this.UPDATE_TIME = UPDATE_TIME;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof USER_RELATION_PERSON_INFO_TEST)) {
      return false;
    }
    USER_RELATION_PERSON_INFO_TEST that = (USER_RELATION_PERSON_INFO_TEST) o;
    boolean equal = true;
    equal = equal && (this.ID == null ? that.ID == null : this.ID.equals(that.ID));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.LAST_NAME == null ? that.LAST_NAME == null : this.LAST_NAME.equals(that.LAST_NAME));
    equal = equal && (this.FIRST_NAME == null ? that.FIRST_NAME == null : this.FIRST_NAME.equals(that.FIRST_NAME));
    equal = equal && (this.PHONE_ARR == null ? that.PHONE_ARR == null : this.PHONE_ARR.equals(that.PHONE_ARR));
    equal = equal && (this.EMAIL_ARR == null ? that.EMAIL_ARR == null : this.EMAIL_ARR.equals(that.EMAIL_ARR));
    equal = equal && (this.ADDRESS_ARR == null ? that.ADDRESS_ARR == null : this.ADDRESS_ARR.equals(that.ADDRESS_ARR));
    equal = equal && (this.MIDDLE_NAME == null ? that.MIDDLE_NAME == null : this.MIDDLE_NAME.equals(that.MIDDLE_NAME));
    equal = equal && (this.NOTES == null ? that.NOTES == null : this.NOTES.equals(that.NOTES));
    equal = equal && (this.BIRTHDAY == null ? that.BIRTHDAY == null : this.BIRTHDAY.equals(that.BIRTHDAY));
    equal = equal && (this.NICK_NAME == null ? that.NICK_NAME == null : this.NICK_NAME.equals(that.NICK_NAME));
    equal = equal && (this.DEPARTMENT == null ? that.DEPARTMENT == null : this.DEPARTMENT.equals(that.DEPARTMENT));
    equal = equal && (this.JOB == null ? that.JOB == null : this.JOB.equals(that.JOB));
    equal = equal && (this.ORGANIZATION == null ? that.ORGANIZATION == null : this.ORGANIZATION.equals(that.ORGANIZATION));
    equal = equal && (this.FLAG == null ? that.FLAG == null : this.FLAG.equals(that.FLAG));
    equal = equal && (this.CREATE_TIME == null ? that.CREATE_TIME == null : this.CREATE_TIME.equals(that.CREATE_TIME));
    equal = equal && (this.UPDATE_TIME == null ? that.UPDATE_TIME == null : this.UPDATE_TIME.equals(that.UPDATE_TIME));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof USER_RELATION_PERSON_INFO_TEST)) {
      return false;
    }
    USER_RELATION_PERSON_INFO_TEST that = (USER_RELATION_PERSON_INFO_TEST) o;
    boolean equal = true;
    equal = equal && (this.ID == null ? that.ID == null : this.ID.equals(that.ID));
    equal = equal && (this.USER_ID == null ? that.USER_ID == null : this.USER_ID.equals(that.USER_ID));
    equal = equal && (this.LAST_NAME == null ? that.LAST_NAME == null : this.LAST_NAME.equals(that.LAST_NAME));
    equal = equal && (this.FIRST_NAME == null ? that.FIRST_NAME == null : this.FIRST_NAME.equals(that.FIRST_NAME));
    equal = equal && (this.PHONE_ARR == null ? that.PHONE_ARR == null : this.PHONE_ARR.equals(that.PHONE_ARR));
    equal = equal && (this.EMAIL_ARR == null ? that.EMAIL_ARR == null : this.EMAIL_ARR.equals(that.EMAIL_ARR));
    equal = equal && (this.ADDRESS_ARR == null ? that.ADDRESS_ARR == null : this.ADDRESS_ARR.equals(that.ADDRESS_ARR));
    equal = equal && (this.MIDDLE_NAME == null ? that.MIDDLE_NAME == null : this.MIDDLE_NAME.equals(that.MIDDLE_NAME));
    equal = equal && (this.NOTES == null ? that.NOTES == null : this.NOTES.equals(that.NOTES));
    equal = equal && (this.BIRTHDAY == null ? that.BIRTHDAY == null : this.BIRTHDAY.equals(that.BIRTHDAY));
    equal = equal && (this.NICK_NAME == null ? that.NICK_NAME == null : this.NICK_NAME.equals(that.NICK_NAME));
    equal = equal && (this.DEPARTMENT == null ? that.DEPARTMENT == null : this.DEPARTMENT.equals(that.DEPARTMENT));
    equal = equal && (this.JOB == null ? that.JOB == null : this.JOB.equals(that.JOB));
    equal = equal && (this.ORGANIZATION == null ? that.ORGANIZATION == null : this.ORGANIZATION.equals(that.ORGANIZATION));
    equal = equal && (this.FLAG == null ? that.FLAG == null : this.FLAG.equals(that.FLAG));
    equal = equal && (this.CREATE_TIME == null ? that.CREATE_TIME == null : this.CREATE_TIME.equals(that.CREATE_TIME));
    equal = equal && (this.UPDATE_TIME == null ? that.UPDATE_TIME == null : this.UPDATE_TIME.equals(that.UPDATE_TIME));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.ID = JdbcWritableBridge.readLong(1, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(2, __dbResults);
    this.LAST_NAME = JdbcWritableBridge.readString(3, __dbResults);
    this.FIRST_NAME = JdbcWritableBridge.readString(4, __dbResults);
    this.PHONE_ARR = JdbcWritableBridge.readString(5, __dbResults);
    this.EMAIL_ARR = JdbcWritableBridge.readString(6, __dbResults);
    this.ADDRESS_ARR = JdbcWritableBridge.readString(7, __dbResults);
    this.MIDDLE_NAME = JdbcWritableBridge.readString(8, __dbResults);
    this.NOTES = JdbcWritableBridge.readString(9, __dbResults);
    this.BIRTHDAY = JdbcWritableBridge.readString(10, __dbResults);
    this.NICK_NAME = JdbcWritableBridge.readString(11, __dbResults);
    this.DEPARTMENT = JdbcWritableBridge.readString(12, __dbResults);
    this.JOB = JdbcWritableBridge.readString(13, __dbResults);
    this.ORGANIZATION = JdbcWritableBridge.readString(14, __dbResults);
    this.FLAG = JdbcWritableBridge.readString(15, __dbResults);
    this.CREATE_TIME = JdbcWritableBridge.readString(16, __dbResults);
    this.UPDATE_TIME = JdbcWritableBridge.readString(17, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.ID = JdbcWritableBridge.readLong(1, __dbResults);
    this.USER_ID = JdbcWritableBridge.readLong(2, __dbResults);
    this.LAST_NAME = JdbcWritableBridge.readString(3, __dbResults);
    this.FIRST_NAME = JdbcWritableBridge.readString(4, __dbResults);
    this.PHONE_ARR = JdbcWritableBridge.readString(5, __dbResults);
    this.EMAIL_ARR = JdbcWritableBridge.readString(6, __dbResults);
    this.ADDRESS_ARR = JdbcWritableBridge.readString(7, __dbResults);
    this.MIDDLE_NAME = JdbcWritableBridge.readString(8, __dbResults);
    this.NOTES = JdbcWritableBridge.readString(9, __dbResults);
    this.BIRTHDAY = JdbcWritableBridge.readString(10, __dbResults);
    this.NICK_NAME = JdbcWritableBridge.readString(11, __dbResults);
    this.DEPARTMENT = JdbcWritableBridge.readString(12, __dbResults);
    this.JOB = JdbcWritableBridge.readString(13, __dbResults);
    this.ORGANIZATION = JdbcWritableBridge.readString(14, __dbResults);
    this.FLAG = JdbcWritableBridge.readString(15, __dbResults);
    this.CREATE_TIME = JdbcWritableBridge.readString(16, __dbResults);
    this.UPDATE_TIME = JdbcWritableBridge.readString(17, __dbResults);
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
    JdbcWritableBridge.writeString(LAST_NAME, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(FIRST_NAME, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(PHONE_ARR, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(EMAIL_ARR, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(ADDRESS_ARR, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(MIDDLE_NAME, 8 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(NOTES, 9 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(BIRTHDAY, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(NICK_NAME, 11 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(DEPARTMENT, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(JOB, 13 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(ORGANIZATION, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(FLAG, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(CREATE_TIME, 16 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(UPDATE_TIME, 17 + __off, 12, __dbStmt);
    return 17;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(ID, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeLong(USER_ID, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(LAST_NAME, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(FIRST_NAME, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(PHONE_ARR, 5 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(EMAIL_ARR, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(ADDRESS_ARR, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(MIDDLE_NAME, 8 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(NOTES, 9 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(BIRTHDAY, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(NICK_NAME, 11 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(DEPARTMENT, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(JOB, 13 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(ORGANIZATION, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(FLAG, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(CREATE_TIME, 16 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(UPDATE_TIME, 17 + __off, 12, __dbStmt);
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
        this.LAST_NAME = null;
    } else {
    this.LAST_NAME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.FIRST_NAME = null;
    } else {
    this.FIRST_NAME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.PHONE_ARR = null;
    } else {
    this.PHONE_ARR = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.EMAIL_ARR = null;
    } else {
    this.EMAIL_ARR = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ADDRESS_ARR = null;
    } else {
    this.ADDRESS_ARR = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.MIDDLE_NAME = null;
    } else {
    this.MIDDLE_NAME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.NOTES = null;
    } else {
    this.NOTES = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.BIRTHDAY = null;
    } else {
    this.BIRTHDAY = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.NICK_NAME = null;
    } else {
    this.NICK_NAME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.DEPARTMENT = null;
    } else {
    this.DEPARTMENT = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.JOB = null;
    } else {
    this.JOB = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.ORGANIZATION = null;
    } else {
    this.ORGANIZATION = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.FLAG = null;
    } else {
    this.FLAG = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.CREATE_TIME = null;
    } else {
    this.CREATE_TIME = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.UPDATE_TIME = null;
    } else {
    this.UPDATE_TIME = Text.readString(__dataIn);
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
    if (null == this.LAST_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, LAST_NAME);
    }
    if (null == this.FIRST_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, FIRST_NAME);
    }
    if (null == this.PHONE_ARR) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PHONE_ARR);
    }
    if (null == this.EMAIL_ARR) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, EMAIL_ARR);
    }
    if (null == this.ADDRESS_ARR) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ADDRESS_ARR);
    }
    if (null == this.MIDDLE_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, MIDDLE_NAME);
    }
    if (null == this.NOTES) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, NOTES);
    }
    if (null == this.BIRTHDAY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, BIRTHDAY);
    }
    if (null == this.NICK_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, NICK_NAME);
    }
    if (null == this.DEPARTMENT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DEPARTMENT);
    }
    if (null == this.JOB) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, JOB);
    }
    if (null == this.ORGANIZATION) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ORGANIZATION);
    }
    if (null == this.FLAG) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, FLAG);
    }
    if (null == this.CREATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, CREATE_TIME);
    }
    if (null == this.UPDATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, UPDATE_TIME);
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
    if (null == this.LAST_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, LAST_NAME);
    }
    if (null == this.FIRST_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, FIRST_NAME);
    }
    if (null == this.PHONE_ARR) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, PHONE_ARR);
    }
    if (null == this.EMAIL_ARR) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, EMAIL_ARR);
    }
    if (null == this.ADDRESS_ARR) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ADDRESS_ARR);
    }
    if (null == this.MIDDLE_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, MIDDLE_NAME);
    }
    if (null == this.NOTES) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, NOTES);
    }
    if (null == this.BIRTHDAY) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, BIRTHDAY);
    }
    if (null == this.NICK_NAME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, NICK_NAME);
    }
    if (null == this.DEPARTMENT) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, DEPARTMENT);
    }
    if (null == this.JOB) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, JOB);
    }
    if (null == this.ORGANIZATION) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, ORGANIZATION);
    }
    if (null == this.FLAG) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, FLAG);
    }
    if (null == this.CREATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, CREATE_TIME);
    }
    if (null == this.UPDATE_TIME) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, UPDATE_TIME);
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
    __sb.append(FieldFormatter.escapeAndEnclose(ID==null?"null":"" + ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"null":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LAST_NAME==null?"null":LAST_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FIRST_NAME==null?"null":FIRST_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PHONE_ARR==null?"null":PHONE_ARR, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(EMAIL_ARR==null?"null":EMAIL_ARR, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ADDRESS_ARR==null?"null":ADDRESS_ARR, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MIDDLE_NAME==null?"null":MIDDLE_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(NOTES==null?"null":NOTES, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BIRTHDAY==null?"null":BIRTHDAY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(NICK_NAME==null?"null":NICK_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DEPARTMENT==null?"null":DEPARTMENT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(JOB==null?"null":JOB, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ORGANIZATION==null?"null":ORGANIZATION, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FLAG==null?"null":FLAG, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATE_TIME==null?"null":CREATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(UPDATE_TIME==null?"null":UPDATE_TIME, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(ID==null?"null":"" + ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(USER_ID==null?"null":"" + USER_ID, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(LAST_NAME==null?"null":LAST_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FIRST_NAME==null?"null":FIRST_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(PHONE_ARR==null?"null":PHONE_ARR, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(EMAIL_ARR==null?"null":EMAIL_ARR, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ADDRESS_ARR==null?"null":ADDRESS_ARR, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(MIDDLE_NAME==null?"null":MIDDLE_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(NOTES==null?"null":NOTES, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(BIRTHDAY==null?"null":BIRTHDAY, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(NICK_NAME==null?"null":NICK_NAME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(DEPARTMENT==null?"null":DEPARTMENT, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(JOB==null?"null":JOB, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(ORGANIZATION==null?"null":ORGANIZATION, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(FLAG==null?"null":FLAG, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(CREATE_TIME==null?"null":CREATE_TIME, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(UPDATE_TIME==null?"null":UPDATE_TIME, delimiters));
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
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ID = null; } else {
      this.ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.LAST_NAME = null; } else {
      this.LAST_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.FIRST_NAME = null; } else {
      this.FIRST_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.PHONE_ARR = null; } else {
      this.PHONE_ARR = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.EMAIL_ARR = null; } else {
      this.EMAIL_ARR = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.ADDRESS_ARR = null; } else {
      this.ADDRESS_ARR = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.MIDDLE_NAME = null; } else {
      this.MIDDLE_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.NOTES = null; } else {
      this.NOTES = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.BIRTHDAY = null; } else {
      this.BIRTHDAY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.NICK_NAME = null; } else {
      this.NICK_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.DEPARTMENT = null; } else {
      this.DEPARTMENT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.JOB = null; } else {
      this.JOB = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.ORGANIZATION = null; } else {
      this.ORGANIZATION = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.FLAG = null; } else {
      this.FLAG = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.CREATE_TIME = null; } else {
      this.CREATE_TIME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.UPDATE_TIME = null; } else {
      this.UPDATE_TIME = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ID = null; } else {
      this.ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.USER_ID = null; } else {
      this.USER_ID = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.LAST_NAME = null; } else {
      this.LAST_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.FIRST_NAME = null; } else {
      this.FIRST_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.PHONE_ARR = null; } else {
      this.PHONE_ARR = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.EMAIL_ARR = null; } else {
      this.EMAIL_ARR = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.ADDRESS_ARR = null; } else {
      this.ADDRESS_ARR = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.MIDDLE_NAME = null; } else {
      this.MIDDLE_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.NOTES = null; } else {
      this.NOTES = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.BIRTHDAY = null; } else {
      this.BIRTHDAY = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.NICK_NAME = null; } else {
      this.NICK_NAME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.DEPARTMENT = null; } else {
      this.DEPARTMENT = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.JOB = null; } else {
      this.JOB = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.ORGANIZATION = null; } else {
      this.ORGANIZATION = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.FLAG = null; } else {
      this.FLAG = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.CREATE_TIME = null; } else {
      this.CREATE_TIME = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.UPDATE_TIME = null; } else {
      this.UPDATE_TIME = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    USER_RELATION_PERSON_INFO_TEST o = (USER_RELATION_PERSON_INFO_TEST) super.clone();
    return o;
  }

  public void clone0(USER_RELATION_PERSON_INFO_TEST o) throws CloneNotSupportedException {
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("ID", this.ID);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("LAST_NAME", this.LAST_NAME);
    __sqoop$field_map.put("FIRST_NAME", this.FIRST_NAME);
    __sqoop$field_map.put("PHONE_ARR", this.PHONE_ARR);
    __sqoop$field_map.put("EMAIL_ARR", this.EMAIL_ARR);
    __sqoop$field_map.put("ADDRESS_ARR", this.ADDRESS_ARR);
    __sqoop$field_map.put("MIDDLE_NAME", this.MIDDLE_NAME);
    __sqoop$field_map.put("NOTES", this.NOTES);
    __sqoop$field_map.put("BIRTHDAY", this.BIRTHDAY);
    __sqoop$field_map.put("NICK_NAME", this.NICK_NAME);
    __sqoop$field_map.put("DEPARTMENT", this.DEPARTMENT);
    __sqoop$field_map.put("JOB", this.JOB);
    __sqoop$field_map.put("ORGANIZATION", this.ORGANIZATION);
    __sqoop$field_map.put("FLAG", this.FLAG);
    __sqoop$field_map.put("CREATE_TIME", this.CREATE_TIME);
    __sqoop$field_map.put("UPDATE_TIME", this.UPDATE_TIME);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("ID", this.ID);
    __sqoop$field_map.put("USER_ID", this.USER_ID);
    __sqoop$field_map.put("LAST_NAME", this.LAST_NAME);
    __sqoop$field_map.put("FIRST_NAME", this.FIRST_NAME);
    __sqoop$field_map.put("PHONE_ARR", this.PHONE_ARR);
    __sqoop$field_map.put("EMAIL_ARR", this.EMAIL_ARR);
    __sqoop$field_map.put("ADDRESS_ARR", this.ADDRESS_ARR);
    __sqoop$field_map.put("MIDDLE_NAME", this.MIDDLE_NAME);
    __sqoop$field_map.put("NOTES", this.NOTES);
    __sqoop$field_map.put("BIRTHDAY", this.BIRTHDAY);
    __sqoop$field_map.put("NICK_NAME", this.NICK_NAME);
    __sqoop$field_map.put("DEPARTMENT", this.DEPARTMENT);
    __sqoop$field_map.put("JOB", this.JOB);
    __sqoop$field_map.put("ORGANIZATION", this.ORGANIZATION);
    __sqoop$field_map.put("FLAG", this.FLAG);
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
    else    if ("LAST_NAME".equals(__fieldName)) {
      this.LAST_NAME = (String) __fieldVal;
    }
    else    if ("FIRST_NAME".equals(__fieldName)) {
      this.FIRST_NAME = (String) __fieldVal;
    }
    else    if ("PHONE_ARR".equals(__fieldName)) {
      this.PHONE_ARR = (String) __fieldVal;
    }
    else    if ("EMAIL_ARR".equals(__fieldName)) {
      this.EMAIL_ARR = (String) __fieldVal;
    }
    else    if ("ADDRESS_ARR".equals(__fieldName)) {
      this.ADDRESS_ARR = (String) __fieldVal;
    }
    else    if ("MIDDLE_NAME".equals(__fieldName)) {
      this.MIDDLE_NAME = (String) __fieldVal;
    }
    else    if ("NOTES".equals(__fieldName)) {
      this.NOTES = (String) __fieldVal;
    }
    else    if ("BIRTHDAY".equals(__fieldName)) {
      this.BIRTHDAY = (String) __fieldVal;
    }
    else    if ("NICK_NAME".equals(__fieldName)) {
      this.NICK_NAME = (String) __fieldVal;
    }
    else    if ("DEPARTMENT".equals(__fieldName)) {
      this.DEPARTMENT = (String) __fieldVal;
    }
    else    if ("JOB".equals(__fieldName)) {
      this.JOB = (String) __fieldVal;
    }
    else    if ("ORGANIZATION".equals(__fieldName)) {
      this.ORGANIZATION = (String) __fieldVal;
    }
    else    if ("FLAG".equals(__fieldName)) {
      this.FLAG = (String) __fieldVal;
    }
    else    if ("CREATE_TIME".equals(__fieldName)) {
      this.CREATE_TIME = (String) __fieldVal;
    }
    else    if ("UPDATE_TIME".equals(__fieldName)) {
      this.UPDATE_TIME = (String) __fieldVal;
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
    else    if ("LAST_NAME".equals(__fieldName)) {
      this.LAST_NAME = (String) __fieldVal;
      return true;
    }
    else    if ("FIRST_NAME".equals(__fieldName)) {
      this.FIRST_NAME = (String) __fieldVal;
      return true;
    }
    else    if ("PHONE_ARR".equals(__fieldName)) {
      this.PHONE_ARR = (String) __fieldVal;
      return true;
    }
    else    if ("EMAIL_ARR".equals(__fieldName)) {
      this.EMAIL_ARR = (String) __fieldVal;
      return true;
    }
    else    if ("ADDRESS_ARR".equals(__fieldName)) {
      this.ADDRESS_ARR = (String) __fieldVal;
      return true;
    }
    else    if ("MIDDLE_NAME".equals(__fieldName)) {
      this.MIDDLE_NAME = (String) __fieldVal;
      return true;
    }
    else    if ("NOTES".equals(__fieldName)) {
      this.NOTES = (String) __fieldVal;
      return true;
    }
    else    if ("BIRTHDAY".equals(__fieldName)) {
      this.BIRTHDAY = (String) __fieldVal;
      return true;
    }
    else    if ("NICK_NAME".equals(__fieldName)) {
      this.NICK_NAME = (String) __fieldVal;
      return true;
    }
    else    if ("DEPARTMENT".equals(__fieldName)) {
      this.DEPARTMENT = (String) __fieldVal;
      return true;
    }
    else    if ("JOB".equals(__fieldName)) {
      this.JOB = (String) __fieldVal;
      return true;
    }
    else    if ("ORGANIZATION".equals(__fieldName)) {
      this.ORGANIZATION = (String) __fieldVal;
      return true;
    }
    else    if ("FLAG".equals(__fieldName)) {
      this.FLAG = (String) __fieldVal;
      return true;
    }
    else    if ("CREATE_TIME".equals(__fieldName)) {
      this.CREATE_TIME = (String) __fieldVal;
      return true;
    }
    else    if ("UPDATE_TIME".equals(__fieldName)) {
      this.UPDATE_TIME = (String) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
