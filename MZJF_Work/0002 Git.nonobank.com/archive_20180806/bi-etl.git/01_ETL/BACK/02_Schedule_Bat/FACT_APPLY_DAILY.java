// ORM class for table 'FACT_APPLY_DAILY'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Fri Jun 30 18:39:46 CST 2017
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

public class FACT_APPLY_DAILY extends SqoopRecord  implements DBWritable, Writable {
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
  public FACT_APPLY_DAILY with_stat_date(Integer stat_date) {
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
  public FACT_APPLY_DAILY with_apply_no(Long apply_no) {
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
  public FACT_APPLY_DAILY with_apply_name(String apply_name) {
    this.apply_name = apply_name;
    return this;
  }
  private String identity_card_id;
  public String get_identity_card_id() {
    return identity_card_id;
  }
  public void set_identity_card_id(String identity_card_id) {
    this.identity_card_id = identity_card_id;
  }
  public FACT_APPLY_DAILY with_identity_card_id(String identity_card_id) {
    this.identity_card_id = identity_card_id;
    return this;
  }
  private Integer age;
  public Integer get_age() {
    return age;
  }
  public void set_age(Integer age) {
    this.age = age;
  }
  public FACT_APPLY_DAILY with_age(Integer age) {
    this.age = age;
    return this;
  }
  private String sex;
  public String get_sex() {
    return sex;
  }
  public void set_sex(String sex) {
    this.sex = sex;
  }
  public FACT_APPLY_DAILY with_sex(String sex) {
    this.sex = sex;
    return this;
  }
  private String huji_province;
  public String get_huji_province() {
    return huji_province;
  }
  public void set_huji_province(String huji_province) {
    this.huji_province = huji_province;
  }
  public FACT_APPLY_DAILY with_huji_province(String huji_province) {
    this.huji_province = huji_province;
    return this;
  }
  private String huji_city;
  public String get_huji_city() {
    return huji_city;
  }
  public void set_huji_city(String huji_city) {
    this.huji_city = huji_city;
  }
  public FACT_APPLY_DAILY with_huji_city(String huji_city) {
    this.huji_city = huji_city;
    return this;
  }
  private String current_province;
  public String get_current_province() {
    return current_province;
  }
  public void set_current_province(String current_province) {
    this.current_province = current_province;
  }
  public FACT_APPLY_DAILY with_current_province(String current_province) {
    this.current_province = current_province;
    return this;
  }
  private String current_city;
  public String get_current_city() {
    return current_city;
  }
  public void set_current_city(String current_city) {
    this.current_city = current_city;
  }
  public FACT_APPLY_DAILY with_current_city(String current_city) {
    this.current_city = current_city;
    return this;
  }
  private String school_name;
  public String get_school_name() {
    return school_name;
  }
  public void set_school_name(String school_name) {
    this.school_name = school_name;
  }
  public FACT_APPLY_DAILY with_school_name(String school_name) {
    this.school_name = school_name;
    return this;
  }
  private String school_type;
  public String get_school_type() {
    return school_type;
  }
  public void set_school_type(String school_type) {
    this.school_type = school_type;
  }
  public FACT_APPLY_DAILY with_school_type(String school_type) {
    this.school_type = school_type;
    return this;
  }
  private String school_city;
  public String get_school_city() {
    return school_city;
  }
  public void set_school_city(String school_city) {
    this.school_city = school_city;
  }
  public FACT_APPLY_DAILY with_school_city(String school_city) {
    this.school_city = school_city;
    return this;
  }
  private String school_province;
  public String get_school_province() {
    return school_province;
  }
  public void set_school_province(String school_province) {
    this.school_province = school_province;
  }
  public FACT_APPLY_DAILY with_school_province(String school_province) {
    this.school_province = school_province;
    return this;
  }
  private String major_name;
  public String get_major_name() {
    return major_name;
  }
  public void set_major_name(String major_name) {
    this.major_name = major_name;
  }
  public FACT_APPLY_DAILY with_major_name(String major_name) {
    this.major_name = major_name;
    return this;
  }
  private String grade;
  public String get_grade() {
    return grade;
  }
  public void set_grade(String grade) {
    this.grade = grade;
  }
  public FACT_APPLY_DAILY with_grade(String grade) {
    this.grade = grade;
    return this;
  }
  private String education;
  public String get_education() {
    return education;
  }
  public void set_education(String education) {
    this.education = education;
  }
  public FACT_APPLY_DAILY with_education(String education) {
    this.education = education;
    return this;
  }
  private String enter_school_date;
  public String get_enter_school_date() {
    return enter_school_date;
  }
  public void set_enter_school_date(String enter_school_date) {
    this.enter_school_date = enter_school_date;
  }
  public FACT_APPLY_DAILY with_enter_school_date(String enter_school_date) {
    this.enter_school_date = enter_school_date;
    return this;
  }
  private Integer graduate_flag;
  public Integer get_graduate_flag() {
    return graduate_flag;
  }
  public void set_graduate_flag(Integer graduate_flag) {
    this.graduate_flag = graduate_flag;
  }
  public FACT_APPLY_DAILY with_graduate_flag(Integer graduate_flag) {
    this.graduate_flag = graduate_flag;
    return this;
  }
  private String graduate_date;
  public String get_graduate_date() {
    return graduate_date;
  }
  public void set_graduate_date(String graduate_date) {
    this.graduate_date = graduate_date;
  }
  public FACT_APPLY_DAILY with_graduate_date(String graduate_date) {
    this.graduate_date = graduate_date;
    return this;
  }
  private String phone_no;
  public String get_phone_no() {
    return phone_no;
  }
  public void set_phone_no(String phone_no) {
    this.phone_no = phone_no;
  }
  public FACT_APPLY_DAILY with_phone_no(String phone_no) {
    this.phone_no = phone_no;
    return this;
  }
  private String phone_instructor_no;
  public String get_phone_instructor_no() {
    return phone_instructor_no;
  }
  public void set_phone_instructor_no(String phone_instructor_no) {
    this.phone_instructor_no = phone_instructor_no;
  }
  public FACT_APPLY_DAILY with_phone_instructor_no(String phone_instructor_no) {
    this.phone_instructor_no = phone_instructor_no;
    return this;
  }
  private String phone_parents_no;
  public String get_phone_parents_no() {
    return phone_parents_no;
  }
  public void set_phone_parents_no(String phone_parents_no) {
    this.phone_parents_no = phone_parents_no;
  }
  public FACT_APPLY_DAILY with_phone_parents_no(String phone_parents_no) {
    this.phone_parents_no = phone_parents_no;
    return this;
  }
  private String phone_contact1_no;
  public String get_phone_contact1_no() {
    return phone_contact1_no;
  }
  public void set_phone_contact1_no(String phone_contact1_no) {
    this.phone_contact1_no = phone_contact1_no;
  }
  public FACT_APPLY_DAILY with_phone_contact1_no(String phone_contact1_no) {
    this.phone_contact1_no = phone_contact1_no;
    return this;
  }
  private String phone_contact2_no;
  public String get_phone_contact2_no() {
    return phone_contact2_no;
  }
  public void set_phone_contact2_no(String phone_contact2_no) {
    this.phone_contact2_no = phone_contact2_no;
  }
  public FACT_APPLY_DAILY with_phone_contact2_no(String phone_contact2_no) {
    this.phone_contact2_no = phone_contact2_no;
    return this;
  }
  private String phone_contact3_no;
  public String get_phone_contact3_no() {
    return phone_contact3_no;
  }
  public void set_phone_contact3_no(String phone_contact3_no) {
    this.phone_contact3_no = phone_contact3_no;
  }
  public FACT_APPLY_DAILY with_phone_contact3_no(String phone_contact3_no) {
    this.phone_contact3_no = phone_contact3_no;
    return this;
  }
  private String qq;
  public String get_qq() {
    return qq;
  }
  public void set_qq(String qq) {
    this.qq = qq;
  }
  public FACT_APPLY_DAILY with_qq(String qq) {
    this.qq = qq;
    return this;
  }
  private String email;
  public String get_email() {
    return email;
  }
  public void set_email(String email) {
    this.email = email;
  }
  public FACT_APPLY_DAILY with_email(String email) {
    this.email = email;
    return this;
  }
  private String occupation;
  public String get_occupation() {
    return occupation;
  }
  public void set_occupation(String occupation) {
    this.occupation = occupation;
  }
  public FACT_APPLY_DAILY with_occupation(String occupation) {
    this.occupation = occupation;
    return this;
  }
  private Integer working_year;
  public Integer get_working_year() {
    return working_year;
  }
  public void set_working_year(Integer working_year) {
    this.working_year = working_year;
  }
  public FACT_APPLY_DAILY with_working_year(Integer working_year) {
    this.working_year = working_year;
    return this;
  }
  private String company_name;
  public String get_company_name() {
    return company_name;
  }
  public void set_company_name(String company_name) {
    this.company_name = company_name;
  }
  public FACT_APPLY_DAILY with_company_name(String company_name) {
    this.company_name = company_name;
    return this;
  }
  private Integer company_type;
  public Integer get_company_type() {
    return company_type;
  }
  public void set_company_type(Integer company_type) {
    this.company_type = company_type;
  }
  public FACT_APPLY_DAILY with_company_type(Integer company_type) {
    this.company_type = company_type;
    return this;
  }
  private String phone_company_no;
  public String get_phone_company_no() {
    return phone_company_no;
  }
  public void set_phone_company_no(String phone_company_no) {
    this.phone_company_no = phone_company_no;
  }
  public FACT_APPLY_DAILY with_phone_company_no(String phone_company_no) {
    this.phone_company_no = phone_company_no;
    return this;
  }
  private java.sql.Timestamp apply_date;
  public java.sql.Timestamp get_apply_date() {
    return apply_date;
  }
  public void set_apply_date(java.sql.Timestamp apply_date) {
    this.apply_date = apply_date;
  }
  public FACT_APPLY_DAILY with_apply_date(java.sql.Timestamp apply_date) {
    this.apply_date = apply_date;
    return this;
  }
  private String product;
  public String get_product() {
    return product;
  }
  public void set_product(String product) {
    this.product = product;
  }
  public FACT_APPLY_DAILY with_product(String product) {
    this.product = product;
    return this;
  }
  private java.math.BigDecimal apply_amt;
  public java.math.BigDecimal get_apply_amt() {
    return apply_amt;
  }
  public void set_apply_amt(java.math.BigDecimal apply_amt) {
    this.apply_amt = apply_amt;
  }
  public FACT_APPLY_DAILY with_apply_amt(java.math.BigDecimal apply_amt) {
    this.apply_amt = apply_amt;
    return this;
  }
  private Integer apply_term;
  public Integer get_apply_term() {
    return apply_term;
  }
  public void set_apply_term(Integer apply_term) {
    this.apply_term = apply_term;
  }
  public FACT_APPLY_DAILY with_apply_term(Integer apply_term) {
    this.apply_term = apply_term;
    return this;
  }
  private String sign_result;
  public String get_sign_result() {
    return sign_result;
  }
  public void set_sign_result(String sign_result) {
    this.sign_result = sign_result;
  }
  public FACT_APPLY_DAILY with_sign_result(String sign_result) {
    this.sign_result = sign_result;
    return this;
  }
  private String approve_result;
  public String get_approve_result() {
    return approve_result;
  }
  public void set_approve_result(String approve_result) {
    this.approve_result = approve_result;
  }
  public FACT_APPLY_DAILY with_approve_result(String approve_result) {
    this.approve_result = approve_result;
    return this;
  }
  private java.math.BigDecimal approve_amt;
  public java.math.BigDecimal get_approve_amt() {
    return approve_amt;
  }
  public void set_approve_amt(java.math.BigDecimal approve_amt) {
    this.approve_amt = approve_amt;
  }
  public FACT_APPLY_DAILY with_approve_amt(java.math.BigDecimal approve_amt) {
    this.approve_amt = approve_amt;
    return this;
  }
  private String refuse_reason;
  public String get_refuse_reason() {
    return refuse_reason;
  }
  public void set_refuse_reason(String refuse_reason) {
    this.refuse_reason = refuse_reason;
  }
  public FACT_APPLY_DAILY with_refuse_reason(String refuse_reason) {
    this.refuse_reason = refuse_reason;
    return this;
  }
  private String cancell_reason;
  public String get_cancell_reason() {
    return cancell_reason;
  }
  public void set_cancell_reason(String cancell_reason) {
    this.cancell_reason = cancell_reason;
  }
  public FACT_APPLY_DAILY with_cancell_reason(String cancell_reason) {
    this.cancell_reason = cancell_reason;
    return this;
  }
  private String back_reason;
  public String get_back_reason() {
    return back_reason;
  }
  public void set_back_reason(String back_reason) {
    this.back_reason = back_reason;
  }
  public FACT_APPLY_DAILY with_back_reason(String back_reason) {
    this.back_reason = back_reason;
    return this;
  }
  private String channel;
  public String get_channel() {
    return channel;
  }
  public void set_channel(String channel) {
    this.channel = channel;
  }
  public FACT_APPLY_DAILY with_channel(String channel) {
    this.channel = channel;
    return this;
  }
  private String resource;
  public String get_resource() {
    return resource;
  }
  public void set_resource(String resource) {
    this.resource = resource;
  }
  public FACT_APPLY_DAILY with_resource(String resource) {
    this.resource = resource;
    return this;
  }
  private String purpose;
  public String get_purpose() {
    return purpose;
  }
  public void set_purpose(String purpose) {
    this.purpose = purpose;
  }
  public FACT_APPLY_DAILY with_purpose(String purpose) {
    this.purpose = purpose;
    return this;
  }
  private String score;
  public String get_score() {
    return score;
  }
  public void set_score(String score) {
    this.score = score;
  }
  public FACT_APPLY_DAILY with_score(String score) {
    this.score = score;
    return this;
  }
  private String level;
  public String get_level() {
    return level;
  }
  public void set_level(String level) {
    this.level = level;
  }
  public FACT_APPLY_DAILY with_level(String level) {
    this.level = level;
    return this;
  }
  private Integer video_flag;
  public Integer get_video_flag() {
    return video_flag;
  }
  public void set_video_flag(Integer video_flag) {
    this.video_flag = video_flag;
  }
  public FACT_APPLY_DAILY with_video_flag(Integer video_flag) {
    this.video_flag = video_flag;
    return this;
  }
  private String phonecall_flag;
  public String get_phonecall_flag() {
    return phonecall_flag;
  }
  public void set_phonecall_flag(String phonecall_flag) {
    this.phonecall_flag = phonecall_flag;
  }
  public FACT_APPLY_DAILY with_phonecall_flag(String phonecall_flag) {
    this.phonecall_flag = phonecall_flag;
    return this;
  }
  private String phonecall_parents_flag;
  public String get_phonecall_parents_flag() {
    return phonecall_parents_flag;
  }
  public void set_phonecall_parents_flag(String phonecall_parents_flag) {
    this.phonecall_parents_flag = phonecall_parents_flag;
  }
  public FACT_APPLY_DAILY with_phonecall_parents_flag(String phonecall_parents_flag) {
    this.phonecall_parents_flag = phonecall_parents_flag;
    return this;
  }
  private String phonecall_guider_flag;
  public String get_phonecall_guider_flag() {
    return phonecall_guider_flag;
  }
  public void set_phonecall_guider_flag(String phonecall_guider_flag) {
    this.phonecall_guider_flag = phonecall_guider_flag;
  }
  public FACT_APPLY_DAILY with_phonecall_guider_flag(String phonecall_guider_flag) {
    this.phonecall_guider_flag = phonecall_guider_flag;
    return this;
  }
  private String phonecall_contact1_flag;
  public String get_phonecall_contact1_flag() {
    return phonecall_contact1_flag;
  }
  public void set_phonecall_contact1_flag(String phonecall_contact1_flag) {
    this.phonecall_contact1_flag = phonecall_contact1_flag;
  }
  public FACT_APPLY_DAILY with_phonecall_contact1_flag(String phonecall_contact1_flag) {
    this.phonecall_contact1_flag = phonecall_contact1_flag;
    return this;
  }
  private String phonecall_contact2_flag;
  public String get_phonecall_contact2_flag() {
    return phonecall_contact2_flag;
  }
  public void set_phonecall_contact2_flag(String phonecall_contact2_flag) {
    this.phonecall_contact2_flag = phonecall_contact2_flag;
  }
  public FACT_APPLY_DAILY with_phonecall_contact2_flag(String phonecall_contact2_flag) {
    this.phonecall_contact2_flag = phonecall_contact2_flag;
    return this;
  }
  private String phonecall_contact3_flag;
  public String get_phonecall_contact3_flag() {
    return phonecall_contact3_flag;
  }
  public void set_phonecall_contact3_flag(String phonecall_contact3_flag) {
    this.phonecall_contact3_flag = phonecall_contact3_flag;
  }
  public FACT_APPLY_DAILY with_phonecall_contact3_flag(String phonecall_contact3_flag) {
    this.phonecall_contact3_flag = phonecall_contact3_flag;
    return this;
  }
  private String register_ip;
  public String get_register_ip() {
    return register_ip;
  }
  public void set_register_ip(String register_ip) {
    this.register_ip = register_ip;
  }
  public FACT_APPLY_DAILY with_register_ip(String register_ip) {
    this.register_ip = register_ip;
    return this;
  }
  private Integer student_certificate1_flag;
  public Integer get_student_certificate1_flag() {
    return student_certificate1_flag;
  }
  public void set_student_certificate1_flag(Integer student_certificate1_flag) {
    this.student_certificate1_flag = student_certificate1_flag;
  }
  public FACT_APPLY_DAILY with_student_certificate1_flag(Integer student_certificate1_flag) {
    this.student_certificate1_flag = student_certificate1_flag;
    return this;
  }
  private Integer student_certificate2_flag;
  public Integer get_student_certificate2_flag() {
    return student_certificate2_flag;
  }
  public void set_student_certificate2_flag(Integer student_certificate2_flag) {
    this.student_certificate2_flag = student_certificate2_flag;
  }
  public FACT_APPLY_DAILY with_student_certificate2_flag(Integer student_certificate2_flag) {
    this.student_certificate2_flag = student_certificate2_flag;
    return this;
  }
  private Integer insurance_society_flag;
  public Integer get_insurance_society_flag() {
    return insurance_society_flag;
  }
  public void set_insurance_society_flag(Integer insurance_society_flag) {
    this.insurance_society_flag = insurance_society_flag;
  }
  public FACT_APPLY_DAILY with_insurance_society_flag(Integer insurance_society_flag) {
    this.insurance_society_flag = insurance_society_flag;
    return this;
  }
  private Integer family_income_amt;
  public Integer get_family_income_amt() {
    return family_income_amt;
  }
  public void set_family_income_amt(Integer family_income_amt) {
    this.family_income_amt = family_income_amt;
  }
  public FACT_APPLY_DAILY with_family_income_amt(Integer family_income_amt) {
    this.family_income_amt = family_income_amt;
    return this;
  }
  private Integer fraud_flag;
  public Integer get_fraud_flag() {
    return fraud_flag;
  }
  public void set_fraud_flag(Integer fraud_flag) {
    this.fraud_flag = fraud_flag;
  }
  public FACT_APPLY_DAILY with_fraud_flag(Integer fraud_flag) {
    this.fraud_flag = fraud_flag;
    return this;
  }
  private String fraud_type;
  public String get_fraud_type() {
    return fraud_type;
  }
  public void set_fraud_type(String fraud_type) {
    this.fraud_type = fraud_type;
  }
  public FACT_APPLY_DAILY with_fraud_type(String fraud_type) {
    this.fraud_type = fraud_type;
    return this;
  }
  private String merchant_name;
  public String get_merchant_name() {
    return merchant_name;
  }
  public void set_merchant_name(String merchant_name) {
    this.merchant_name = merchant_name;
  }
  public FACT_APPLY_DAILY with_merchant_name(String merchant_name) {
    this.merchant_name = merchant_name;
    return this;
  }
  private String counsellor_name;
  public String get_counsellor_name() {
    return counsellor_name;
  }
  public void set_counsellor_name(String counsellor_name) {
    this.counsellor_name = counsellor_name;
  }
  public FACT_APPLY_DAILY with_counsellor_name(String counsellor_name) {
    this.counsellor_name = counsellor_name;
    return this;
  }
  private String parent_name;
  public String get_parent_name() {
    return parent_name;
  }
  public void set_parent_name(String parent_name) {
    this.parent_name = parent_name;
  }
  public FACT_APPLY_DAILY with_parent_name(String parent_name) {
    this.parent_name = parent_name;
    return this;
  }
  private String contact_name1;
  public String get_contact_name1() {
    return contact_name1;
  }
  public void set_contact_name1(String contact_name1) {
    this.contact_name1 = contact_name1;
  }
  public FACT_APPLY_DAILY with_contact_name1(String contact_name1) {
    this.contact_name1 = contact_name1;
    return this;
  }
  private String contact_name2;
  public String get_contact_name2() {
    return contact_name2;
  }
  public void set_contact_name2(String contact_name2) {
    this.contact_name2 = contact_name2;
  }
  public FACT_APPLY_DAILY with_contact_name2(String contact_name2) {
    this.contact_name2 = contact_name2;
    return this;
  }
  private String contact_name3;
  public String get_contact_name3() {
    return contact_name3;
  }
  public void set_contact_name3(String contact_name3) {
    this.contact_name3 = contact_name3;
  }
  public FACT_APPLY_DAILY with_contact_name3(String contact_name3) {
    this.contact_name3 = contact_name3;
    return this;
  }
  private String counsellor_phone;
  public String get_counsellor_phone() {
    return counsellor_phone;
  }
  public void set_counsellor_phone(String counsellor_phone) {
    this.counsellor_phone = counsellor_phone;
  }
  public FACT_APPLY_DAILY with_counsellor_phone(String counsellor_phone) {
    this.counsellor_phone = counsellor_phone;
    return this;
  }
  private String parent_phone;
  public String get_parent_phone() {
    return parent_phone;
  }
  public void set_parent_phone(String parent_phone) {
    this.parent_phone = parent_phone;
  }
  public FACT_APPLY_DAILY with_parent_phone(String parent_phone) {
    this.parent_phone = parent_phone;
    return this;
  }
  private String contact_phone1;
  public String get_contact_phone1() {
    return contact_phone1;
  }
  public void set_contact_phone1(String contact_phone1) {
    this.contact_phone1 = contact_phone1;
  }
  public FACT_APPLY_DAILY with_contact_phone1(String contact_phone1) {
    this.contact_phone1 = contact_phone1;
    return this;
  }
  private String contact_phone2;
  public String get_contact_phone2() {
    return contact_phone2;
  }
  public void set_contact_phone2(String contact_phone2) {
    this.contact_phone2 = contact_phone2;
  }
  public FACT_APPLY_DAILY with_contact_phone2(String contact_phone2) {
    this.contact_phone2 = contact_phone2;
    return this;
  }
  private String contact_phone3;
  public String get_contact_phone3() {
    return contact_phone3;
  }
  public void set_contact_phone3(String contact_phone3) {
    this.contact_phone3 = contact_phone3;
  }
  public FACT_APPLY_DAILY with_contact_phone3(String contact_phone3) {
    this.contact_phone3 = contact_phone3;
    return this;
  }
  private java.sql.Timestamp am_audit_time;
  public java.sql.Timestamp get_am_audit_time() {
    return am_audit_time;
  }
  public void set_am_audit_time(java.sql.Timestamp am_audit_time) {
    this.am_audit_time = am_audit_time;
  }
  public FACT_APPLY_DAILY with_am_audit_time(java.sql.Timestamp am_audit_time) {
    this.am_audit_time = am_audit_time;
    return this;
  }
  private String home_address;
  public String get_home_address() {
    return home_address;
  }
  public void set_home_address(String home_address) {
    this.home_address = home_address;
  }
  public FACT_APPLY_DAILY with_home_address(String home_address) {
    this.home_address = home_address;
    return this;
  }
  private String bank_card_no;
  public String get_bank_card_no() {
    return bank_card_no;
  }
  public void set_bank_card_no(String bank_card_no) {
    this.bank_card_no = bank_card_no;
  }
  public FACT_APPLY_DAILY with_bank_card_no(String bank_card_no) {
    this.bank_card_no = bank_card_no;
    return this;
  }
  private String bank_name;
  public String get_bank_name() {
    return bank_name;
  }
  public void set_bank_name(String bank_name) {
    this.bank_name = bank_name;
  }
  public FACT_APPLY_DAILY with_bank_name(String bank_name) {
    this.bank_name = bank_name;
    return this;
  }
  private Long user_id;
  public Long get_user_id() {
    return user_id;
  }
  public void set_user_id(Long user_id) {
    this.user_id = user_id;
  }
  public FACT_APPLY_DAILY with_user_id(Long user_id) {
    this.user_id = user_id;
    return this;
  }
  private String auto_decision;
  public String get_auto_decision() {
    return auto_decision;
  }
  public void set_auto_decision(String auto_decision) {
    this.auto_decision = auto_decision;
  }
  public FACT_APPLY_DAILY with_auto_decision(String auto_decision) {
    this.auto_decision = auto_decision;
    return this;
  }
  private java.sql.Timestamp auto_decision_date;
  public java.sql.Timestamp get_auto_decision_date() {
    return auto_decision_date;
  }
  public void set_auto_decision_date(java.sql.Timestamp auto_decision_date) {
    this.auto_decision_date = auto_decision_date;
  }
  public FACT_APPLY_DAILY with_auto_decision_date(java.sql.Timestamp auto_decision_date) {
    this.auto_decision_date = auto_decision_date;
    return this;
  }
  private String isnewuser;
  public String get_isnewuser() {
    return isnewuser;
  }
  public void set_isnewuser(String isnewuser) {
    this.isnewuser = isnewuser;
  }
  public FACT_APPLY_DAILY with_isnewuser(String isnewuser) {
    this.isnewuser = isnewuser;
    return this;
  }
  private String rule_id;
  public String get_rule_id() {
    return rule_id;
  }
  public void set_rule_id(String rule_id) {
    this.rule_id = rule_id;
  }
  public FACT_APPLY_DAILY with_rule_id(String rule_id) {
    this.rule_id = rule_id;
    return this;
  }
  private String is_tongdun;
  public String get_is_tongdun() {
    return is_tongdun;
  }
  public void set_is_tongdun(String is_tongdun) {
    this.is_tongdun = is_tongdun;
  }
  public FACT_APPLY_DAILY with_is_tongdun(String is_tongdun) {
    this.is_tongdun = is_tongdun;
    return this;
  }
  private String is_black_gray;
  public String get_is_black_gray() {
    return is_black_gray;
  }
  public void set_is_black_gray(String is_black_gray) {
    this.is_black_gray = is_black_gray;
  }
  public FACT_APPLY_DAILY with_is_black_gray(String is_black_gray) {
    this.is_black_gray = is_black_gray;
    return this;
  }
  private String userriskbill;
  public String get_userriskbill() {
    return userriskbill;
  }
  public void set_userriskbill(String userriskbill) {
    this.userriskbill = userriskbill;
  }
  public FACT_APPLY_DAILY with_userriskbill(String userriskbill) {
    this.userriskbill = userriskbill;
    return this;
  }
  private String address_home;
  public String get_address_home() {
    return address_home;
  }
  public void set_address_home(String address_home) {
    this.address_home = address_home;
  }
  public FACT_APPLY_DAILY with_address_home(String address_home) {
    this.address_home = address_home;
    return this;
  }
  private String bl_graduate_time;
  public String get_bl_graduate_time() {
    return bl_graduate_time;
  }
  public void set_bl_graduate_time(String bl_graduate_time) {
    this.bl_graduate_time = bl_graduate_time;
  }
  public FACT_APPLY_DAILY with_bl_graduate_time(String bl_graduate_time) {
    this.bl_graduate_time = bl_graduate_time;
    return this;
  }
  private String is_gjj_submit;
  public String get_is_gjj_submit() {
    return is_gjj_submit;
  }
  public void set_is_gjj_submit(String is_gjj_submit) {
    this.is_gjj_submit = is_gjj_submit;
  }
  public FACT_APPLY_DAILY with_is_gjj_submit(String is_gjj_submit) {
    this.is_gjj_submit = is_gjj_submit;
    return this;
  }
  private String mobile_address;
  public String get_mobile_address() {
    return mobile_address;
  }
  public void set_mobile_address(String mobile_address) {
    this.mobile_address = mobile_address;
  }
  public FACT_APPLY_DAILY with_mobile_address(String mobile_address) {
    this.mobile_address = mobile_address;
    return this;
  }
  private String pass_rule;
  public String get_pass_rule() {
    return pass_rule;
  }
  public void set_pass_rule(String pass_rule) {
    this.pass_rule = pass_rule;
  }
  public FACT_APPLY_DAILY with_pass_rule(String pass_rule) {
    this.pass_rule = pass_rule;
    return this;
  }
  private String apply_channel;
  public String get_apply_channel() {
    return apply_channel;
  }
  public void set_apply_channel(String apply_channel) {
    this.apply_channel = apply_channel;
  }
  public FACT_APPLY_DAILY with_apply_channel(String apply_channel) {
    this.apply_channel = apply_channel;
    return this;
  }
  private String auto_decision_code;
  public String get_auto_decision_code() {
    return auto_decision_code;
  }
  public void set_auto_decision_code(String auto_decision_code) {
    this.auto_decision_code = auto_decision_code;
  }
  public FACT_APPLY_DAILY with_auto_decision_code(String auto_decision_code) {
    this.auto_decision_code = auto_decision_code;
    return this;
  }
  private Integer publish_duration;
  public Integer get_publish_duration() {
    return publish_duration;
  }
  public void set_publish_duration(Integer publish_duration) {
    this.publish_duration = publish_duration;
  }
  public FACT_APPLY_DAILY with_publish_duration(Integer publish_duration) {
    this.publish_duration = publish_duration;
    return this;
  }
  private Integer confirm_duration;
  public Integer get_confirm_duration() {
    return confirm_duration;
  }
  public void set_confirm_duration(Integer confirm_duration) {
    this.confirm_duration = confirm_duration;
  }
  public FACT_APPLY_DAILY with_confirm_duration(Integer confirm_duration) {
    this.confirm_duration = confirm_duration;
    return this;
  }
  private Integer lend_duration;
  public Integer get_lend_duration() {
    return lend_duration;
  }
  public void set_lend_duration(Integer lend_duration) {
    this.lend_duration = lend_duration;
  }
  public FACT_APPLY_DAILY with_lend_duration(Integer lend_duration) {
    this.lend_duration = lend_duration;
    return this;
  }
  private String is_stock_campaign;
  public String get_is_stock_campaign() {
    return is_stock_campaign;
  }
  public void set_is_stock_campaign(String is_stock_campaign) {
    this.is_stock_campaign = is_stock_campaign;
  }
  public FACT_APPLY_DAILY with_is_stock_campaign(String is_stock_campaign) {
    this.is_stock_campaign = is_stock_campaign;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof FACT_APPLY_DAILY)) {
      return false;
    }
    FACT_APPLY_DAILY that = (FACT_APPLY_DAILY) o;
    boolean equal = true;
    equal = equal && (this.stat_date == null ? that.stat_date == null : this.stat_date.equals(that.stat_date));
    equal = equal && (this.apply_no == null ? that.apply_no == null : this.apply_no.equals(that.apply_no));
    equal = equal && (this.apply_name == null ? that.apply_name == null : this.apply_name.equals(that.apply_name));
    equal = equal && (this.identity_card_id == null ? that.identity_card_id == null : this.identity_card_id.equals(that.identity_card_id));
    equal = equal && (this.age == null ? that.age == null : this.age.equals(that.age));
    equal = equal && (this.sex == null ? that.sex == null : this.sex.equals(that.sex));
    equal = equal && (this.huji_province == null ? that.huji_province == null : this.huji_province.equals(that.huji_province));
    equal = equal && (this.huji_city == null ? that.huji_city == null : this.huji_city.equals(that.huji_city));
    equal = equal && (this.current_province == null ? that.current_province == null : this.current_province.equals(that.current_province));
    equal = equal && (this.current_city == null ? that.current_city == null : this.current_city.equals(that.current_city));
    equal = equal && (this.school_name == null ? that.school_name == null : this.school_name.equals(that.school_name));
    equal = equal && (this.school_type == null ? that.school_type == null : this.school_type.equals(that.school_type));
    equal = equal && (this.school_city == null ? that.school_city == null : this.school_city.equals(that.school_city));
    equal = equal && (this.school_province == null ? that.school_province == null : this.school_province.equals(that.school_province));
    equal = equal && (this.major_name == null ? that.major_name == null : this.major_name.equals(that.major_name));
    equal = equal && (this.grade == null ? that.grade == null : this.grade.equals(that.grade));
    equal = equal && (this.education == null ? that.education == null : this.education.equals(that.education));
    equal = equal && (this.enter_school_date == null ? that.enter_school_date == null : this.enter_school_date.equals(that.enter_school_date));
    equal = equal && (this.graduate_flag == null ? that.graduate_flag == null : this.graduate_flag.equals(that.graduate_flag));
    equal = equal && (this.graduate_date == null ? that.graduate_date == null : this.graduate_date.equals(that.graduate_date));
    equal = equal && (this.phone_no == null ? that.phone_no == null : this.phone_no.equals(that.phone_no));
    equal = equal && (this.phone_instructor_no == null ? that.phone_instructor_no == null : this.phone_instructor_no.equals(that.phone_instructor_no));
    equal = equal && (this.phone_parents_no == null ? that.phone_parents_no == null : this.phone_parents_no.equals(that.phone_parents_no));
    equal = equal && (this.phone_contact1_no == null ? that.phone_contact1_no == null : this.phone_contact1_no.equals(that.phone_contact1_no));
    equal = equal && (this.phone_contact2_no == null ? that.phone_contact2_no == null : this.phone_contact2_no.equals(that.phone_contact2_no));
    equal = equal && (this.phone_contact3_no == null ? that.phone_contact3_no == null : this.phone_contact3_no.equals(that.phone_contact3_no));
    equal = equal && (this.qq == null ? that.qq == null : this.qq.equals(that.qq));
    equal = equal && (this.email == null ? that.email == null : this.email.equals(that.email));
    equal = equal && (this.occupation == null ? that.occupation == null : this.occupation.equals(that.occupation));
    equal = equal && (this.working_year == null ? that.working_year == null : this.working_year.equals(that.working_year));
    equal = equal && (this.company_name == null ? that.company_name == null : this.company_name.equals(that.company_name));
    equal = equal && (this.company_type == null ? that.company_type == null : this.company_type.equals(that.company_type));
    equal = equal && (this.phone_company_no == null ? that.phone_company_no == null : this.phone_company_no.equals(that.phone_company_no));
    equal = equal && (this.apply_date == null ? that.apply_date == null : this.apply_date.equals(that.apply_date));
    equal = equal && (this.product == null ? that.product == null : this.product.equals(that.product));
    equal = equal && (this.apply_amt == null ? that.apply_amt == null : this.apply_amt.equals(that.apply_amt));
    equal = equal && (this.apply_term == null ? that.apply_term == null : this.apply_term.equals(that.apply_term));
    equal = equal && (this.sign_result == null ? that.sign_result == null : this.sign_result.equals(that.sign_result));
    equal = equal && (this.approve_result == null ? that.approve_result == null : this.approve_result.equals(that.approve_result));
    equal = equal && (this.approve_amt == null ? that.approve_amt == null : this.approve_amt.equals(that.approve_amt));
    equal = equal && (this.refuse_reason == null ? that.refuse_reason == null : this.refuse_reason.equals(that.refuse_reason));
    equal = equal && (this.cancell_reason == null ? that.cancell_reason == null : this.cancell_reason.equals(that.cancell_reason));
    equal = equal && (this.back_reason == null ? that.back_reason == null : this.back_reason.equals(that.back_reason));
    equal = equal && (this.channel == null ? that.channel == null : this.channel.equals(that.channel));
    equal = equal && (this.resource == null ? that.resource == null : this.resource.equals(that.resource));
    equal = equal && (this.purpose == null ? that.purpose == null : this.purpose.equals(that.purpose));
    equal = equal && (this.score == null ? that.score == null : this.score.equals(that.score));
    equal = equal && (this.level == null ? that.level == null : this.level.equals(that.level));
    equal = equal && (this.video_flag == null ? that.video_flag == null : this.video_flag.equals(that.video_flag));
    equal = equal && (this.phonecall_flag == null ? that.phonecall_flag == null : this.phonecall_flag.equals(that.phonecall_flag));
    equal = equal && (this.phonecall_parents_flag == null ? that.phonecall_parents_flag == null : this.phonecall_parents_flag.equals(that.phonecall_parents_flag));
    equal = equal && (this.phonecall_guider_flag == null ? that.phonecall_guider_flag == null : this.phonecall_guider_flag.equals(that.phonecall_guider_flag));
    equal = equal && (this.phonecall_contact1_flag == null ? that.phonecall_contact1_flag == null : this.phonecall_contact1_flag.equals(that.phonecall_contact1_flag));
    equal = equal && (this.phonecall_contact2_flag == null ? that.phonecall_contact2_flag == null : this.phonecall_contact2_flag.equals(that.phonecall_contact2_flag));
    equal = equal && (this.phonecall_contact3_flag == null ? that.phonecall_contact3_flag == null : this.phonecall_contact3_flag.equals(that.phonecall_contact3_flag));
    equal = equal && (this.register_ip == null ? that.register_ip == null : this.register_ip.equals(that.register_ip));
    equal = equal && (this.student_certificate1_flag == null ? that.student_certificate1_flag == null : this.student_certificate1_flag.equals(that.student_certificate1_flag));
    equal = equal && (this.student_certificate2_flag == null ? that.student_certificate2_flag == null : this.student_certificate2_flag.equals(that.student_certificate2_flag));
    equal = equal && (this.insurance_society_flag == null ? that.insurance_society_flag == null : this.insurance_society_flag.equals(that.insurance_society_flag));
    equal = equal && (this.family_income_amt == null ? that.family_income_amt == null : this.family_income_amt.equals(that.family_income_amt));
    equal = equal && (this.fraud_flag == null ? that.fraud_flag == null : this.fraud_flag.equals(that.fraud_flag));
    equal = equal && (this.fraud_type == null ? that.fraud_type == null : this.fraud_type.equals(that.fraud_type));
    equal = equal && (this.merchant_name == null ? that.merchant_name == null : this.merchant_name.equals(that.merchant_name));
    equal = equal && (this.counsellor_name == null ? that.counsellor_name == null : this.counsellor_name.equals(that.counsellor_name));
    equal = equal && (this.parent_name == null ? that.parent_name == null : this.parent_name.equals(that.parent_name));
    equal = equal && (this.contact_name1 == null ? that.contact_name1 == null : this.contact_name1.equals(that.contact_name1));
    equal = equal && (this.contact_name2 == null ? that.contact_name2 == null : this.contact_name2.equals(that.contact_name2));
    equal = equal && (this.contact_name3 == null ? that.contact_name3 == null : this.contact_name3.equals(that.contact_name3));
    equal = equal && (this.counsellor_phone == null ? that.counsellor_phone == null : this.counsellor_phone.equals(that.counsellor_phone));
    equal = equal && (this.parent_phone == null ? that.parent_phone == null : this.parent_phone.equals(that.parent_phone));
    equal = equal && (this.contact_phone1 == null ? that.contact_phone1 == null : this.contact_phone1.equals(that.contact_phone1));
    equal = equal && (this.contact_phone2 == null ? that.contact_phone2 == null : this.contact_phone2.equals(that.contact_phone2));
    equal = equal && (this.contact_phone3 == null ? that.contact_phone3 == null : this.contact_phone3.equals(that.contact_phone3));
    equal = equal && (this.am_audit_time == null ? that.am_audit_time == null : this.am_audit_time.equals(that.am_audit_time));
    equal = equal && (this.home_address == null ? that.home_address == null : this.home_address.equals(that.home_address));
    equal = equal && (this.bank_card_no == null ? that.bank_card_no == null : this.bank_card_no.equals(that.bank_card_no));
    equal = equal && (this.bank_name == null ? that.bank_name == null : this.bank_name.equals(that.bank_name));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.auto_decision == null ? that.auto_decision == null : this.auto_decision.equals(that.auto_decision));
    equal = equal && (this.auto_decision_date == null ? that.auto_decision_date == null : this.auto_decision_date.equals(that.auto_decision_date));
    equal = equal && (this.isnewuser == null ? that.isnewuser == null : this.isnewuser.equals(that.isnewuser));
    equal = equal && (this.rule_id == null ? that.rule_id == null : this.rule_id.equals(that.rule_id));
    equal = equal && (this.is_tongdun == null ? that.is_tongdun == null : this.is_tongdun.equals(that.is_tongdun));
    equal = equal && (this.is_black_gray == null ? that.is_black_gray == null : this.is_black_gray.equals(that.is_black_gray));
    equal = equal && (this.userriskbill == null ? that.userriskbill == null : this.userriskbill.equals(that.userriskbill));
    equal = equal && (this.address_home == null ? that.address_home == null : this.address_home.equals(that.address_home));
    equal = equal && (this.bl_graduate_time == null ? that.bl_graduate_time == null : this.bl_graduate_time.equals(that.bl_graduate_time));
    equal = equal && (this.is_gjj_submit == null ? that.is_gjj_submit == null : this.is_gjj_submit.equals(that.is_gjj_submit));
    equal = equal && (this.mobile_address == null ? that.mobile_address == null : this.mobile_address.equals(that.mobile_address));
    equal = equal && (this.pass_rule == null ? that.pass_rule == null : this.pass_rule.equals(that.pass_rule));
    equal = equal && (this.apply_channel == null ? that.apply_channel == null : this.apply_channel.equals(that.apply_channel));
    equal = equal && (this.auto_decision_code == null ? that.auto_decision_code == null : this.auto_decision_code.equals(that.auto_decision_code));
    equal = equal && (this.publish_duration == null ? that.publish_duration == null : this.publish_duration.equals(that.publish_duration));
    equal = equal && (this.confirm_duration == null ? that.confirm_duration == null : this.confirm_duration.equals(that.confirm_duration));
    equal = equal && (this.lend_duration == null ? that.lend_duration == null : this.lend_duration.equals(that.lend_duration));
    equal = equal && (this.is_stock_campaign == null ? that.is_stock_campaign == null : this.is_stock_campaign.equals(that.is_stock_campaign));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof FACT_APPLY_DAILY)) {
      return false;
    }
    FACT_APPLY_DAILY that = (FACT_APPLY_DAILY) o;
    boolean equal = true;
    equal = equal && (this.stat_date == null ? that.stat_date == null : this.stat_date.equals(that.stat_date));
    equal = equal && (this.apply_no == null ? that.apply_no == null : this.apply_no.equals(that.apply_no));
    equal = equal && (this.apply_name == null ? that.apply_name == null : this.apply_name.equals(that.apply_name));
    equal = equal && (this.identity_card_id == null ? that.identity_card_id == null : this.identity_card_id.equals(that.identity_card_id));
    equal = equal && (this.age == null ? that.age == null : this.age.equals(that.age));
    equal = equal && (this.sex == null ? that.sex == null : this.sex.equals(that.sex));
    equal = equal && (this.huji_province == null ? that.huji_province == null : this.huji_province.equals(that.huji_province));
    equal = equal && (this.huji_city == null ? that.huji_city == null : this.huji_city.equals(that.huji_city));
    equal = equal && (this.current_province == null ? that.current_province == null : this.current_province.equals(that.current_province));
    equal = equal && (this.current_city == null ? that.current_city == null : this.current_city.equals(that.current_city));
    equal = equal && (this.school_name == null ? that.school_name == null : this.school_name.equals(that.school_name));
    equal = equal && (this.school_type == null ? that.school_type == null : this.school_type.equals(that.school_type));
    equal = equal && (this.school_city == null ? that.school_city == null : this.school_city.equals(that.school_city));
    equal = equal && (this.school_province == null ? that.school_province == null : this.school_province.equals(that.school_province));
    equal = equal && (this.major_name == null ? that.major_name == null : this.major_name.equals(that.major_name));
    equal = equal && (this.grade == null ? that.grade == null : this.grade.equals(that.grade));
    equal = equal && (this.education == null ? that.education == null : this.education.equals(that.education));
    equal = equal && (this.enter_school_date == null ? that.enter_school_date == null : this.enter_school_date.equals(that.enter_school_date));
    equal = equal && (this.graduate_flag == null ? that.graduate_flag == null : this.graduate_flag.equals(that.graduate_flag));
    equal = equal && (this.graduate_date == null ? that.graduate_date == null : this.graduate_date.equals(that.graduate_date));
    equal = equal && (this.phone_no == null ? that.phone_no == null : this.phone_no.equals(that.phone_no));
    equal = equal && (this.phone_instructor_no == null ? that.phone_instructor_no == null : this.phone_instructor_no.equals(that.phone_instructor_no));
    equal = equal && (this.phone_parents_no == null ? that.phone_parents_no == null : this.phone_parents_no.equals(that.phone_parents_no));
    equal = equal && (this.phone_contact1_no == null ? that.phone_contact1_no == null : this.phone_contact1_no.equals(that.phone_contact1_no));
    equal = equal && (this.phone_contact2_no == null ? that.phone_contact2_no == null : this.phone_contact2_no.equals(that.phone_contact2_no));
    equal = equal && (this.phone_contact3_no == null ? that.phone_contact3_no == null : this.phone_contact3_no.equals(that.phone_contact3_no));
    equal = equal && (this.qq == null ? that.qq == null : this.qq.equals(that.qq));
    equal = equal && (this.email == null ? that.email == null : this.email.equals(that.email));
    equal = equal && (this.occupation == null ? that.occupation == null : this.occupation.equals(that.occupation));
    equal = equal && (this.working_year == null ? that.working_year == null : this.working_year.equals(that.working_year));
    equal = equal && (this.company_name == null ? that.company_name == null : this.company_name.equals(that.company_name));
    equal = equal && (this.company_type == null ? that.company_type == null : this.company_type.equals(that.company_type));
    equal = equal && (this.phone_company_no == null ? that.phone_company_no == null : this.phone_company_no.equals(that.phone_company_no));
    equal = equal && (this.apply_date == null ? that.apply_date == null : this.apply_date.equals(that.apply_date));
    equal = equal && (this.product == null ? that.product == null : this.product.equals(that.product));
    equal = equal && (this.apply_amt == null ? that.apply_amt == null : this.apply_amt.equals(that.apply_amt));
    equal = equal && (this.apply_term == null ? that.apply_term == null : this.apply_term.equals(that.apply_term));
    equal = equal && (this.sign_result == null ? that.sign_result == null : this.sign_result.equals(that.sign_result));
    equal = equal && (this.approve_result == null ? that.approve_result == null : this.approve_result.equals(that.approve_result));
    equal = equal && (this.approve_amt == null ? that.approve_amt == null : this.approve_amt.equals(that.approve_amt));
    equal = equal && (this.refuse_reason == null ? that.refuse_reason == null : this.refuse_reason.equals(that.refuse_reason));
    equal = equal && (this.cancell_reason == null ? that.cancell_reason == null : this.cancell_reason.equals(that.cancell_reason));
    equal = equal && (this.back_reason == null ? that.back_reason == null : this.back_reason.equals(that.back_reason));
    equal = equal && (this.channel == null ? that.channel == null : this.channel.equals(that.channel));
    equal = equal && (this.resource == null ? that.resource == null : this.resource.equals(that.resource));
    equal = equal && (this.purpose == null ? that.purpose == null : this.purpose.equals(that.purpose));
    equal = equal && (this.score == null ? that.score == null : this.score.equals(that.score));
    equal = equal && (this.level == null ? that.level == null : this.level.equals(that.level));
    equal = equal && (this.video_flag == null ? that.video_flag == null : this.video_flag.equals(that.video_flag));
    equal = equal && (this.phonecall_flag == null ? that.phonecall_flag == null : this.phonecall_flag.equals(that.phonecall_flag));
    equal = equal && (this.phonecall_parents_flag == null ? that.phonecall_parents_flag == null : this.phonecall_parents_flag.equals(that.phonecall_parents_flag));
    equal = equal && (this.phonecall_guider_flag == null ? that.phonecall_guider_flag == null : this.phonecall_guider_flag.equals(that.phonecall_guider_flag));
    equal = equal && (this.phonecall_contact1_flag == null ? that.phonecall_contact1_flag == null : this.phonecall_contact1_flag.equals(that.phonecall_contact1_flag));
    equal = equal && (this.phonecall_contact2_flag == null ? that.phonecall_contact2_flag == null : this.phonecall_contact2_flag.equals(that.phonecall_contact2_flag));
    equal = equal && (this.phonecall_contact3_flag == null ? that.phonecall_contact3_flag == null : this.phonecall_contact3_flag.equals(that.phonecall_contact3_flag));
    equal = equal && (this.register_ip == null ? that.register_ip == null : this.register_ip.equals(that.register_ip));
    equal = equal && (this.student_certificate1_flag == null ? that.student_certificate1_flag == null : this.student_certificate1_flag.equals(that.student_certificate1_flag));
    equal = equal && (this.student_certificate2_flag == null ? that.student_certificate2_flag == null : this.student_certificate2_flag.equals(that.student_certificate2_flag));
    equal = equal && (this.insurance_society_flag == null ? that.insurance_society_flag == null : this.insurance_society_flag.equals(that.insurance_society_flag));
    equal = equal && (this.family_income_amt == null ? that.family_income_amt == null : this.family_income_amt.equals(that.family_income_amt));
    equal = equal && (this.fraud_flag == null ? that.fraud_flag == null : this.fraud_flag.equals(that.fraud_flag));
    equal = equal && (this.fraud_type == null ? that.fraud_type == null : this.fraud_type.equals(that.fraud_type));
    equal = equal && (this.merchant_name == null ? that.merchant_name == null : this.merchant_name.equals(that.merchant_name));
    equal = equal && (this.counsellor_name == null ? that.counsellor_name == null : this.counsellor_name.equals(that.counsellor_name));
    equal = equal && (this.parent_name == null ? that.parent_name == null : this.parent_name.equals(that.parent_name));
    equal = equal && (this.contact_name1 == null ? that.contact_name1 == null : this.contact_name1.equals(that.contact_name1));
    equal = equal && (this.contact_name2 == null ? that.contact_name2 == null : this.contact_name2.equals(that.contact_name2));
    equal = equal && (this.contact_name3 == null ? that.contact_name3 == null : this.contact_name3.equals(that.contact_name3));
    equal = equal && (this.counsellor_phone == null ? that.counsellor_phone == null : this.counsellor_phone.equals(that.counsellor_phone));
    equal = equal && (this.parent_phone == null ? that.parent_phone == null : this.parent_phone.equals(that.parent_phone));
    equal = equal && (this.contact_phone1 == null ? that.contact_phone1 == null : this.contact_phone1.equals(that.contact_phone1));
    equal = equal && (this.contact_phone2 == null ? that.contact_phone2 == null : this.contact_phone2.equals(that.contact_phone2));
    equal = equal && (this.contact_phone3 == null ? that.contact_phone3 == null : this.contact_phone3.equals(that.contact_phone3));
    equal = equal && (this.am_audit_time == null ? that.am_audit_time == null : this.am_audit_time.equals(that.am_audit_time));
    equal = equal && (this.home_address == null ? that.home_address == null : this.home_address.equals(that.home_address));
    equal = equal && (this.bank_card_no == null ? that.bank_card_no == null : this.bank_card_no.equals(that.bank_card_no));
    equal = equal && (this.bank_name == null ? that.bank_name == null : this.bank_name.equals(that.bank_name));
    equal = equal && (this.user_id == null ? that.user_id == null : this.user_id.equals(that.user_id));
    equal = equal && (this.auto_decision == null ? that.auto_decision == null : this.auto_decision.equals(that.auto_decision));
    equal = equal && (this.auto_decision_date == null ? that.auto_decision_date == null : this.auto_decision_date.equals(that.auto_decision_date));
    equal = equal && (this.isnewuser == null ? that.isnewuser == null : this.isnewuser.equals(that.isnewuser));
    equal = equal && (this.rule_id == null ? that.rule_id == null : this.rule_id.equals(that.rule_id));
    equal = equal && (this.is_tongdun == null ? that.is_tongdun == null : this.is_tongdun.equals(that.is_tongdun));
    equal = equal && (this.is_black_gray == null ? that.is_black_gray == null : this.is_black_gray.equals(that.is_black_gray));
    equal = equal && (this.userriskbill == null ? that.userriskbill == null : this.userriskbill.equals(that.userriskbill));
    equal = equal && (this.address_home == null ? that.address_home == null : this.address_home.equals(that.address_home));
    equal = equal && (this.bl_graduate_time == null ? that.bl_graduate_time == null : this.bl_graduate_time.equals(that.bl_graduate_time));
    equal = equal && (this.is_gjj_submit == null ? that.is_gjj_submit == null : this.is_gjj_submit.equals(that.is_gjj_submit));
    equal = equal && (this.mobile_address == null ? that.mobile_address == null : this.mobile_address.equals(that.mobile_address));
    equal = equal && (this.pass_rule == null ? that.pass_rule == null : this.pass_rule.equals(that.pass_rule));
    equal = equal && (this.apply_channel == null ? that.apply_channel == null : this.apply_channel.equals(that.apply_channel));
    equal = equal && (this.auto_decision_code == null ? that.auto_decision_code == null : this.auto_decision_code.equals(that.auto_decision_code));
    equal = equal && (this.publish_duration == null ? that.publish_duration == null : this.publish_duration.equals(that.publish_duration));
    equal = equal && (this.confirm_duration == null ? that.confirm_duration == null : this.confirm_duration.equals(that.confirm_duration));
    equal = equal && (this.lend_duration == null ? that.lend_duration == null : this.lend_duration.equals(that.lend_duration));
    equal = equal && (this.is_stock_campaign == null ? that.is_stock_campaign == null : this.is_stock_campaign.equals(that.is_stock_campaign));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.stat_date = JdbcWritableBridge.readInteger(1, __dbResults);
    this.apply_no = JdbcWritableBridge.readLong(2, __dbResults);
    this.apply_name = JdbcWritableBridge.readString(3, __dbResults);
    this.identity_card_id = JdbcWritableBridge.readString(4, __dbResults);
    this.age = JdbcWritableBridge.readInteger(5, __dbResults);
    this.sex = JdbcWritableBridge.readString(6, __dbResults);
    this.huji_province = JdbcWritableBridge.readString(7, __dbResults);
    this.huji_city = JdbcWritableBridge.readString(8, __dbResults);
    this.current_province = JdbcWritableBridge.readString(9, __dbResults);
    this.current_city = JdbcWritableBridge.readString(10, __dbResults);
    this.school_name = JdbcWritableBridge.readString(11, __dbResults);
    this.school_type = JdbcWritableBridge.readString(12, __dbResults);
    this.school_city = JdbcWritableBridge.readString(13, __dbResults);
    this.school_province = JdbcWritableBridge.readString(14, __dbResults);
    this.major_name = JdbcWritableBridge.readString(15, __dbResults);
    this.grade = JdbcWritableBridge.readString(16, __dbResults);
    this.education = JdbcWritableBridge.readString(17, __dbResults);
    this.enter_school_date = JdbcWritableBridge.readString(18, __dbResults);
    this.graduate_flag = JdbcWritableBridge.readInteger(19, __dbResults);
    this.graduate_date = JdbcWritableBridge.readString(20, __dbResults);
    this.phone_no = JdbcWritableBridge.readString(21, __dbResults);
    this.phone_instructor_no = JdbcWritableBridge.readString(22, __dbResults);
    this.phone_parents_no = JdbcWritableBridge.readString(23, __dbResults);
    this.phone_contact1_no = JdbcWritableBridge.readString(24, __dbResults);
    this.phone_contact2_no = JdbcWritableBridge.readString(25, __dbResults);
    this.phone_contact3_no = JdbcWritableBridge.readString(26, __dbResults);
    this.qq = JdbcWritableBridge.readString(27, __dbResults);
    this.email = JdbcWritableBridge.readString(28, __dbResults);
    this.occupation = JdbcWritableBridge.readString(29, __dbResults);
    this.working_year = JdbcWritableBridge.readInteger(30, __dbResults);
    this.company_name = JdbcWritableBridge.readString(31, __dbResults);
    this.company_type = JdbcWritableBridge.readInteger(32, __dbResults);
    this.phone_company_no = JdbcWritableBridge.readString(33, __dbResults);
    this.apply_date = JdbcWritableBridge.readTimestamp(34, __dbResults);
    this.product = JdbcWritableBridge.readString(35, __dbResults);
    this.apply_amt = JdbcWritableBridge.readBigDecimal(36, __dbResults);
    this.apply_term = JdbcWritableBridge.readInteger(37, __dbResults);
    this.sign_result = JdbcWritableBridge.readString(38, __dbResults);
    this.approve_result = JdbcWritableBridge.readString(39, __dbResults);
    this.approve_amt = JdbcWritableBridge.readBigDecimal(40, __dbResults);
    this.refuse_reason = JdbcWritableBridge.readString(41, __dbResults);
    this.cancell_reason = JdbcWritableBridge.readString(42, __dbResults);
    this.back_reason = JdbcWritableBridge.readString(43, __dbResults);
    this.channel = JdbcWritableBridge.readString(44, __dbResults);
    this.resource = JdbcWritableBridge.readString(45, __dbResults);
    this.purpose = JdbcWritableBridge.readString(46, __dbResults);
    this.score = JdbcWritableBridge.readString(47, __dbResults);
    this.level = JdbcWritableBridge.readString(48, __dbResults);
    this.video_flag = JdbcWritableBridge.readInteger(49, __dbResults);
    this.phonecall_flag = JdbcWritableBridge.readString(50, __dbResults);
    this.phonecall_parents_flag = JdbcWritableBridge.readString(51, __dbResults);
    this.phonecall_guider_flag = JdbcWritableBridge.readString(52, __dbResults);
    this.phonecall_contact1_flag = JdbcWritableBridge.readString(53, __dbResults);
    this.phonecall_contact2_flag = JdbcWritableBridge.readString(54, __dbResults);
    this.phonecall_contact3_flag = JdbcWritableBridge.readString(55, __dbResults);
    this.register_ip = JdbcWritableBridge.readString(56, __dbResults);
    this.student_certificate1_flag = JdbcWritableBridge.readInteger(57, __dbResults);
    this.student_certificate2_flag = JdbcWritableBridge.readInteger(58, __dbResults);
    this.insurance_society_flag = JdbcWritableBridge.readInteger(59, __dbResults);
    this.family_income_amt = JdbcWritableBridge.readInteger(60, __dbResults);
    this.fraud_flag = JdbcWritableBridge.readInteger(61, __dbResults);
    this.fraud_type = JdbcWritableBridge.readString(62, __dbResults);
    this.merchant_name = JdbcWritableBridge.readString(63, __dbResults);
    this.counsellor_name = JdbcWritableBridge.readString(64, __dbResults);
    this.parent_name = JdbcWritableBridge.readString(65, __dbResults);
    this.contact_name1 = JdbcWritableBridge.readString(66, __dbResults);
    this.contact_name2 = JdbcWritableBridge.readString(67, __dbResults);
    this.contact_name3 = JdbcWritableBridge.readString(68, __dbResults);
    this.counsellor_phone = JdbcWritableBridge.readString(69, __dbResults);
    this.parent_phone = JdbcWritableBridge.readString(70, __dbResults);
    this.contact_phone1 = JdbcWritableBridge.readString(71, __dbResults);
    this.contact_phone2 = JdbcWritableBridge.readString(72, __dbResults);
    this.contact_phone3 = JdbcWritableBridge.readString(73, __dbResults);
    this.am_audit_time = JdbcWritableBridge.readTimestamp(74, __dbResults);
    this.home_address = JdbcWritableBridge.readString(75, __dbResults);
    this.bank_card_no = JdbcWritableBridge.readString(76, __dbResults);
    this.bank_name = JdbcWritableBridge.readString(77, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(78, __dbResults);
    this.auto_decision = JdbcWritableBridge.readString(79, __dbResults);
    this.auto_decision_date = JdbcWritableBridge.readTimestamp(80, __dbResults);
    this.isnewuser = JdbcWritableBridge.readString(81, __dbResults);
    this.rule_id = JdbcWritableBridge.readString(82, __dbResults);
    this.is_tongdun = JdbcWritableBridge.readString(83, __dbResults);
    this.is_black_gray = JdbcWritableBridge.readString(84, __dbResults);
    this.userriskbill = JdbcWritableBridge.readString(85, __dbResults);
    this.address_home = JdbcWritableBridge.readString(86, __dbResults);
    this.bl_graduate_time = JdbcWritableBridge.readString(87, __dbResults);
    this.is_gjj_submit = JdbcWritableBridge.readString(88, __dbResults);
    this.mobile_address = JdbcWritableBridge.readString(89, __dbResults);
    this.pass_rule = JdbcWritableBridge.readString(90, __dbResults);
    this.apply_channel = JdbcWritableBridge.readString(91, __dbResults);
    this.auto_decision_code = JdbcWritableBridge.readString(92, __dbResults);
    this.publish_duration = JdbcWritableBridge.readInteger(93, __dbResults);
    this.confirm_duration = JdbcWritableBridge.readInteger(94, __dbResults);
    this.lend_duration = JdbcWritableBridge.readInteger(95, __dbResults);
    this.is_stock_campaign = JdbcWritableBridge.readString(96, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.stat_date = JdbcWritableBridge.readInteger(1, __dbResults);
    this.apply_no = JdbcWritableBridge.readLong(2, __dbResults);
    this.apply_name = JdbcWritableBridge.readString(3, __dbResults);
    this.identity_card_id = JdbcWritableBridge.readString(4, __dbResults);
    this.age = JdbcWritableBridge.readInteger(5, __dbResults);
    this.sex = JdbcWritableBridge.readString(6, __dbResults);
    this.huji_province = JdbcWritableBridge.readString(7, __dbResults);
    this.huji_city = JdbcWritableBridge.readString(8, __dbResults);
    this.current_province = JdbcWritableBridge.readString(9, __dbResults);
    this.current_city = JdbcWritableBridge.readString(10, __dbResults);
    this.school_name = JdbcWritableBridge.readString(11, __dbResults);
    this.school_type = JdbcWritableBridge.readString(12, __dbResults);
    this.school_city = JdbcWritableBridge.readString(13, __dbResults);
    this.school_province = JdbcWritableBridge.readString(14, __dbResults);
    this.major_name = JdbcWritableBridge.readString(15, __dbResults);
    this.grade = JdbcWritableBridge.readString(16, __dbResults);
    this.education = JdbcWritableBridge.readString(17, __dbResults);
    this.enter_school_date = JdbcWritableBridge.readString(18, __dbResults);
    this.graduate_flag = JdbcWritableBridge.readInteger(19, __dbResults);
    this.graduate_date = JdbcWritableBridge.readString(20, __dbResults);
    this.phone_no = JdbcWritableBridge.readString(21, __dbResults);
    this.phone_instructor_no = JdbcWritableBridge.readString(22, __dbResults);
    this.phone_parents_no = JdbcWritableBridge.readString(23, __dbResults);
    this.phone_contact1_no = JdbcWritableBridge.readString(24, __dbResults);
    this.phone_contact2_no = JdbcWritableBridge.readString(25, __dbResults);
    this.phone_contact3_no = JdbcWritableBridge.readString(26, __dbResults);
    this.qq = JdbcWritableBridge.readString(27, __dbResults);
    this.email = JdbcWritableBridge.readString(28, __dbResults);
    this.occupation = JdbcWritableBridge.readString(29, __dbResults);
    this.working_year = JdbcWritableBridge.readInteger(30, __dbResults);
    this.company_name = JdbcWritableBridge.readString(31, __dbResults);
    this.company_type = JdbcWritableBridge.readInteger(32, __dbResults);
    this.phone_company_no = JdbcWritableBridge.readString(33, __dbResults);
    this.apply_date = JdbcWritableBridge.readTimestamp(34, __dbResults);
    this.product = JdbcWritableBridge.readString(35, __dbResults);
    this.apply_amt = JdbcWritableBridge.readBigDecimal(36, __dbResults);
    this.apply_term = JdbcWritableBridge.readInteger(37, __dbResults);
    this.sign_result = JdbcWritableBridge.readString(38, __dbResults);
    this.approve_result = JdbcWritableBridge.readString(39, __dbResults);
    this.approve_amt = JdbcWritableBridge.readBigDecimal(40, __dbResults);
    this.refuse_reason = JdbcWritableBridge.readString(41, __dbResults);
    this.cancell_reason = JdbcWritableBridge.readString(42, __dbResults);
    this.back_reason = JdbcWritableBridge.readString(43, __dbResults);
    this.channel = JdbcWritableBridge.readString(44, __dbResults);
    this.resource = JdbcWritableBridge.readString(45, __dbResults);
    this.purpose = JdbcWritableBridge.readString(46, __dbResults);
    this.score = JdbcWritableBridge.readString(47, __dbResults);
    this.level = JdbcWritableBridge.readString(48, __dbResults);
    this.video_flag = JdbcWritableBridge.readInteger(49, __dbResults);
    this.phonecall_flag = JdbcWritableBridge.readString(50, __dbResults);
    this.phonecall_parents_flag = JdbcWritableBridge.readString(51, __dbResults);
    this.phonecall_guider_flag = JdbcWritableBridge.readString(52, __dbResults);
    this.phonecall_contact1_flag = JdbcWritableBridge.readString(53, __dbResults);
    this.phonecall_contact2_flag = JdbcWritableBridge.readString(54, __dbResults);
    this.phonecall_contact3_flag = JdbcWritableBridge.readString(55, __dbResults);
    this.register_ip = JdbcWritableBridge.readString(56, __dbResults);
    this.student_certificate1_flag = JdbcWritableBridge.readInteger(57, __dbResults);
    this.student_certificate2_flag = JdbcWritableBridge.readInteger(58, __dbResults);
    this.insurance_society_flag = JdbcWritableBridge.readInteger(59, __dbResults);
    this.family_income_amt = JdbcWritableBridge.readInteger(60, __dbResults);
    this.fraud_flag = JdbcWritableBridge.readInteger(61, __dbResults);
    this.fraud_type = JdbcWritableBridge.readString(62, __dbResults);
    this.merchant_name = JdbcWritableBridge.readString(63, __dbResults);
    this.counsellor_name = JdbcWritableBridge.readString(64, __dbResults);
    this.parent_name = JdbcWritableBridge.readString(65, __dbResults);
    this.contact_name1 = JdbcWritableBridge.readString(66, __dbResults);
    this.contact_name2 = JdbcWritableBridge.readString(67, __dbResults);
    this.contact_name3 = JdbcWritableBridge.readString(68, __dbResults);
    this.counsellor_phone = JdbcWritableBridge.readString(69, __dbResults);
    this.parent_phone = JdbcWritableBridge.readString(70, __dbResults);
    this.contact_phone1 = JdbcWritableBridge.readString(71, __dbResults);
    this.contact_phone2 = JdbcWritableBridge.readString(72, __dbResults);
    this.contact_phone3 = JdbcWritableBridge.readString(73, __dbResults);
    this.am_audit_time = JdbcWritableBridge.readTimestamp(74, __dbResults);
    this.home_address = JdbcWritableBridge.readString(75, __dbResults);
    this.bank_card_no = JdbcWritableBridge.readString(76, __dbResults);
    this.bank_name = JdbcWritableBridge.readString(77, __dbResults);
    this.user_id = JdbcWritableBridge.readLong(78, __dbResults);
    this.auto_decision = JdbcWritableBridge.readString(79, __dbResults);
    this.auto_decision_date = JdbcWritableBridge.readTimestamp(80, __dbResults);
    this.isnewuser = JdbcWritableBridge.readString(81, __dbResults);
    this.rule_id = JdbcWritableBridge.readString(82, __dbResults);
    this.is_tongdun = JdbcWritableBridge.readString(83, __dbResults);
    this.is_black_gray = JdbcWritableBridge.readString(84, __dbResults);
    this.userriskbill = JdbcWritableBridge.readString(85, __dbResults);
    this.address_home = JdbcWritableBridge.readString(86, __dbResults);
    this.bl_graduate_time = JdbcWritableBridge.readString(87, __dbResults);
    this.is_gjj_submit = JdbcWritableBridge.readString(88, __dbResults);
    this.mobile_address = JdbcWritableBridge.readString(89, __dbResults);
    this.pass_rule = JdbcWritableBridge.readString(90, __dbResults);
    this.apply_channel = JdbcWritableBridge.readString(91, __dbResults);
    this.auto_decision_code = JdbcWritableBridge.readString(92, __dbResults);
    this.publish_duration = JdbcWritableBridge.readInteger(93, __dbResults);
    this.confirm_duration = JdbcWritableBridge.readInteger(94, __dbResults);
    this.lend_duration = JdbcWritableBridge.readInteger(95, __dbResults);
    this.is_stock_campaign = JdbcWritableBridge.readString(96, __dbResults);
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
    JdbcWritableBridge.writeString(identity_card_id, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(age, 5 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(sex, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(huji_province, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(huji_city, 8 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(current_province, 9 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(current_city, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(school_name, 11 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(school_type, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(school_city, 13 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(school_province, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(major_name, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(grade, 16 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(education, 17 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(enter_school_date, 18 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(graduate_flag, 19 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(graduate_date, 20 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_no, 21 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_instructor_no, 22 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_parents_no, 23 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_contact1_no, 24 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_contact2_no, 25 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_contact3_no, 26 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(qq, 27 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(email, 28 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(occupation, 29 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(working_year, 30 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(company_name, 31 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(company_type, 32 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(phone_company_no, 33 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(apply_date, 34 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(product, 35 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(apply_amt, 36 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(apply_term, 37 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(sign_result, 38 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(approve_result, 39 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(approve_amt, 40 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(refuse_reason, 41 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(cancell_reason, 42 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(back_reason, 43 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(channel, 44 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(resource, 45 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(purpose, 46 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(score, 47 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(level, 48 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(video_flag, 49 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_flag, 50 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_parents_flag, 51 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_guider_flag, 52 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_contact1_flag, 53 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_contact2_flag, 54 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_contact3_flag, 55 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(register_ip, 56 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(student_certificate1_flag, 57 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(student_certificate2_flag, 58 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(insurance_society_flag, 59 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(family_income_amt, 60 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(fraud_flag, 61 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(fraud_type, 62 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(merchant_name, 63 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(counsellor_name, 64 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(parent_name, 65 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_name1, 66 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_name2, 67 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_name3, 68 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(counsellor_phone, 69 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(parent_phone, 70 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_phone1, 71 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_phone2, 72 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_phone3, 73 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(am_audit_time, 74 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(home_address, 75 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(bank_card_no, 76 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(bank_name, 77 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeLong(user_id, 78 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(auto_decision, 79 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(auto_decision_date, 80 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(isnewuser, 81 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(rule_id, 82 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(is_tongdun, 83 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(is_black_gray, 84 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(userriskbill, 85 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(address_home, 86 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(bl_graduate_time, 87 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(is_gjj_submit, 88 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(mobile_address, 89 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(pass_rule, 90 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(apply_channel, 91 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(auto_decision_code, 92 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(publish_duration, 93 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(confirm_duration, 94 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lend_duration, 95 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(is_stock_campaign, 96 + __off, 12, __dbStmt);
    return 96;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeInteger(stat_date, 1 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeLong(apply_no, 2 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(apply_name, 3 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(identity_card_id, 4 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(age, 5 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(sex, 6 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(huji_province, 7 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(huji_city, 8 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(current_province, 9 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(current_city, 10 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(school_name, 11 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(school_type, 12 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(school_city, 13 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(school_province, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(major_name, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(grade, 16 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(education, 17 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(enter_school_date, 18 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(graduate_flag, 19 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(graduate_date, 20 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_no, 21 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_instructor_no, 22 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_parents_no, 23 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_contact1_no, 24 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_contact2_no, 25 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phone_contact3_no, 26 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(qq, 27 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(email, 28 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(occupation, 29 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(working_year, 30 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(company_name, 31 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(company_type, 32 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(phone_company_no, 33 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(apply_date, 34 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(product, 35 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(apply_amt, 36 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(apply_term, 37 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(sign_result, 38 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(approve_result, 39 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(approve_amt, 40 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeString(refuse_reason, 41 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(cancell_reason, 42 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(back_reason, 43 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(channel, 44 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(resource, 45 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(purpose, 46 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(score, 47 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(level, 48 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(video_flag, 49 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_flag, 50 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_parents_flag, 51 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_guider_flag, 52 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_contact1_flag, 53 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_contact2_flag, 54 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(phonecall_contact3_flag, 55 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(register_ip, 56 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(student_certificate1_flag, 57 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(student_certificate2_flag, 58 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(insurance_society_flag, 59 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(family_income_amt, 60 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(fraud_flag, 61 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(fraud_type, 62 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(merchant_name, 63 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(counsellor_name, 64 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(parent_name, 65 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_name1, 66 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_name2, 67 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_name3, 68 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(counsellor_phone, 69 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(parent_phone, 70 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_phone1, 71 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_phone2, 72 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(contact_phone3, 73 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(am_audit_time, 74 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(home_address, 75 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(bank_card_no, 76 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(bank_name, 77 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeLong(user_id, 78 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(auto_decision, 79 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(auto_decision_date, 80 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeString(isnewuser, 81 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(rule_id, 82 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(is_tongdun, 83 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(is_black_gray, 84 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(userriskbill, 85 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(address_home, 86 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(bl_graduate_time, 87 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(is_gjj_submit, 88 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(mobile_address, 89 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(pass_rule, 90 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(apply_channel, 91 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(auto_decision_code, 92 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(publish_duration, 93 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(confirm_duration, 94 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lend_duration, 95 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(is_stock_campaign, 96 + __off, 12, __dbStmt);
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
    if (__dataIn.readBoolean()) { 
        this.identity_card_id = null;
    } else {
    this.identity_card_id = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.age = null;
    } else {
    this.age = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.sex = null;
    } else {
    this.sex = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.huji_province = null;
    } else {
    this.huji_province = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.huji_city = null;
    } else {
    this.huji_city = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.current_province = null;
    } else {
    this.current_province = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.current_city = null;
    } else {
    this.current_city = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.school_name = null;
    } else {
    this.school_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.school_type = null;
    } else {
    this.school_type = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.school_city = null;
    } else {
    this.school_city = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.school_province = null;
    } else {
    this.school_province = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.major_name = null;
    } else {
    this.major_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.grade = null;
    } else {
    this.grade = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.education = null;
    } else {
    this.education = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.enter_school_date = null;
    } else {
    this.enter_school_date = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.graduate_flag = null;
    } else {
    this.graduate_flag = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.graduate_date = null;
    } else {
    this.graduate_date = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phone_no = null;
    } else {
    this.phone_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phone_instructor_no = null;
    } else {
    this.phone_instructor_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phone_parents_no = null;
    } else {
    this.phone_parents_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phone_contact1_no = null;
    } else {
    this.phone_contact1_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phone_contact2_no = null;
    } else {
    this.phone_contact2_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phone_contact3_no = null;
    } else {
    this.phone_contact3_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.qq = null;
    } else {
    this.qq = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.email = null;
    } else {
    this.email = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.occupation = null;
    } else {
    this.occupation = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.working_year = null;
    } else {
    this.working_year = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.company_name = null;
    } else {
    this.company_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.company_type = null;
    } else {
    this.company_type = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.phone_company_no = null;
    } else {
    this.phone_company_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.apply_date = null;
    } else {
    this.apply_date = new Timestamp(__dataIn.readLong());
    this.apply_date.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.product = null;
    } else {
    this.product = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.apply_amt = null;
    } else {
    this.apply_amt = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.apply_term = null;
    } else {
    this.apply_term = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.sign_result = null;
    } else {
    this.sign_result = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.approve_result = null;
    } else {
    this.approve_result = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.approve_amt = null;
    } else {
    this.approve_amt = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.refuse_reason = null;
    } else {
    this.refuse_reason = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.cancell_reason = null;
    } else {
    this.cancell_reason = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.back_reason = null;
    } else {
    this.back_reason = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.channel = null;
    } else {
    this.channel = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.resource = null;
    } else {
    this.resource = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.purpose = null;
    } else {
    this.purpose = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.score = null;
    } else {
    this.score = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.level = null;
    } else {
    this.level = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.video_flag = null;
    } else {
    this.video_flag = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.phonecall_flag = null;
    } else {
    this.phonecall_flag = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phonecall_parents_flag = null;
    } else {
    this.phonecall_parents_flag = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phonecall_guider_flag = null;
    } else {
    this.phonecall_guider_flag = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phonecall_contact1_flag = null;
    } else {
    this.phonecall_contact1_flag = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phonecall_contact2_flag = null;
    } else {
    this.phonecall_contact2_flag = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.phonecall_contact3_flag = null;
    } else {
    this.phonecall_contact3_flag = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.register_ip = null;
    } else {
    this.register_ip = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.student_certificate1_flag = null;
    } else {
    this.student_certificate1_flag = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.student_certificate2_flag = null;
    } else {
    this.student_certificate2_flag = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.insurance_society_flag = null;
    } else {
    this.insurance_society_flag = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.family_income_amt = null;
    } else {
    this.family_income_amt = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.fraud_flag = null;
    } else {
    this.fraud_flag = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.fraud_type = null;
    } else {
    this.fraud_type = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.merchant_name = null;
    } else {
    this.merchant_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.counsellor_name = null;
    } else {
    this.counsellor_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.parent_name = null;
    } else {
    this.parent_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.contact_name1 = null;
    } else {
    this.contact_name1 = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.contact_name2 = null;
    } else {
    this.contact_name2 = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.contact_name3 = null;
    } else {
    this.contact_name3 = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.counsellor_phone = null;
    } else {
    this.counsellor_phone = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.parent_phone = null;
    } else {
    this.parent_phone = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.contact_phone1 = null;
    } else {
    this.contact_phone1 = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.contact_phone2 = null;
    } else {
    this.contact_phone2 = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.contact_phone3 = null;
    } else {
    this.contact_phone3 = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.am_audit_time = null;
    } else {
    this.am_audit_time = new Timestamp(__dataIn.readLong());
    this.am_audit_time.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.home_address = null;
    } else {
    this.home_address = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.bank_card_no = null;
    } else {
    this.bank_card_no = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.bank_name = null;
    } else {
    this.bank_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.user_id = null;
    } else {
    this.user_id = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.auto_decision = null;
    } else {
    this.auto_decision = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.auto_decision_date = null;
    } else {
    this.auto_decision_date = new Timestamp(__dataIn.readLong());
    this.auto_decision_date.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.isnewuser = null;
    } else {
    this.isnewuser = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.rule_id = null;
    } else {
    this.rule_id = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.is_tongdun = null;
    } else {
    this.is_tongdun = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.is_black_gray = null;
    } else {
    this.is_black_gray = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.userriskbill = null;
    } else {
    this.userriskbill = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.address_home = null;
    } else {
    this.address_home = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.bl_graduate_time = null;
    } else {
    this.bl_graduate_time = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.is_gjj_submit = null;
    } else {
    this.is_gjj_submit = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.mobile_address = null;
    } else {
    this.mobile_address = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.pass_rule = null;
    } else {
    this.pass_rule = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.apply_channel = null;
    } else {
    this.apply_channel = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.auto_decision_code = null;
    } else {
    this.auto_decision_code = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.publish_duration = null;
    } else {
    this.publish_duration = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.confirm_duration = null;
    } else {
    this.confirm_duration = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lend_duration = null;
    } else {
    this.lend_duration = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.is_stock_campaign = null;
    } else {
    this.is_stock_campaign = Text.readString(__dataIn);
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
    if (null == this.identity_card_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, identity_card_id);
    }
    if (null == this.age) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.age);
    }
    if (null == this.sex) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, sex);
    }
    if (null == this.huji_province) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, huji_province);
    }
    if (null == this.huji_city) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, huji_city);
    }
    if (null == this.current_province) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, current_province);
    }
    if (null == this.current_city) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, current_city);
    }
    if (null == this.school_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, school_name);
    }
    if (null == this.school_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, school_type);
    }
    if (null == this.school_city) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, school_city);
    }
    if (null == this.school_province) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, school_province);
    }
    if (null == this.major_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, major_name);
    }
    if (null == this.grade) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, grade);
    }
    if (null == this.education) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, education);
    }
    if (null == this.enter_school_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, enter_school_date);
    }
    if (null == this.graduate_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.graduate_flag);
    }
    if (null == this.graduate_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, graduate_date);
    }
    if (null == this.phone_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_no);
    }
    if (null == this.phone_instructor_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_instructor_no);
    }
    if (null == this.phone_parents_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_parents_no);
    }
    if (null == this.phone_contact1_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_contact1_no);
    }
    if (null == this.phone_contact2_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_contact2_no);
    }
    if (null == this.phone_contact3_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_contact3_no);
    }
    if (null == this.qq) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, qq);
    }
    if (null == this.email) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, email);
    }
    if (null == this.occupation) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, occupation);
    }
    if (null == this.working_year) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.working_year);
    }
    if (null == this.company_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, company_name);
    }
    if (null == this.company_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.company_type);
    }
    if (null == this.phone_company_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_company_no);
    }
    if (null == this.apply_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.apply_date.getTime());
    __dataOut.writeInt(this.apply_date.getNanos());
    }
    if (null == this.product) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product);
    }
    if (null == this.apply_amt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.apply_amt, __dataOut);
    }
    if (null == this.apply_term) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.apply_term);
    }
    if (null == this.sign_result) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, sign_result);
    }
    if (null == this.approve_result) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, approve_result);
    }
    if (null == this.approve_amt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.approve_amt, __dataOut);
    }
    if (null == this.refuse_reason) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, refuse_reason);
    }
    if (null == this.cancell_reason) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, cancell_reason);
    }
    if (null == this.back_reason) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, back_reason);
    }
    if (null == this.channel) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, channel);
    }
    if (null == this.resource) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, resource);
    }
    if (null == this.purpose) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, purpose);
    }
    if (null == this.score) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, score);
    }
    if (null == this.level) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, level);
    }
    if (null == this.video_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.video_flag);
    }
    if (null == this.phonecall_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_flag);
    }
    if (null == this.phonecall_parents_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_parents_flag);
    }
    if (null == this.phonecall_guider_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_guider_flag);
    }
    if (null == this.phonecall_contact1_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_contact1_flag);
    }
    if (null == this.phonecall_contact2_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_contact2_flag);
    }
    if (null == this.phonecall_contact3_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_contact3_flag);
    }
    if (null == this.register_ip) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, register_ip);
    }
    if (null == this.student_certificate1_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.student_certificate1_flag);
    }
    if (null == this.student_certificate2_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.student_certificate2_flag);
    }
    if (null == this.insurance_society_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.insurance_society_flag);
    }
    if (null == this.family_income_amt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.family_income_amt);
    }
    if (null == this.fraud_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.fraud_flag);
    }
    if (null == this.fraud_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, fraud_type);
    }
    if (null == this.merchant_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, merchant_name);
    }
    if (null == this.counsellor_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, counsellor_name);
    }
    if (null == this.parent_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, parent_name);
    }
    if (null == this.contact_name1) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_name1);
    }
    if (null == this.contact_name2) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_name2);
    }
    if (null == this.contact_name3) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_name3);
    }
    if (null == this.counsellor_phone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, counsellor_phone);
    }
    if (null == this.parent_phone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, parent_phone);
    }
    if (null == this.contact_phone1) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_phone1);
    }
    if (null == this.contact_phone2) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_phone2);
    }
    if (null == this.contact_phone3) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_phone3);
    }
    if (null == this.am_audit_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.am_audit_time.getTime());
    __dataOut.writeInt(this.am_audit_time.getNanos());
    }
    if (null == this.home_address) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, home_address);
    }
    if (null == this.bank_card_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, bank_card_no);
    }
    if (null == this.bank_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, bank_name);
    }
    if (null == this.user_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.user_id);
    }
    if (null == this.auto_decision) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, auto_decision);
    }
    if (null == this.auto_decision_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.auto_decision_date.getTime());
    __dataOut.writeInt(this.auto_decision_date.getNanos());
    }
    if (null == this.isnewuser) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, isnewuser);
    }
    if (null == this.rule_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, rule_id);
    }
    if (null == this.is_tongdun) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, is_tongdun);
    }
    if (null == this.is_black_gray) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, is_black_gray);
    }
    if (null == this.userriskbill) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, userriskbill);
    }
    if (null == this.address_home) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, address_home);
    }
    if (null == this.bl_graduate_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, bl_graduate_time);
    }
    if (null == this.is_gjj_submit) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, is_gjj_submit);
    }
    if (null == this.mobile_address) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, mobile_address);
    }
    if (null == this.pass_rule) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, pass_rule);
    }
    if (null == this.apply_channel) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, apply_channel);
    }
    if (null == this.auto_decision_code) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, auto_decision_code);
    }
    if (null == this.publish_duration) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.publish_duration);
    }
    if (null == this.confirm_duration) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.confirm_duration);
    }
    if (null == this.lend_duration) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lend_duration);
    }
    if (null == this.is_stock_campaign) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, is_stock_campaign);
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
    if (null == this.identity_card_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, identity_card_id);
    }
    if (null == this.age) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.age);
    }
    if (null == this.sex) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, sex);
    }
    if (null == this.huji_province) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, huji_province);
    }
    if (null == this.huji_city) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, huji_city);
    }
    if (null == this.current_province) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, current_province);
    }
    if (null == this.current_city) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, current_city);
    }
    if (null == this.school_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, school_name);
    }
    if (null == this.school_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, school_type);
    }
    if (null == this.school_city) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, school_city);
    }
    if (null == this.school_province) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, school_province);
    }
    if (null == this.major_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, major_name);
    }
    if (null == this.grade) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, grade);
    }
    if (null == this.education) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, education);
    }
    if (null == this.enter_school_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, enter_school_date);
    }
    if (null == this.graduate_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.graduate_flag);
    }
    if (null == this.graduate_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, graduate_date);
    }
    if (null == this.phone_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_no);
    }
    if (null == this.phone_instructor_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_instructor_no);
    }
    if (null == this.phone_parents_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_parents_no);
    }
    if (null == this.phone_contact1_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_contact1_no);
    }
    if (null == this.phone_contact2_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_contact2_no);
    }
    if (null == this.phone_contact3_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_contact3_no);
    }
    if (null == this.qq) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, qq);
    }
    if (null == this.email) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, email);
    }
    if (null == this.occupation) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, occupation);
    }
    if (null == this.working_year) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.working_year);
    }
    if (null == this.company_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, company_name);
    }
    if (null == this.company_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.company_type);
    }
    if (null == this.phone_company_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phone_company_no);
    }
    if (null == this.apply_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.apply_date.getTime());
    __dataOut.writeInt(this.apply_date.getNanos());
    }
    if (null == this.product) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product);
    }
    if (null == this.apply_amt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.apply_amt, __dataOut);
    }
    if (null == this.apply_term) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.apply_term);
    }
    if (null == this.sign_result) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, sign_result);
    }
    if (null == this.approve_result) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, approve_result);
    }
    if (null == this.approve_amt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.approve_amt, __dataOut);
    }
    if (null == this.refuse_reason) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, refuse_reason);
    }
    if (null == this.cancell_reason) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, cancell_reason);
    }
    if (null == this.back_reason) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, back_reason);
    }
    if (null == this.channel) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, channel);
    }
    if (null == this.resource) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, resource);
    }
    if (null == this.purpose) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, purpose);
    }
    if (null == this.score) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, score);
    }
    if (null == this.level) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, level);
    }
    if (null == this.video_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.video_flag);
    }
    if (null == this.phonecall_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_flag);
    }
    if (null == this.phonecall_parents_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_parents_flag);
    }
    if (null == this.phonecall_guider_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_guider_flag);
    }
    if (null == this.phonecall_contact1_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_contact1_flag);
    }
    if (null == this.phonecall_contact2_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_contact2_flag);
    }
    if (null == this.phonecall_contact3_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, phonecall_contact3_flag);
    }
    if (null == this.register_ip) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, register_ip);
    }
    if (null == this.student_certificate1_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.student_certificate1_flag);
    }
    if (null == this.student_certificate2_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.student_certificate2_flag);
    }
    if (null == this.insurance_society_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.insurance_society_flag);
    }
    if (null == this.family_income_amt) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.family_income_amt);
    }
    if (null == this.fraud_flag) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.fraud_flag);
    }
    if (null == this.fraud_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, fraud_type);
    }
    if (null == this.merchant_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, merchant_name);
    }
    if (null == this.counsellor_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, counsellor_name);
    }
    if (null == this.parent_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, parent_name);
    }
    if (null == this.contact_name1) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_name1);
    }
    if (null == this.contact_name2) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_name2);
    }
    if (null == this.contact_name3) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_name3);
    }
    if (null == this.counsellor_phone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, counsellor_phone);
    }
    if (null == this.parent_phone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, parent_phone);
    }
    if (null == this.contact_phone1) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_phone1);
    }
    if (null == this.contact_phone2) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_phone2);
    }
    if (null == this.contact_phone3) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, contact_phone3);
    }
    if (null == this.am_audit_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.am_audit_time.getTime());
    __dataOut.writeInt(this.am_audit_time.getNanos());
    }
    if (null == this.home_address) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, home_address);
    }
    if (null == this.bank_card_no) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, bank_card_no);
    }
    if (null == this.bank_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, bank_name);
    }
    if (null == this.user_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.user_id);
    }
    if (null == this.auto_decision) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, auto_decision);
    }
    if (null == this.auto_decision_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.auto_decision_date.getTime());
    __dataOut.writeInt(this.auto_decision_date.getNanos());
    }
    if (null == this.isnewuser) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, isnewuser);
    }
    if (null == this.rule_id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, rule_id);
    }
    if (null == this.is_tongdun) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, is_tongdun);
    }
    if (null == this.is_black_gray) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, is_black_gray);
    }
    if (null == this.userriskbill) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, userriskbill);
    }
    if (null == this.address_home) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, address_home);
    }
    if (null == this.bl_graduate_time) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, bl_graduate_time);
    }
    if (null == this.is_gjj_submit) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, is_gjj_submit);
    }
    if (null == this.mobile_address) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, mobile_address);
    }
    if (null == this.pass_rule) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, pass_rule);
    }
    if (null == this.apply_channel) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, apply_channel);
    }
    if (null == this.auto_decision_code) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, auto_decision_code);
    }
    if (null == this.publish_duration) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.publish_duration);
    }
    if (null == this.confirm_duration) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.confirm_duration);
    }
    if (null == this.lend_duration) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lend_duration);
    }
    if (null == this.is_stock_campaign) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, is_stock_campaign);
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
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(identity_card_id==null?"null":identity_card_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(age==null?"null":"" + age, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(sex==null?"null":sex, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(huji_province==null?"null":huji_province, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(huji_city==null?"null":huji_city, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(current_province==null?"null":current_province, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(current_city==null?"null":current_city, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(school_name==null?"null":school_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(school_type==null?"null":school_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(school_city==null?"null":school_city, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(school_province==null?"null":school_province, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(major_name==null?"null":major_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(grade==null?"null":grade, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(education==null?"null":education, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(enter_school_date==null?"null":enter_school_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(graduate_flag==null?"null":"" + graduate_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(graduate_date==null?"null":graduate_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_no==null?"null":phone_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_instructor_no==null?"null":phone_instructor_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_parents_no==null?"null":phone_parents_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_contact1_no==null?"null":phone_contact1_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_contact2_no==null?"null":phone_contact2_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_contact3_no==null?"null":phone_contact3_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(qq==null?"null":qq, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(email==null?"null":email, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(occupation==null?"null":occupation, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(working_year==null?"null":"" + working_year, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(company_name==null?"null":company_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(company_type==null?"null":"" + company_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_company_no==null?"null":phone_company_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_date==null?"null":"" + apply_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(product==null?"null":product, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_amt==null?"null":apply_amt.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_term==null?"null":"" + apply_term, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(sign_result==null?"null":sign_result, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(approve_result==null?"null":approve_result, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(approve_amt==null?"null":approve_amt.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(refuse_reason==null?"null":refuse_reason, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(cancell_reason==null?"null":cancell_reason, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(back_reason==null?"null":back_reason, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(channel==null?"null":channel, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(resource==null?"null":resource, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(purpose==null?"null":purpose, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(score==null?"null":score, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(level==null?"null":level, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(video_flag==null?"null":"" + video_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_flag==null?"null":phonecall_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_parents_flag==null?"null":phonecall_parents_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_guider_flag==null?"null":phonecall_guider_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_contact1_flag==null?"null":phonecall_contact1_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_contact2_flag==null?"null":phonecall_contact2_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_contact3_flag==null?"null":phonecall_contact3_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(register_ip==null?"null":register_ip, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(student_certificate1_flag==null?"null":"" + student_certificate1_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(student_certificate2_flag==null?"null":"" + student_certificate2_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(insurance_society_flag==null?"null":"" + insurance_society_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(family_income_amt==null?"null":"" + family_income_amt, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(fraud_flag==null?"null":"" + fraud_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(fraud_type==null?"null":fraud_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(merchant_name==null?"null":merchant_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(counsellor_name==null?"null":counsellor_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(parent_name==null?"null":parent_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_name1==null?"null":contact_name1, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_name2==null?"null":contact_name2, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_name3==null?"null":contact_name3, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(counsellor_phone==null?"null":counsellor_phone, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(parent_phone==null?"null":parent_phone, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_phone1==null?"null":contact_phone1, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_phone2==null?"null":contact_phone2, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_phone3==null?"null":contact_phone3, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(am_audit_time==null?"null":"" + am_audit_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(home_address==null?"null":home_address, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bank_card_no==null?"null":bank_card_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bank_name==null?"null":bank_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(user_id==null?"null":"" + user_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(auto_decision==null?"null":auto_decision, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(auto_decision_date==null?"null":"" + auto_decision_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(isnewuser==null?"null":isnewuser, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(rule_id==null?"null":rule_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_tongdun==null?"null":is_tongdun, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_black_gray==null?"null":is_black_gray, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(userriskbill==null?"null":userriskbill, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(address_home==null?"null":address_home, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bl_graduate_time==null?"null":bl_graduate_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_gjj_submit==null?"null":is_gjj_submit, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(mobile_address==null?"null":mobile_address, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(pass_rule==null?"null":pass_rule, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_channel==null?"null":apply_channel, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(auto_decision_code==null?"null":auto_decision_code, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(publish_duration==null?"null":"" + publish_duration, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(confirm_duration==null?"null":"" + confirm_duration, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lend_duration==null?"null":"" + lend_duration, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_stock_campaign==null?"null":is_stock_campaign, delimiters));
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
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(identity_card_id==null?"null":identity_card_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(age==null?"null":"" + age, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(sex==null?"null":sex, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(huji_province==null?"null":huji_province, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(huji_city==null?"null":huji_city, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(current_province==null?"null":current_province, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(current_city==null?"null":current_city, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(school_name==null?"null":school_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(school_type==null?"null":school_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(school_city==null?"null":school_city, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(school_province==null?"null":school_province, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(major_name==null?"null":major_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(grade==null?"null":grade, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(education==null?"null":education, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(enter_school_date==null?"null":enter_school_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(graduate_flag==null?"null":"" + graduate_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(graduate_date==null?"null":graduate_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_no==null?"null":phone_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_instructor_no==null?"null":phone_instructor_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_parents_no==null?"null":phone_parents_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_contact1_no==null?"null":phone_contact1_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_contact2_no==null?"null":phone_contact2_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_contact3_no==null?"null":phone_contact3_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(qq==null?"null":qq, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(email==null?"null":email, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(occupation==null?"null":occupation, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(working_year==null?"null":"" + working_year, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(company_name==null?"null":company_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(company_type==null?"null":"" + company_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phone_company_no==null?"null":phone_company_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_date==null?"null":"" + apply_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(product==null?"null":product, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_amt==null?"null":apply_amt.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_term==null?"null":"" + apply_term, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(sign_result==null?"null":sign_result, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(approve_result==null?"null":approve_result, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(approve_amt==null?"null":approve_amt.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(refuse_reason==null?"null":refuse_reason, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(cancell_reason==null?"null":cancell_reason, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(back_reason==null?"null":back_reason, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(channel==null?"null":channel, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(resource==null?"null":resource, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(purpose==null?"null":purpose, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(score==null?"null":score, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(level==null?"null":level, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(video_flag==null?"null":"" + video_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_flag==null?"null":phonecall_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_parents_flag==null?"null":phonecall_parents_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_guider_flag==null?"null":phonecall_guider_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_contact1_flag==null?"null":phonecall_contact1_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_contact2_flag==null?"null":phonecall_contact2_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(phonecall_contact3_flag==null?"null":phonecall_contact3_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(register_ip==null?"null":register_ip, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(student_certificate1_flag==null?"null":"" + student_certificate1_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(student_certificate2_flag==null?"null":"" + student_certificate2_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(insurance_society_flag==null?"null":"" + insurance_society_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(family_income_amt==null?"null":"" + family_income_amt, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(fraud_flag==null?"null":"" + fraud_flag, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(fraud_type==null?"null":fraud_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(merchant_name==null?"null":merchant_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(counsellor_name==null?"null":counsellor_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(parent_name==null?"null":parent_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_name1==null?"null":contact_name1, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_name2==null?"null":contact_name2, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_name3==null?"null":contact_name3, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(counsellor_phone==null?"null":counsellor_phone, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(parent_phone==null?"null":parent_phone, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_phone1==null?"null":contact_phone1, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_phone2==null?"null":contact_phone2, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(contact_phone3==null?"null":contact_phone3, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(am_audit_time==null?"null":"" + am_audit_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(home_address==null?"null":home_address, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bank_card_no==null?"null":bank_card_no, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bank_name==null?"null":bank_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(user_id==null?"null":"" + user_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(auto_decision==null?"null":auto_decision, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(auto_decision_date==null?"null":"" + auto_decision_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(isnewuser==null?"null":isnewuser, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(rule_id==null?"null":rule_id, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_tongdun==null?"null":is_tongdun, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_black_gray==null?"null":is_black_gray, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(userriskbill==null?"null":userriskbill, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(address_home==null?"null":address_home, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(bl_graduate_time==null?"null":bl_graduate_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_gjj_submit==null?"null":is_gjj_submit, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(mobile_address==null?"null":mobile_address, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(pass_rule==null?"null":pass_rule, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(apply_channel==null?"null":apply_channel, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(auto_decision_code==null?"null":auto_decision_code, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(publish_duration==null?"null":"" + publish_duration, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(confirm_duration==null?"null":"" + confirm_duration, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lend_duration==null?"null":"" + lend_duration, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_stock_campaign==null?"null":is_stock_campaign, delimiters));
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

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.identity_card_id = null; } else {
      this.identity_card_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.age = null; } else {
      this.age = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.sex = null; } else {
      this.sex = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.huji_province = null; } else {
      this.huji_province = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.huji_city = null; } else {
      this.huji_city = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.current_province = null; } else {
      this.current_province = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.current_city = null; } else {
      this.current_city = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.school_name = null; } else {
      this.school_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.school_type = null; } else {
      this.school_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.school_city = null; } else {
      this.school_city = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.school_province = null; } else {
      this.school_province = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.major_name = null; } else {
      this.major_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.grade = null; } else {
      this.grade = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.education = null; } else {
      this.education = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.enter_school_date = null; } else {
      this.enter_school_date = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.graduate_flag = null; } else {
      this.graduate_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.graduate_date = null; } else {
      this.graduate_date = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_no = null; } else {
      this.phone_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_instructor_no = null; } else {
      this.phone_instructor_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_parents_no = null; } else {
      this.phone_parents_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_contact1_no = null; } else {
      this.phone_contact1_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_contact2_no = null; } else {
      this.phone_contact2_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_contact3_no = null; } else {
      this.phone_contact3_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.qq = null; } else {
      this.qq = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.email = null; } else {
      this.email = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.occupation = null; } else {
      this.occupation = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.working_year = null; } else {
      this.working_year = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.company_name = null; } else {
      this.company_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.company_type = null; } else {
      this.company_type = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_company_no = null; } else {
      this.phone_company_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.apply_date = null; } else {
      this.apply_date = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.product = null; } else {
      this.product = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.apply_amt = null; } else {
      this.apply_amt = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.apply_term = null; } else {
      this.apply_term = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.sign_result = null; } else {
      this.sign_result = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.approve_result = null; } else {
      this.approve_result = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.approve_amt = null; } else {
      this.approve_amt = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.refuse_reason = null; } else {
      this.refuse_reason = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.cancell_reason = null; } else {
      this.cancell_reason = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.back_reason = null; } else {
      this.back_reason = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.channel = null; } else {
      this.channel = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.resource = null; } else {
      this.resource = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.purpose = null; } else {
      this.purpose = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.score = null; } else {
      this.score = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.level = null; } else {
      this.level = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.video_flag = null; } else {
      this.video_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_flag = null; } else {
      this.phonecall_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_parents_flag = null; } else {
      this.phonecall_parents_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_guider_flag = null; } else {
      this.phonecall_guider_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_contact1_flag = null; } else {
      this.phonecall_contact1_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_contact2_flag = null; } else {
      this.phonecall_contact2_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_contact3_flag = null; } else {
      this.phonecall_contact3_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.register_ip = null; } else {
      this.register_ip = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.student_certificate1_flag = null; } else {
      this.student_certificate1_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.student_certificate2_flag = null; } else {
      this.student_certificate2_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.insurance_society_flag = null; } else {
      this.insurance_society_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.family_income_amt = null; } else {
      this.family_income_amt = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.fraud_flag = null; } else {
      this.fraud_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.fraud_type = null; } else {
      this.fraud_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.merchant_name = null; } else {
      this.merchant_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.counsellor_name = null; } else {
      this.counsellor_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.parent_name = null; } else {
      this.parent_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_name1 = null; } else {
      this.contact_name1 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_name2 = null; } else {
      this.contact_name2 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_name3 = null; } else {
      this.contact_name3 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.counsellor_phone = null; } else {
      this.counsellor_phone = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.parent_phone = null; } else {
      this.parent_phone = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_phone1 = null; } else {
      this.contact_phone1 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_phone2 = null; } else {
      this.contact_phone2 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_phone3 = null; } else {
      this.contact_phone3 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.am_audit_time = null; } else {
      this.am_audit_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.home_address = null; } else {
      this.home_address = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.bank_card_no = null; } else {
      this.bank_card_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.bank_name = null; } else {
      this.bank_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.user_id = null; } else {
      this.user_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.auto_decision = null; } else {
      this.auto_decision = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.auto_decision_date = null; } else {
      this.auto_decision_date = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.isnewuser = null; } else {
      this.isnewuser = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.rule_id = null; } else {
      this.rule_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.is_tongdun = null; } else {
      this.is_tongdun = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.is_black_gray = null; } else {
      this.is_black_gray = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.userriskbill = null; } else {
      this.userriskbill = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.address_home = null; } else {
      this.address_home = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.bl_graduate_time = null; } else {
      this.bl_graduate_time = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.is_gjj_submit = null; } else {
      this.is_gjj_submit = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.mobile_address = null; } else {
      this.mobile_address = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.pass_rule = null; } else {
      this.pass_rule = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.apply_channel = null; } else {
      this.apply_channel = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.auto_decision_code = null; } else {
      this.auto_decision_code = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.publish_duration = null; } else {
      this.publish_duration = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.confirm_duration = null; } else {
      this.confirm_duration = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.lend_duration = null; } else {
      this.lend_duration = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.is_stock_campaign = null; } else {
      this.is_stock_campaign = __cur_str;
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

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.identity_card_id = null; } else {
      this.identity_card_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.age = null; } else {
      this.age = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.sex = null; } else {
      this.sex = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.huji_province = null; } else {
      this.huji_province = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.huji_city = null; } else {
      this.huji_city = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.current_province = null; } else {
      this.current_province = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.current_city = null; } else {
      this.current_city = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.school_name = null; } else {
      this.school_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.school_type = null; } else {
      this.school_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.school_city = null; } else {
      this.school_city = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.school_province = null; } else {
      this.school_province = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.major_name = null; } else {
      this.major_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.grade = null; } else {
      this.grade = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.education = null; } else {
      this.education = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.enter_school_date = null; } else {
      this.enter_school_date = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.graduate_flag = null; } else {
      this.graduate_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.graduate_date = null; } else {
      this.graduate_date = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_no = null; } else {
      this.phone_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_instructor_no = null; } else {
      this.phone_instructor_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_parents_no = null; } else {
      this.phone_parents_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_contact1_no = null; } else {
      this.phone_contact1_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_contact2_no = null; } else {
      this.phone_contact2_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_contact3_no = null; } else {
      this.phone_contact3_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.qq = null; } else {
      this.qq = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.email = null; } else {
      this.email = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.occupation = null; } else {
      this.occupation = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.working_year = null; } else {
      this.working_year = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.company_name = null; } else {
      this.company_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.company_type = null; } else {
      this.company_type = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phone_company_no = null; } else {
      this.phone_company_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.apply_date = null; } else {
      this.apply_date = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.product = null; } else {
      this.product = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.apply_amt = null; } else {
      this.apply_amt = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.apply_term = null; } else {
      this.apply_term = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.sign_result = null; } else {
      this.sign_result = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.approve_result = null; } else {
      this.approve_result = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.approve_amt = null; } else {
      this.approve_amt = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.refuse_reason = null; } else {
      this.refuse_reason = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.cancell_reason = null; } else {
      this.cancell_reason = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.back_reason = null; } else {
      this.back_reason = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.channel = null; } else {
      this.channel = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.resource = null; } else {
      this.resource = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.purpose = null; } else {
      this.purpose = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.score = null; } else {
      this.score = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.level = null; } else {
      this.level = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.video_flag = null; } else {
      this.video_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_flag = null; } else {
      this.phonecall_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_parents_flag = null; } else {
      this.phonecall_parents_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_guider_flag = null; } else {
      this.phonecall_guider_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_contact1_flag = null; } else {
      this.phonecall_contact1_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_contact2_flag = null; } else {
      this.phonecall_contact2_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.phonecall_contact3_flag = null; } else {
      this.phonecall_contact3_flag = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.register_ip = null; } else {
      this.register_ip = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.student_certificate1_flag = null; } else {
      this.student_certificate1_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.student_certificate2_flag = null; } else {
      this.student_certificate2_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.insurance_society_flag = null; } else {
      this.insurance_society_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.family_income_amt = null; } else {
      this.family_income_amt = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.fraud_flag = null; } else {
      this.fraud_flag = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.fraud_type = null; } else {
      this.fraud_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.merchant_name = null; } else {
      this.merchant_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.counsellor_name = null; } else {
      this.counsellor_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.parent_name = null; } else {
      this.parent_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_name1 = null; } else {
      this.contact_name1 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_name2 = null; } else {
      this.contact_name2 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_name3 = null; } else {
      this.contact_name3 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.counsellor_phone = null; } else {
      this.counsellor_phone = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.parent_phone = null; } else {
      this.parent_phone = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_phone1 = null; } else {
      this.contact_phone1 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_phone2 = null; } else {
      this.contact_phone2 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.contact_phone3 = null; } else {
      this.contact_phone3 = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.am_audit_time = null; } else {
      this.am_audit_time = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.home_address = null; } else {
      this.home_address = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.bank_card_no = null; } else {
      this.bank_card_no = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.bank_name = null; } else {
      this.bank_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.user_id = null; } else {
      this.user_id = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.auto_decision = null; } else {
      this.auto_decision = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.auto_decision_date = null; } else {
      this.auto_decision_date = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.isnewuser = null; } else {
      this.isnewuser = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.rule_id = null; } else {
      this.rule_id = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.is_tongdun = null; } else {
      this.is_tongdun = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.is_black_gray = null; } else {
      this.is_black_gray = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.userriskbill = null; } else {
      this.userriskbill = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.address_home = null; } else {
      this.address_home = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.bl_graduate_time = null; } else {
      this.bl_graduate_time = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.is_gjj_submit = null; } else {
      this.is_gjj_submit = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.mobile_address = null; } else {
      this.mobile_address = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.pass_rule = null; } else {
      this.pass_rule = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.apply_channel = null; } else {
      this.apply_channel = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.auto_decision_code = null; } else {
      this.auto_decision_code = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.publish_duration = null; } else {
      this.publish_duration = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.confirm_duration = null; } else {
      this.confirm_duration = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.lend_duration = null; } else {
      this.lend_duration = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.is_stock_campaign = null; } else {
      this.is_stock_campaign = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    FACT_APPLY_DAILY o = (FACT_APPLY_DAILY) super.clone();
    o.apply_date = (o.apply_date != null) ? (java.sql.Timestamp) o.apply_date.clone() : null;
    o.am_audit_time = (o.am_audit_time != null) ? (java.sql.Timestamp) o.am_audit_time.clone() : null;
    o.auto_decision_date = (o.auto_decision_date != null) ? (java.sql.Timestamp) o.auto_decision_date.clone() : null;
    return o;
  }

  public void clone0(FACT_APPLY_DAILY o) throws CloneNotSupportedException {
    o.apply_date = (o.apply_date != null) ? (java.sql.Timestamp) o.apply_date.clone() : null;
    o.am_audit_time = (o.am_audit_time != null) ? (java.sql.Timestamp) o.am_audit_time.clone() : null;
    o.auto_decision_date = (o.auto_decision_date != null) ? (java.sql.Timestamp) o.auto_decision_date.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("stat_date", this.stat_date);
    __sqoop$field_map.put("apply_no", this.apply_no);
    __sqoop$field_map.put("apply_name", this.apply_name);
    __sqoop$field_map.put("identity_card_id", this.identity_card_id);
    __sqoop$field_map.put("age", this.age);
    __sqoop$field_map.put("sex", this.sex);
    __sqoop$field_map.put("huji_province", this.huji_province);
    __sqoop$field_map.put("huji_city", this.huji_city);
    __sqoop$field_map.put("current_province", this.current_province);
    __sqoop$field_map.put("current_city", this.current_city);
    __sqoop$field_map.put("school_name", this.school_name);
    __sqoop$field_map.put("school_type", this.school_type);
    __sqoop$field_map.put("school_city", this.school_city);
    __sqoop$field_map.put("school_province", this.school_province);
    __sqoop$field_map.put("major_name", this.major_name);
    __sqoop$field_map.put("grade", this.grade);
    __sqoop$field_map.put("education", this.education);
    __sqoop$field_map.put("enter_school_date", this.enter_school_date);
    __sqoop$field_map.put("graduate_flag", this.graduate_flag);
    __sqoop$field_map.put("graduate_date", this.graduate_date);
    __sqoop$field_map.put("phone_no", this.phone_no);
    __sqoop$field_map.put("phone_instructor_no", this.phone_instructor_no);
    __sqoop$field_map.put("phone_parents_no", this.phone_parents_no);
    __sqoop$field_map.put("phone_contact1_no", this.phone_contact1_no);
    __sqoop$field_map.put("phone_contact2_no", this.phone_contact2_no);
    __sqoop$field_map.put("phone_contact3_no", this.phone_contact3_no);
    __sqoop$field_map.put("qq", this.qq);
    __sqoop$field_map.put("email", this.email);
    __sqoop$field_map.put("occupation", this.occupation);
    __sqoop$field_map.put("working_year", this.working_year);
    __sqoop$field_map.put("company_name", this.company_name);
    __sqoop$field_map.put("company_type", this.company_type);
    __sqoop$field_map.put("phone_company_no", this.phone_company_no);
    __sqoop$field_map.put("apply_date", this.apply_date);
    __sqoop$field_map.put("product", this.product);
    __sqoop$field_map.put("apply_amt", this.apply_amt);
    __sqoop$field_map.put("apply_term", this.apply_term);
    __sqoop$field_map.put("sign_result", this.sign_result);
    __sqoop$field_map.put("approve_result", this.approve_result);
    __sqoop$field_map.put("approve_amt", this.approve_amt);
    __sqoop$field_map.put("refuse_reason", this.refuse_reason);
    __sqoop$field_map.put("cancell_reason", this.cancell_reason);
    __sqoop$field_map.put("back_reason", this.back_reason);
    __sqoop$field_map.put("channel", this.channel);
    __sqoop$field_map.put("resource", this.resource);
    __sqoop$field_map.put("purpose", this.purpose);
    __sqoop$field_map.put("score", this.score);
    __sqoop$field_map.put("level", this.level);
    __sqoop$field_map.put("video_flag", this.video_flag);
    __sqoop$field_map.put("phonecall_flag", this.phonecall_flag);
    __sqoop$field_map.put("phonecall_parents_flag", this.phonecall_parents_flag);
    __sqoop$field_map.put("phonecall_guider_flag", this.phonecall_guider_flag);
    __sqoop$field_map.put("phonecall_contact1_flag", this.phonecall_contact1_flag);
    __sqoop$field_map.put("phonecall_contact2_flag", this.phonecall_contact2_flag);
    __sqoop$field_map.put("phonecall_contact3_flag", this.phonecall_contact3_flag);
    __sqoop$field_map.put("register_ip", this.register_ip);
    __sqoop$field_map.put("student_certificate1_flag", this.student_certificate1_flag);
    __sqoop$field_map.put("student_certificate2_flag", this.student_certificate2_flag);
    __sqoop$field_map.put("insurance_society_flag", this.insurance_society_flag);
    __sqoop$field_map.put("family_income_amt", this.family_income_amt);
    __sqoop$field_map.put("fraud_flag", this.fraud_flag);
    __sqoop$field_map.put("fraud_type", this.fraud_type);
    __sqoop$field_map.put("merchant_name", this.merchant_name);
    __sqoop$field_map.put("counsellor_name", this.counsellor_name);
    __sqoop$field_map.put("parent_name", this.parent_name);
    __sqoop$field_map.put("contact_name1", this.contact_name1);
    __sqoop$field_map.put("contact_name2", this.contact_name2);
    __sqoop$field_map.put("contact_name3", this.contact_name3);
    __sqoop$field_map.put("counsellor_phone", this.counsellor_phone);
    __sqoop$field_map.put("parent_phone", this.parent_phone);
    __sqoop$field_map.put("contact_phone1", this.contact_phone1);
    __sqoop$field_map.put("contact_phone2", this.contact_phone2);
    __sqoop$field_map.put("contact_phone3", this.contact_phone3);
    __sqoop$field_map.put("am_audit_time", this.am_audit_time);
    __sqoop$field_map.put("home_address", this.home_address);
    __sqoop$field_map.put("bank_card_no", this.bank_card_no);
    __sqoop$field_map.put("bank_name", this.bank_name);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("auto_decision", this.auto_decision);
    __sqoop$field_map.put("auto_decision_date", this.auto_decision_date);
    __sqoop$field_map.put("isnewuser", this.isnewuser);
    __sqoop$field_map.put("rule_id", this.rule_id);
    __sqoop$field_map.put("is_tongdun", this.is_tongdun);
    __sqoop$field_map.put("is_black_gray", this.is_black_gray);
    __sqoop$field_map.put("userriskbill", this.userriskbill);
    __sqoop$field_map.put("address_home", this.address_home);
    __sqoop$field_map.put("bl_graduate_time", this.bl_graduate_time);
    __sqoop$field_map.put("is_gjj_submit", this.is_gjj_submit);
    __sqoop$field_map.put("mobile_address", this.mobile_address);
    __sqoop$field_map.put("pass_rule", this.pass_rule);
    __sqoop$field_map.put("apply_channel", this.apply_channel);
    __sqoop$field_map.put("auto_decision_code", this.auto_decision_code);
    __sqoop$field_map.put("publish_duration", this.publish_duration);
    __sqoop$field_map.put("confirm_duration", this.confirm_duration);
    __sqoop$field_map.put("lend_duration", this.lend_duration);
    __sqoop$field_map.put("is_stock_campaign", this.is_stock_campaign);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("stat_date", this.stat_date);
    __sqoop$field_map.put("apply_no", this.apply_no);
    __sqoop$field_map.put("apply_name", this.apply_name);
    __sqoop$field_map.put("identity_card_id", this.identity_card_id);
    __sqoop$field_map.put("age", this.age);
    __sqoop$field_map.put("sex", this.sex);
    __sqoop$field_map.put("huji_province", this.huji_province);
    __sqoop$field_map.put("huji_city", this.huji_city);
    __sqoop$field_map.put("current_province", this.current_province);
    __sqoop$field_map.put("current_city", this.current_city);
    __sqoop$field_map.put("school_name", this.school_name);
    __sqoop$field_map.put("school_type", this.school_type);
    __sqoop$field_map.put("school_city", this.school_city);
    __sqoop$field_map.put("school_province", this.school_province);
    __sqoop$field_map.put("major_name", this.major_name);
    __sqoop$field_map.put("grade", this.grade);
    __sqoop$field_map.put("education", this.education);
    __sqoop$field_map.put("enter_school_date", this.enter_school_date);
    __sqoop$field_map.put("graduate_flag", this.graduate_flag);
    __sqoop$field_map.put("graduate_date", this.graduate_date);
    __sqoop$field_map.put("phone_no", this.phone_no);
    __sqoop$field_map.put("phone_instructor_no", this.phone_instructor_no);
    __sqoop$field_map.put("phone_parents_no", this.phone_parents_no);
    __sqoop$field_map.put("phone_contact1_no", this.phone_contact1_no);
    __sqoop$field_map.put("phone_contact2_no", this.phone_contact2_no);
    __sqoop$field_map.put("phone_contact3_no", this.phone_contact3_no);
    __sqoop$field_map.put("qq", this.qq);
    __sqoop$field_map.put("email", this.email);
    __sqoop$field_map.put("occupation", this.occupation);
    __sqoop$field_map.put("working_year", this.working_year);
    __sqoop$field_map.put("company_name", this.company_name);
    __sqoop$field_map.put("company_type", this.company_type);
    __sqoop$field_map.put("phone_company_no", this.phone_company_no);
    __sqoop$field_map.put("apply_date", this.apply_date);
    __sqoop$field_map.put("product", this.product);
    __sqoop$field_map.put("apply_amt", this.apply_amt);
    __sqoop$field_map.put("apply_term", this.apply_term);
    __sqoop$field_map.put("sign_result", this.sign_result);
    __sqoop$field_map.put("approve_result", this.approve_result);
    __sqoop$field_map.put("approve_amt", this.approve_amt);
    __sqoop$field_map.put("refuse_reason", this.refuse_reason);
    __sqoop$field_map.put("cancell_reason", this.cancell_reason);
    __sqoop$field_map.put("back_reason", this.back_reason);
    __sqoop$field_map.put("channel", this.channel);
    __sqoop$field_map.put("resource", this.resource);
    __sqoop$field_map.put("purpose", this.purpose);
    __sqoop$field_map.put("score", this.score);
    __sqoop$field_map.put("level", this.level);
    __sqoop$field_map.put("video_flag", this.video_flag);
    __sqoop$field_map.put("phonecall_flag", this.phonecall_flag);
    __sqoop$field_map.put("phonecall_parents_flag", this.phonecall_parents_flag);
    __sqoop$field_map.put("phonecall_guider_flag", this.phonecall_guider_flag);
    __sqoop$field_map.put("phonecall_contact1_flag", this.phonecall_contact1_flag);
    __sqoop$field_map.put("phonecall_contact2_flag", this.phonecall_contact2_flag);
    __sqoop$field_map.put("phonecall_contact3_flag", this.phonecall_contact3_flag);
    __sqoop$field_map.put("register_ip", this.register_ip);
    __sqoop$field_map.put("student_certificate1_flag", this.student_certificate1_flag);
    __sqoop$field_map.put("student_certificate2_flag", this.student_certificate2_flag);
    __sqoop$field_map.put("insurance_society_flag", this.insurance_society_flag);
    __sqoop$field_map.put("family_income_amt", this.family_income_amt);
    __sqoop$field_map.put("fraud_flag", this.fraud_flag);
    __sqoop$field_map.put("fraud_type", this.fraud_type);
    __sqoop$field_map.put("merchant_name", this.merchant_name);
    __sqoop$field_map.put("counsellor_name", this.counsellor_name);
    __sqoop$field_map.put("parent_name", this.parent_name);
    __sqoop$field_map.put("contact_name1", this.contact_name1);
    __sqoop$field_map.put("contact_name2", this.contact_name2);
    __sqoop$field_map.put("contact_name3", this.contact_name3);
    __sqoop$field_map.put("counsellor_phone", this.counsellor_phone);
    __sqoop$field_map.put("parent_phone", this.parent_phone);
    __sqoop$field_map.put("contact_phone1", this.contact_phone1);
    __sqoop$field_map.put("contact_phone2", this.contact_phone2);
    __sqoop$field_map.put("contact_phone3", this.contact_phone3);
    __sqoop$field_map.put("am_audit_time", this.am_audit_time);
    __sqoop$field_map.put("home_address", this.home_address);
    __sqoop$field_map.put("bank_card_no", this.bank_card_no);
    __sqoop$field_map.put("bank_name", this.bank_name);
    __sqoop$field_map.put("user_id", this.user_id);
    __sqoop$field_map.put("auto_decision", this.auto_decision);
    __sqoop$field_map.put("auto_decision_date", this.auto_decision_date);
    __sqoop$field_map.put("isnewuser", this.isnewuser);
    __sqoop$field_map.put("rule_id", this.rule_id);
    __sqoop$field_map.put("is_tongdun", this.is_tongdun);
    __sqoop$field_map.put("is_black_gray", this.is_black_gray);
    __sqoop$field_map.put("userriskbill", this.userriskbill);
    __sqoop$field_map.put("address_home", this.address_home);
    __sqoop$field_map.put("bl_graduate_time", this.bl_graduate_time);
    __sqoop$field_map.put("is_gjj_submit", this.is_gjj_submit);
    __sqoop$field_map.put("mobile_address", this.mobile_address);
    __sqoop$field_map.put("pass_rule", this.pass_rule);
    __sqoop$field_map.put("apply_channel", this.apply_channel);
    __sqoop$field_map.put("auto_decision_code", this.auto_decision_code);
    __sqoop$field_map.put("publish_duration", this.publish_duration);
    __sqoop$field_map.put("confirm_duration", this.confirm_duration);
    __sqoop$field_map.put("lend_duration", this.lend_duration);
    __sqoop$field_map.put("is_stock_campaign", this.is_stock_campaign);
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
    else    if ("identity_card_id".equals(__fieldName)) {
      this.identity_card_id = (String) __fieldVal;
    }
    else    if ("age".equals(__fieldName)) {
      this.age = (Integer) __fieldVal;
    }
    else    if ("sex".equals(__fieldName)) {
      this.sex = (String) __fieldVal;
    }
    else    if ("huji_province".equals(__fieldName)) {
      this.huji_province = (String) __fieldVal;
    }
    else    if ("huji_city".equals(__fieldName)) {
      this.huji_city = (String) __fieldVal;
    }
    else    if ("current_province".equals(__fieldName)) {
      this.current_province = (String) __fieldVal;
    }
    else    if ("current_city".equals(__fieldName)) {
      this.current_city = (String) __fieldVal;
    }
    else    if ("school_name".equals(__fieldName)) {
      this.school_name = (String) __fieldVal;
    }
    else    if ("school_type".equals(__fieldName)) {
      this.school_type = (String) __fieldVal;
    }
    else    if ("school_city".equals(__fieldName)) {
      this.school_city = (String) __fieldVal;
    }
    else    if ("school_province".equals(__fieldName)) {
      this.school_province = (String) __fieldVal;
    }
    else    if ("major_name".equals(__fieldName)) {
      this.major_name = (String) __fieldVal;
    }
    else    if ("grade".equals(__fieldName)) {
      this.grade = (String) __fieldVal;
    }
    else    if ("education".equals(__fieldName)) {
      this.education = (String) __fieldVal;
    }
    else    if ("enter_school_date".equals(__fieldName)) {
      this.enter_school_date = (String) __fieldVal;
    }
    else    if ("graduate_flag".equals(__fieldName)) {
      this.graduate_flag = (Integer) __fieldVal;
    }
    else    if ("graduate_date".equals(__fieldName)) {
      this.graduate_date = (String) __fieldVal;
    }
    else    if ("phone_no".equals(__fieldName)) {
      this.phone_no = (String) __fieldVal;
    }
    else    if ("phone_instructor_no".equals(__fieldName)) {
      this.phone_instructor_no = (String) __fieldVal;
    }
    else    if ("phone_parents_no".equals(__fieldName)) {
      this.phone_parents_no = (String) __fieldVal;
    }
    else    if ("phone_contact1_no".equals(__fieldName)) {
      this.phone_contact1_no = (String) __fieldVal;
    }
    else    if ("phone_contact2_no".equals(__fieldName)) {
      this.phone_contact2_no = (String) __fieldVal;
    }
    else    if ("phone_contact3_no".equals(__fieldName)) {
      this.phone_contact3_no = (String) __fieldVal;
    }
    else    if ("qq".equals(__fieldName)) {
      this.qq = (String) __fieldVal;
    }
    else    if ("email".equals(__fieldName)) {
      this.email = (String) __fieldVal;
    }
    else    if ("occupation".equals(__fieldName)) {
      this.occupation = (String) __fieldVal;
    }
    else    if ("working_year".equals(__fieldName)) {
      this.working_year = (Integer) __fieldVal;
    }
    else    if ("company_name".equals(__fieldName)) {
      this.company_name = (String) __fieldVal;
    }
    else    if ("company_type".equals(__fieldName)) {
      this.company_type = (Integer) __fieldVal;
    }
    else    if ("phone_company_no".equals(__fieldName)) {
      this.phone_company_no = (String) __fieldVal;
    }
    else    if ("apply_date".equals(__fieldName)) {
      this.apply_date = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("product".equals(__fieldName)) {
      this.product = (String) __fieldVal;
    }
    else    if ("apply_amt".equals(__fieldName)) {
      this.apply_amt = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("apply_term".equals(__fieldName)) {
      this.apply_term = (Integer) __fieldVal;
    }
    else    if ("sign_result".equals(__fieldName)) {
      this.sign_result = (String) __fieldVal;
    }
    else    if ("approve_result".equals(__fieldName)) {
      this.approve_result = (String) __fieldVal;
    }
    else    if ("approve_amt".equals(__fieldName)) {
      this.approve_amt = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("refuse_reason".equals(__fieldName)) {
      this.refuse_reason = (String) __fieldVal;
    }
    else    if ("cancell_reason".equals(__fieldName)) {
      this.cancell_reason = (String) __fieldVal;
    }
    else    if ("back_reason".equals(__fieldName)) {
      this.back_reason = (String) __fieldVal;
    }
    else    if ("channel".equals(__fieldName)) {
      this.channel = (String) __fieldVal;
    }
    else    if ("resource".equals(__fieldName)) {
      this.resource = (String) __fieldVal;
    }
    else    if ("purpose".equals(__fieldName)) {
      this.purpose = (String) __fieldVal;
    }
    else    if ("score".equals(__fieldName)) {
      this.score = (String) __fieldVal;
    }
    else    if ("level".equals(__fieldName)) {
      this.level = (String) __fieldVal;
    }
    else    if ("video_flag".equals(__fieldName)) {
      this.video_flag = (Integer) __fieldVal;
    }
    else    if ("phonecall_flag".equals(__fieldName)) {
      this.phonecall_flag = (String) __fieldVal;
    }
    else    if ("phonecall_parents_flag".equals(__fieldName)) {
      this.phonecall_parents_flag = (String) __fieldVal;
    }
    else    if ("phonecall_guider_flag".equals(__fieldName)) {
      this.phonecall_guider_flag = (String) __fieldVal;
    }
    else    if ("phonecall_contact1_flag".equals(__fieldName)) {
      this.phonecall_contact1_flag = (String) __fieldVal;
    }
    else    if ("phonecall_contact2_flag".equals(__fieldName)) {
      this.phonecall_contact2_flag = (String) __fieldVal;
    }
    else    if ("phonecall_contact3_flag".equals(__fieldName)) {
      this.phonecall_contact3_flag = (String) __fieldVal;
    }
    else    if ("register_ip".equals(__fieldName)) {
      this.register_ip = (String) __fieldVal;
    }
    else    if ("student_certificate1_flag".equals(__fieldName)) {
      this.student_certificate1_flag = (Integer) __fieldVal;
    }
    else    if ("student_certificate2_flag".equals(__fieldName)) {
      this.student_certificate2_flag = (Integer) __fieldVal;
    }
    else    if ("insurance_society_flag".equals(__fieldName)) {
      this.insurance_society_flag = (Integer) __fieldVal;
    }
    else    if ("family_income_amt".equals(__fieldName)) {
      this.family_income_amt = (Integer) __fieldVal;
    }
    else    if ("fraud_flag".equals(__fieldName)) {
      this.fraud_flag = (Integer) __fieldVal;
    }
    else    if ("fraud_type".equals(__fieldName)) {
      this.fraud_type = (String) __fieldVal;
    }
    else    if ("merchant_name".equals(__fieldName)) {
      this.merchant_name = (String) __fieldVal;
    }
    else    if ("counsellor_name".equals(__fieldName)) {
      this.counsellor_name = (String) __fieldVal;
    }
    else    if ("parent_name".equals(__fieldName)) {
      this.parent_name = (String) __fieldVal;
    }
    else    if ("contact_name1".equals(__fieldName)) {
      this.contact_name1 = (String) __fieldVal;
    }
    else    if ("contact_name2".equals(__fieldName)) {
      this.contact_name2 = (String) __fieldVal;
    }
    else    if ("contact_name3".equals(__fieldName)) {
      this.contact_name3 = (String) __fieldVal;
    }
    else    if ("counsellor_phone".equals(__fieldName)) {
      this.counsellor_phone = (String) __fieldVal;
    }
    else    if ("parent_phone".equals(__fieldName)) {
      this.parent_phone = (String) __fieldVal;
    }
    else    if ("contact_phone1".equals(__fieldName)) {
      this.contact_phone1 = (String) __fieldVal;
    }
    else    if ("contact_phone2".equals(__fieldName)) {
      this.contact_phone2 = (String) __fieldVal;
    }
    else    if ("contact_phone3".equals(__fieldName)) {
      this.contact_phone3 = (String) __fieldVal;
    }
    else    if ("am_audit_time".equals(__fieldName)) {
      this.am_audit_time = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("home_address".equals(__fieldName)) {
      this.home_address = (String) __fieldVal;
    }
    else    if ("bank_card_no".equals(__fieldName)) {
      this.bank_card_no = (String) __fieldVal;
    }
    else    if ("bank_name".equals(__fieldName)) {
      this.bank_name = (String) __fieldVal;
    }
    else    if ("user_id".equals(__fieldName)) {
      this.user_id = (Long) __fieldVal;
    }
    else    if ("auto_decision".equals(__fieldName)) {
      this.auto_decision = (String) __fieldVal;
    }
    else    if ("auto_decision_date".equals(__fieldName)) {
      this.auto_decision_date = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("isnewuser".equals(__fieldName)) {
      this.isnewuser = (String) __fieldVal;
    }
    else    if ("rule_id".equals(__fieldName)) {
      this.rule_id = (String) __fieldVal;
    }
    else    if ("is_tongdun".equals(__fieldName)) {
      this.is_tongdun = (String) __fieldVal;
    }
    else    if ("is_black_gray".equals(__fieldName)) {
      this.is_black_gray = (String) __fieldVal;
    }
    else    if ("userriskbill".equals(__fieldName)) {
      this.userriskbill = (String) __fieldVal;
    }
    else    if ("address_home".equals(__fieldName)) {
      this.address_home = (String) __fieldVal;
    }
    else    if ("bl_graduate_time".equals(__fieldName)) {
      this.bl_graduate_time = (String) __fieldVal;
    }
    else    if ("is_gjj_submit".equals(__fieldName)) {
      this.is_gjj_submit = (String) __fieldVal;
    }
    else    if ("mobile_address".equals(__fieldName)) {
      this.mobile_address = (String) __fieldVal;
    }
    else    if ("pass_rule".equals(__fieldName)) {
      this.pass_rule = (String) __fieldVal;
    }
    else    if ("apply_channel".equals(__fieldName)) {
      this.apply_channel = (String) __fieldVal;
    }
    else    if ("auto_decision_code".equals(__fieldName)) {
      this.auto_decision_code = (String) __fieldVal;
    }
    else    if ("publish_duration".equals(__fieldName)) {
      this.publish_duration = (Integer) __fieldVal;
    }
    else    if ("confirm_duration".equals(__fieldName)) {
      this.confirm_duration = (Integer) __fieldVal;
    }
    else    if ("lend_duration".equals(__fieldName)) {
      this.lend_duration = (Integer) __fieldVal;
    }
    else    if ("is_stock_campaign".equals(__fieldName)) {
      this.is_stock_campaign = (String) __fieldVal;
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
    else    if ("identity_card_id".equals(__fieldName)) {
      this.identity_card_id = (String) __fieldVal;
      return true;
    }
    else    if ("age".equals(__fieldName)) {
      this.age = (Integer) __fieldVal;
      return true;
    }
    else    if ("sex".equals(__fieldName)) {
      this.sex = (String) __fieldVal;
      return true;
    }
    else    if ("huji_province".equals(__fieldName)) {
      this.huji_province = (String) __fieldVal;
      return true;
    }
    else    if ("huji_city".equals(__fieldName)) {
      this.huji_city = (String) __fieldVal;
      return true;
    }
    else    if ("current_province".equals(__fieldName)) {
      this.current_province = (String) __fieldVal;
      return true;
    }
    else    if ("current_city".equals(__fieldName)) {
      this.current_city = (String) __fieldVal;
      return true;
    }
    else    if ("school_name".equals(__fieldName)) {
      this.school_name = (String) __fieldVal;
      return true;
    }
    else    if ("school_type".equals(__fieldName)) {
      this.school_type = (String) __fieldVal;
      return true;
    }
    else    if ("school_city".equals(__fieldName)) {
      this.school_city = (String) __fieldVal;
      return true;
    }
    else    if ("school_province".equals(__fieldName)) {
      this.school_province = (String) __fieldVal;
      return true;
    }
    else    if ("major_name".equals(__fieldName)) {
      this.major_name = (String) __fieldVal;
      return true;
    }
    else    if ("grade".equals(__fieldName)) {
      this.grade = (String) __fieldVal;
      return true;
    }
    else    if ("education".equals(__fieldName)) {
      this.education = (String) __fieldVal;
      return true;
    }
    else    if ("enter_school_date".equals(__fieldName)) {
      this.enter_school_date = (String) __fieldVal;
      return true;
    }
    else    if ("graduate_flag".equals(__fieldName)) {
      this.graduate_flag = (Integer) __fieldVal;
      return true;
    }
    else    if ("graduate_date".equals(__fieldName)) {
      this.graduate_date = (String) __fieldVal;
      return true;
    }
    else    if ("phone_no".equals(__fieldName)) {
      this.phone_no = (String) __fieldVal;
      return true;
    }
    else    if ("phone_instructor_no".equals(__fieldName)) {
      this.phone_instructor_no = (String) __fieldVal;
      return true;
    }
    else    if ("phone_parents_no".equals(__fieldName)) {
      this.phone_parents_no = (String) __fieldVal;
      return true;
    }
    else    if ("phone_contact1_no".equals(__fieldName)) {
      this.phone_contact1_no = (String) __fieldVal;
      return true;
    }
    else    if ("phone_contact2_no".equals(__fieldName)) {
      this.phone_contact2_no = (String) __fieldVal;
      return true;
    }
    else    if ("phone_contact3_no".equals(__fieldName)) {
      this.phone_contact3_no = (String) __fieldVal;
      return true;
    }
    else    if ("qq".equals(__fieldName)) {
      this.qq = (String) __fieldVal;
      return true;
    }
    else    if ("email".equals(__fieldName)) {
      this.email = (String) __fieldVal;
      return true;
    }
    else    if ("occupation".equals(__fieldName)) {
      this.occupation = (String) __fieldVal;
      return true;
    }
    else    if ("working_year".equals(__fieldName)) {
      this.working_year = (Integer) __fieldVal;
      return true;
    }
    else    if ("company_name".equals(__fieldName)) {
      this.company_name = (String) __fieldVal;
      return true;
    }
    else    if ("company_type".equals(__fieldName)) {
      this.company_type = (Integer) __fieldVal;
      return true;
    }
    else    if ("phone_company_no".equals(__fieldName)) {
      this.phone_company_no = (String) __fieldVal;
      return true;
    }
    else    if ("apply_date".equals(__fieldName)) {
      this.apply_date = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("product".equals(__fieldName)) {
      this.product = (String) __fieldVal;
      return true;
    }
    else    if ("apply_amt".equals(__fieldName)) {
      this.apply_amt = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("apply_term".equals(__fieldName)) {
      this.apply_term = (Integer) __fieldVal;
      return true;
    }
    else    if ("sign_result".equals(__fieldName)) {
      this.sign_result = (String) __fieldVal;
      return true;
    }
    else    if ("approve_result".equals(__fieldName)) {
      this.approve_result = (String) __fieldVal;
      return true;
    }
    else    if ("approve_amt".equals(__fieldName)) {
      this.approve_amt = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("refuse_reason".equals(__fieldName)) {
      this.refuse_reason = (String) __fieldVal;
      return true;
    }
    else    if ("cancell_reason".equals(__fieldName)) {
      this.cancell_reason = (String) __fieldVal;
      return true;
    }
    else    if ("back_reason".equals(__fieldName)) {
      this.back_reason = (String) __fieldVal;
      return true;
    }
    else    if ("channel".equals(__fieldName)) {
      this.channel = (String) __fieldVal;
      return true;
    }
    else    if ("resource".equals(__fieldName)) {
      this.resource = (String) __fieldVal;
      return true;
    }
    else    if ("purpose".equals(__fieldName)) {
      this.purpose = (String) __fieldVal;
      return true;
    }
    else    if ("score".equals(__fieldName)) {
      this.score = (String) __fieldVal;
      return true;
    }
    else    if ("level".equals(__fieldName)) {
      this.level = (String) __fieldVal;
      return true;
    }
    else    if ("video_flag".equals(__fieldName)) {
      this.video_flag = (Integer) __fieldVal;
      return true;
    }
    else    if ("phonecall_flag".equals(__fieldName)) {
      this.phonecall_flag = (String) __fieldVal;
      return true;
    }
    else    if ("phonecall_parents_flag".equals(__fieldName)) {
      this.phonecall_parents_flag = (String) __fieldVal;
      return true;
    }
    else    if ("phonecall_guider_flag".equals(__fieldName)) {
      this.phonecall_guider_flag = (String) __fieldVal;
      return true;
    }
    else    if ("phonecall_contact1_flag".equals(__fieldName)) {
      this.phonecall_contact1_flag = (String) __fieldVal;
      return true;
    }
    else    if ("phonecall_contact2_flag".equals(__fieldName)) {
      this.phonecall_contact2_flag = (String) __fieldVal;
      return true;
    }
    else    if ("phonecall_contact3_flag".equals(__fieldName)) {
      this.phonecall_contact3_flag = (String) __fieldVal;
      return true;
    }
    else    if ("register_ip".equals(__fieldName)) {
      this.register_ip = (String) __fieldVal;
      return true;
    }
    else    if ("student_certificate1_flag".equals(__fieldName)) {
      this.student_certificate1_flag = (Integer) __fieldVal;
      return true;
    }
    else    if ("student_certificate2_flag".equals(__fieldName)) {
      this.student_certificate2_flag = (Integer) __fieldVal;
      return true;
    }
    else    if ("insurance_society_flag".equals(__fieldName)) {
      this.insurance_society_flag = (Integer) __fieldVal;
      return true;
    }
    else    if ("family_income_amt".equals(__fieldName)) {
      this.family_income_amt = (Integer) __fieldVal;
      return true;
    }
    else    if ("fraud_flag".equals(__fieldName)) {
      this.fraud_flag = (Integer) __fieldVal;
      return true;
    }
    else    if ("fraud_type".equals(__fieldName)) {
      this.fraud_type = (String) __fieldVal;
      return true;
    }
    else    if ("merchant_name".equals(__fieldName)) {
      this.merchant_name = (String) __fieldVal;
      return true;
    }
    else    if ("counsellor_name".equals(__fieldName)) {
      this.counsellor_name = (String) __fieldVal;
      return true;
    }
    else    if ("parent_name".equals(__fieldName)) {
      this.parent_name = (String) __fieldVal;
      return true;
    }
    else    if ("contact_name1".equals(__fieldName)) {
      this.contact_name1 = (String) __fieldVal;
      return true;
    }
    else    if ("contact_name2".equals(__fieldName)) {
      this.contact_name2 = (String) __fieldVal;
      return true;
    }
    else    if ("contact_name3".equals(__fieldName)) {
      this.contact_name3 = (String) __fieldVal;
      return true;
    }
    else    if ("counsellor_phone".equals(__fieldName)) {
      this.counsellor_phone = (String) __fieldVal;
      return true;
    }
    else    if ("parent_phone".equals(__fieldName)) {
      this.parent_phone = (String) __fieldVal;
      return true;
    }
    else    if ("contact_phone1".equals(__fieldName)) {
      this.contact_phone1 = (String) __fieldVal;
      return true;
    }
    else    if ("contact_phone2".equals(__fieldName)) {
      this.contact_phone2 = (String) __fieldVal;
      return true;
    }
    else    if ("contact_phone3".equals(__fieldName)) {
      this.contact_phone3 = (String) __fieldVal;
      return true;
    }
    else    if ("am_audit_time".equals(__fieldName)) {
      this.am_audit_time = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("home_address".equals(__fieldName)) {
      this.home_address = (String) __fieldVal;
      return true;
    }
    else    if ("bank_card_no".equals(__fieldName)) {
      this.bank_card_no = (String) __fieldVal;
      return true;
    }
    else    if ("bank_name".equals(__fieldName)) {
      this.bank_name = (String) __fieldVal;
      return true;
    }
    else    if ("user_id".equals(__fieldName)) {
      this.user_id = (Long) __fieldVal;
      return true;
    }
    else    if ("auto_decision".equals(__fieldName)) {
      this.auto_decision = (String) __fieldVal;
      return true;
    }
    else    if ("auto_decision_date".equals(__fieldName)) {
      this.auto_decision_date = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("isnewuser".equals(__fieldName)) {
      this.isnewuser = (String) __fieldVal;
      return true;
    }
    else    if ("rule_id".equals(__fieldName)) {
      this.rule_id = (String) __fieldVal;
      return true;
    }
    else    if ("is_tongdun".equals(__fieldName)) {
      this.is_tongdun = (String) __fieldVal;
      return true;
    }
    else    if ("is_black_gray".equals(__fieldName)) {
      this.is_black_gray = (String) __fieldVal;
      return true;
    }
    else    if ("userriskbill".equals(__fieldName)) {
      this.userriskbill = (String) __fieldVal;
      return true;
    }
    else    if ("address_home".equals(__fieldName)) {
      this.address_home = (String) __fieldVal;
      return true;
    }
    else    if ("bl_graduate_time".equals(__fieldName)) {
      this.bl_graduate_time = (String) __fieldVal;
      return true;
    }
    else    if ("is_gjj_submit".equals(__fieldName)) {
      this.is_gjj_submit = (String) __fieldVal;
      return true;
    }
    else    if ("mobile_address".equals(__fieldName)) {
      this.mobile_address = (String) __fieldVal;
      return true;
    }
    else    if ("pass_rule".equals(__fieldName)) {
      this.pass_rule = (String) __fieldVal;
      return true;
    }
    else    if ("apply_channel".equals(__fieldName)) {
      this.apply_channel = (String) __fieldVal;
      return true;
    }
    else    if ("auto_decision_code".equals(__fieldName)) {
      this.auto_decision_code = (String) __fieldVal;
      return true;
    }
    else    if ("publish_duration".equals(__fieldName)) {
      this.publish_duration = (Integer) __fieldVal;
      return true;
    }
    else    if ("confirm_duration".equals(__fieldName)) {
      this.confirm_duration = (Integer) __fieldVal;
      return true;
    }
    else    if ("lend_duration".equals(__fieldName)) {
      this.lend_duration = (Integer) __fieldVal;
      return true;
    }
    else    if ("is_stock_campaign".equals(__fieldName)) {
      this.is_stock_campaign = (String) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
