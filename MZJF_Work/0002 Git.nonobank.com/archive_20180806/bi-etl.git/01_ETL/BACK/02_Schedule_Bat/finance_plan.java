// ORM class for table 'finance_plan'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Thu Jul 20 09:07:10 CST 2017
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

public class finance_plan extends SqoopRecord  implements DBWritable, Writable {
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
  public finance_plan with_id(Long id) {
    this.id = id;
    return this;
  }
  private String title;
  public String get_title() {
    return title;
  }
  public void set_title(String title) {
    this.title = title;
  }
  public finance_plan with_title(String title) {
    this.title = title;
    return this;
  }
  private Integer scope;
  public Integer get_scope() {
    return scope;
  }
  public void set_scope(Integer scope) {
    this.scope = scope;
  }
  public finance_plan with_scope(Integer scope) {
    this.scope = scope;
    return this;
  }
  private java.math.BigDecimal price;
  public java.math.BigDecimal get_price() {
    return price;
  }
  public void set_price(java.math.BigDecimal price) {
    this.price = price;
  }
  public finance_plan with_price(java.math.BigDecimal price) {
    this.price = price;
    return this;
  }
  private java.math.BigDecimal price_finish;
  public java.math.BigDecimal get_price_finish() {
    return price_finish;
  }
  public void set_price_finish(java.math.BigDecimal price_finish) {
    this.price_finish = price_finish;
  }
  public finance_plan with_price_finish(java.math.BigDecimal price_finish) {
    this.price_finish = price_finish;
    return this;
  }
  private java.math.BigDecimal price_adjust;
  public java.math.BigDecimal get_price_adjust() {
    return price_adjust;
  }
  public void set_price_adjust(java.math.BigDecimal price_adjust) {
    this.price_adjust = price_adjust;
  }
  public finance_plan with_price_adjust(java.math.BigDecimal price_adjust) {
    this.price_adjust = price_adjust;
    return this;
  }
  private java.math.BigDecimal price_increment;
  public java.math.BigDecimal get_price_increment() {
    return price_increment;
  }
  public void set_price_increment(java.math.BigDecimal price_increment) {
    this.price_increment = price_increment;
  }
  public finance_plan with_price_increment(java.math.BigDecimal price_increment) {
    this.price_increment = price_increment;
    return this;
  }
  private java.math.BigDecimal price_min;
  public java.math.BigDecimal get_price_min() {
    return price_min;
  }
  public void set_price_min(java.math.BigDecimal price_min) {
    this.price_min = price_min;
  }
  public finance_plan with_price_min(java.math.BigDecimal price_min) {
    this.price_min = price_min;
    return this;
  }
  private java.math.BigDecimal price_max;
  public java.math.BigDecimal get_price_max() {
    return price_max;
  }
  public void set_price_max(java.math.BigDecimal price_max) {
    this.price_max = price_max;
  }
  public finance_plan with_price_max(java.math.BigDecimal price_max) {
    this.price_max = price_max;
    return this;
  }
  private java.math.BigDecimal rate_min;
  public java.math.BigDecimal get_rate_min() {
    return rate_min;
  }
  public void set_rate_min(java.math.BigDecimal rate_min) {
    this.rate_min = rate_min;
  }
  public finance_plan with_rate_min(java.math.BigDecimal rate_min) {
    this.rate_min = rate_min;
    return this;
  }
  private java.math.BigDecimal rate_max;
  public java.math.BigDecimal get_rate_max() {
    return rate_max;
  }
  public void set_rate_max(java.math.BigDecimal rate_max) {
    this.rate_max = rate_max;
  }
  public finance_plan with_rate_max(java.math.BigDecimal rate_max) {
    this.rate_max = rate_max;
    return this;
  }
  private Integer stop_bidding_days;
  public Integer get_stop_bidding_days() {
    return stop_bidding_days;
  }
  public void set_stop_bidding_days(Integer stop_bidding_days) {
    this.stop_bidding_days = stop_bidding_days;
  }
  public finance_plan with_stop_bidding_days(Integer stop_bidding_days) {
    this.stop_bidding_days = stop_bidding_days;
    return this;
  }
  private Boolean auto_bid;
  public Boolean get_auto_bid() {
    return auto_bid;
  }
  public void set_auto_bid(Boolean auto_bid) {
    this.auto_bid = auto_bid;
  }
  public finance_plan with_auto_bid(Boolean auto_bid) {
    this.auto_bid = auto_bid;
    return this;
  }
  private String earnings_intro;
  public String get_earnings_intro() {
    return earnings_intro;
  }
  public void set_earnings_intro(String earnings_intro) {
    this.earnings_intro = earnings_intro;
  }
  public finance_plan with_earnings_intro(String earnings_intro) {
    this.earnings_intro = earnings_intro;
    return this;
  }
  private String buy_limit;
  public String get_buy_limit() {
    return buy_limit;
  }
  public void set_buy_limit(String buy_limit) {
    this.buy_limit = buy_limit;
  }
  public finance_plan with_buy_limit(String buy_limit) {
    this.buy_limit = buy_limit;
    return this;
  }
  private String redeem_normal_way;
  public String get_redeem_normal_way() {
    return redeem_normal_way;
  }
  public void set_redeem_normal_way(String redeem_normal_way) {
    this.redeem_normal_way = redeem_normal_way;
  }
  public finance_plan with_redeem_normal_way(String redeem_normal_way) {
    this.redeem_normal_way = redeem_normal_way;
    return this;
  }
  private String redeem_other_way;
  public String get_redeem_other_way() {
    return redeem_other_way;
  }
  public void set_redeem_other_way(String redeem_other_way) {
    this.redeem_other_way = redeem_other_way;
  }
  public finance_plan with_redeem_other_way(String redeem_other_way) {
    this.redeem_other_way = redeem_other_way;
    return this;
  }
  private java.sql.Timestamp publish_date;
  public java.sql.Timestamp get_publish_date() {
    return publish_date;
  }
  public void set_publish_date(java.sql.Timestamp publish_date) {
    this.publish_date = publish_date;
  }
  public finance_plan with_publish_date(java.sql.Timestamp publish_date) {
    this.publish_date = publish_date;
    return this;
  }
  private java.sql.Date finish_date;
  public java.sql.Date get_finish_date() {
    return finish_date;
  }
  public void set_finish_date(java.sql.Date finish_date) {
    this.finish_date = finish_date;
  }
  public finance_plan with_finish_date(java.sql.Date finish_date) {
    this.finish_date = finish_date;
    return this;
  }
  private String slogan;
  public String get_slogan() {
    return slogan;
  }
  public void set_slogan(String slogan) {
    this.slogan = slogan;
  }
  public finance_plan with_slogan(String slogan) {
    this.slogan = slogan;
    return this;
  }
  private String explanation;
  public String get_explanation() {
    return explanation;
  }
  public void set_explanation(String explanation) {
    this.explanation = explanation;
  }
  public finance_plan with_explanation(String explanation) {
    this.explanation = explanation;
    return this;
  }
  private Integer expect;
  public Integer get_expect() {
    return expect;
  }
  public void set_expect(Integer expect) {
    this.expect = expect;
  }
  public finance_plan with_expect(Integer expect) {
    this.expect = expect;
    return this;
  }
  private Integer expect_unit;
  public Integer get_expect_unit() {
    return expect_unit;
  }
  public void set_expect_unit(Integer expect_unit) {
    this.expect_unit = expect_unit;
  }
  public finance_plan with_expect_unit(Integer expect_unit) {
    this.expect_unit = expect_unit;
    return this;
  }
  private java.sql.Date start_date;
  public java.sql.Date get_start_date() {
    return start_date;
  }
  public void set_start_date(java.sql.Date start_date) {
    this.start_date = start_date;
  }
  public finance_plan with_start_date(java.sql.Date start_date) {
    this.start_date = start_date;
    return this;
  }
  private Long operator;
  public Long get_operator() {
    return operator;
  }
  public void set_operator(Long operator) {
    this.operator = operator;
  }
  public finance_plan with_operator(Long operator) {
    this.operator = operator;
    return this;
  }
  private Integer STATUS;
  public Integer get_STATUS() {
    return STATUS;
  }
  public void set_STATUS(Integer STATUS) {
    this.STATUS = STATUS;
  }
  public finance_plan with_STATUS(Integer STATUS) {
    this.STATUS = STATUS;
    return this;
  }
  private String protect_plan;
  public String get_protect_plan() {
    return protect_plan;
  }
  public void set_protect_plan(String protect_plan) {
    this.protect_plan = protect_plan;
  }
  public finance_plan with_protect_plan(String protect_plan) {
    this.protect_plan = protect_plan;
    return this;
  }
  private Boolean transfer_enable;
  public Boolean get_transfer_enable() {
    return transfer_enable;
  }
  public void set_transfer_enable(Boolean transfer_enable) {
    this.transfer_enable = transfer_enable;
  }
  public finance_plan with_transfer_enable(Boolean transfer_enable) {
    this.transfer_enable = transfer_enable;
    return this;
  }
  private Integer need_bankcode;
  public Integer get_need_bankcode() {
    return need_bankcode;
  }
  public void set_need_bankcode(Integer need_bankcode) {
    this.need_bankcode = need_bankcode;
  }
  public finance_plan with_need_bankcode(Integer need_bankcode) {
    this.need_bankcode = need_bankcode;
    return this;
  }
  private String template;
  public String get_template() {
    return template;
  }
  public void set_template(String template) {
    this.template = template;
  }
  public finance_plan with_template(String template) {
    this.template = template;
    return this;
  }
  private Integer show_scope;
  public Integer get_show_scope() {
    return show_scope;
  }
  public void set_show_scope(Integer show_scope) {
    this.show_scope = show_scope;
  }
  public finance_plan with_show_scope(Integer show_scope) {
    this.show_scope = show_scope;
    return this;
  }
  private String suffix;
  public String get_suffix() {
    return suffix;
  }
  public void set_suffix(String suffix) {
    this.suffix = suffix;
  }
  public finance_plan with_suffix(String suffix) {
    this.suffix = suffix;
    return this;
  }
  private String rate_show;
  public String get_rate_show() {
    return rate_show;
  }
  public void set_rate_show(String rate_show) {
    this.rate_show = rate_show;
  }
  public finance_plan with_rate_show(String rate_show) {
    this.rate_show = rate_show;
    return this;
  }
  private String user_level;
  public String get_user_level() {
    return user_level;
  }
  public void set_user_level(String user_level) {
    this.user_level = user_level;
  }
  public finance_plan with_user_level(String user_level) {
    this.user_level = user_level;
    return this;
  }
  private String show_content;
  public String get_show_content() {
    return show_content;
  }
  public void set_show_content(String show_content) {
    this.show_content = show_content;
  }
  public finance_plan with_show_content(String show_content) {
    this.show_content = show_content;
    return this;
  }
  private Integer use_coupon;
  public Integer get_use_coupon() {
    return use_coupon;
  }
  public void set_use_coupon(Integer use_coupon) {
    this.use_coupon = use_coupon;
  }
  public finance_plan with_use_coupon(Integer use_coupon) {
    this.use_coupon = use_coupon;
    return this;
  }
  private Integer support_stage_pack;
  public Integer get_support_stage_pack() {
    return support_stage_pack;
  }
  public void set_support_stage_pack(Integer support_stage_pack) {
    this.support_stage_pack = support_stage_pack;
  }
  public finance_plan with_support_stage_pack(Integer support_stage_pack) {
    this.support_stage_pack = support_stage_pack;
    return this;
  }
  private Integer homepage_recommend_sort_num;
  public Integer get_homepage_recommend_sort_num() {
    return homepage_recommend_sort_num;
  }
  public void set_homepage_recommend_sort_num(Integer homepage_recommend_sort_num) {
    this.homepage_recommend_sort_num = homepage_recommend_sort_num;
  }
  public finance_plan with_homepage_recommend_sort_num(Integer homepage_recommend_sort_num) {
    this.homepage_recommend_sort_num = homepage_recommend_sort_num;
    return this;
  }
  private Boolean platform_type;
  public Boolean get_platform_type() {
    return platform_type;
  }
  public void set_platform_type(Boolean platform_type) {
    this.platform_type = platform_type;
  }
  public finance_plan with_platform_type(Boolean platform_type) {
    this.platform_type = platform_type;
    return this;
  }
  private Integer version;
  public Integer get_version() {
    return version;
  }
  public void set_version(Integer version) {
    this.version = version;
  }
  public finance_plan with_version(Integer version) {
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
  public finance_plan with_create_time(java.sql.Timestamp create_time) {
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
  public finance_plan with_update_time(java.sql.Timestamp update_time) {
    this.update_time = update_time;
    return this;
  }
  private Integer collection_mode;
  public Integer get_collection_mode() {
    return collection_mode;
  }
  public void set_collection_mode(Integer collection_mode) {
    this.collection_mode = collection_mode;
  }
  public finance_plan with_collection_mode(Integer collection_mode) {
    this.collection_mode = collection_mode;
    return this;
  }
  private String borrows_range;
  public String get_borrows_range() {
    return borrows_range;
  }
  public void set_borrows_range(String borrows_range) {
    this.borrows_range = borrows_range;
  }
  public finance_plan with_borrows_range(String borrows_range) {
    this.borrows_range = borrows_range;
    return this;
  }
  private Integer recommend_scope;
  public Integer get_recommend_scope() {
    return recommend_scope;
  }
  public void set_recommend_scope(Integer recommend_scope) {
    this.recommend_scope = recommend_scope;
  }
  public finance_plan with_recommend_scope(Integer recommend_scope) {
    this.recommend_scope = recommend_scope;
    return this;
  }
  private String product_name;
  public String get_product_name() {
    return product_name;
  }
  public void set_product_name(String product_name) {
    this.product_name = product_name;
  }
  public finance_plan with_product_name(String product_name) {
    this.product_name = product_name;
    return this;
  }
  private java.math.BigDecimal product_price;
  public java.math.BigDecimal get_product_price() {
    return product_price;
  }
  public void set_product_price(java.math.BigDecimal product_price) {
    this.product_price = product_price;
  }
  public finance_plan with_product_price(java.math.BigDecimal product_price) {
    this.product_price = product_price;
    return this;
  }
  private java.math.BigDecimal product_nono_price;
  public java.math.BigDecimal get_product_nono_price() {
    return product_nono_price;
  }
  public void set_product_nono_price(java.math.BigDecimal product_nono_price) {
    this.product_nono_price = product_nono_price;
  }
  public finance_plan with_product_nono_price(java.math.BigDecimal product_nono_price) {
    this.product_nono_price = product_nono_price;
    return this;
  }
  private Boolean product_hot;
  public Boolean get_product_hot() {
    return product_hot;
  }
  public void set_product_hot(Boolean product_hot) {
    this.product_hot = product_hot;
  }
  public finance_plan with_product_hot(Boolean product_hot) {
    this.product_hot = product_hot;
    return this;
  }
  private String product_mobile_img;
  public String get_product_mobile_img() {
    return product_mobile_img;
  }
  public void set_product_mobile_img(String product_mobile_img) {
    this.product_mobile_img = product_mobile_img;
  }
  public finance_plan with_product_mobile_img(String product_mobile_img) {
    this.product_mobile_img = product_mobile_img;
    return this;
  }
  private String product_pc_img;
  public String get_product_pc_img() {
    return product_pc_img;
  }
  public void set_product_pc_img(String product_pc_img) {
    this.product_pc_img = product_pc_img;
  }
  public finance_plan with_product_pc_img(String product_pc_img) {
    this.product_pc_img = product_pc_img;
    return this;
  }
  private Integer is_auto_clone;
  public Integer get_is_auto_clone() {
    return is_auto_clone;
  }
  public void set_is_auto_clone(Integer is_auto_clone) {
    this.is_auto_clone = is_auto_clone;
  }
  public finance_plan with_is_auto_clone(Integer is_auto_clone) {
    this.is_auto_clone = is_auto_clone;
    return this;
  }
  private String product_type;
  public String get_product_type() {
    return product_type;
  }
  public void set_product_type(String product_type) {
    this.product_type = product_type;
  }
  public finance_plan with_product_type(String product_type) {
    this.product_type = product_type;
    return this;
  }
  private String rate_desc;
  public String get_rate_desc() {
    return rate_desc;
  }
  public void set_rate_desc(String rate_desc) {
    this.rate_desc = rate_desc;
  }
  public finance_plan with_rate_desc(String rate_desc) {
    this.rate_desc = rate_desc;
    return this;
  }
  private Boolean homepage_is_show;
  public Boolean get_homepage_is_show() {
    return homepage_is_show;
  }
  public void set_homepage_is_show(Boolean homepage_is_show) {
    this.homepage_is_show = homepage_is_show;
  }
  public finance_plan with_homepage_is_show(Boolean homepage_is_show) {
    this.homepage_is_show = homepage_is_show;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof finance_plan)) {
      return false;
    }
    finance_plan that = (finance_plan) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.title == null ? that.title == null : this.title.equals(that.title));
    equal = equal && (this.scope == null ? that.scope == null : this.scope.equals(that.scope));
    equal = equal && (this.price == null ? that.price == null : this.price.equals(that.price));
    equal = equal && (this.price_finish == null ? that.price_finish == null : this.price_finish.equals(that.price_finish));
    equal = equal && (this.price_adjust == null ? that.price_adjust == null : this.price_adjust.equals(that.price_adjust));
    equal = equal && (this.price_increment == null ? that.price_increment == null : this.price_increment.equals(that.price_increment));
    equal = equal && (this.price_min == null ? that.price_min == null : this.price_min.equals(that.price_min));
    equal = equal && (this.price_max == null ? that.price_max == null : this.price_max.equals(that.price_max));
    equal = equal && (this.rate_min == null ? that.rate_min == null : this.rate_min.equals(that.rate_min));
    equal = equal && (this.rate_max == null ? that.rate_max == null : this.rate_max.equals(that.rate_max));
    equal = equal && (this.stop_bidding_days == null ? that.stop_bidding_days == null : this.stop_bidding_days.equals(that.stop_bidding_days));
    equal = equal && (this.auto_bid == null ? that.auto_bid == null : this.auto_bid.equals(that.auto_bid));
    equal = equal && (this.earnings_intro == null ? that.earnings_intro == null : this.earnings_intro.equals(that.earnings_intro));
    equal = equal && (this.buy_limit == null ? that.buy_limit == null : this.buy_limit.equals(that.buy_limit));
    equal = equal && (this.redeem_normal_way == null ? that.redeem_normal_way == null : this.redeem_normal_way.equals(that.redeem_normal_way));
    equal = equal && (this.redeem_other_way == null ? that.redeem_other_way == null : this.redeem_other_way.equals(that.redeem_other_way));
    equal = equal && (this.publish_date == null ? that.publish_date == null : this.publish_date.equals(that.publish_date));
    equal = equal && (this.finish_date == null ? that.finish_date == null : this.finish_date.equals(that.finish_date));
    equal = equal && (this.slogan == null ? that.slogan == null : this.slogan.equals(that.slogan));
    equal = equal && (this.explanation == null ? that.explanation == null : this.explanation.equals(that.explanation));
    equal = equal && (this.expect == null ? that.expect == null : this.expect.equals(that.expect));
    equal = equal && (this.expect_unit == null ? that.expect_unit == null : this.expect_unit.equals(that.expect_unit));
    equal = equal && (this.start_date == null ? that.start_date == null : this.start_date.equals(that.start_date));
    equal = equal && (this.operator == null ? that.operator == null : this.operator.equals(that.operator));
    equal = equal && (this.STATUS == null ? that.STATUS == null : this.STATUS.equals(that.STATUS));
    equal = equal && (this.protect_plan == null ? that.protect_plan == null : this.protect_plan.equals(that.protect_plan));
    equal = equal && (this.transfer_enable == null ? that.transfer_enable == null : this.transfer_enable.equals(that.transfer_enable));
    equal = equal && (this.need_bankcode == null ? that.need_bankcode == null : this.need_bankcode.equals(that.need_bankcode));
    equal = equal && (this.template == null ? that.template == null : this.template.equals(that.template));
    equal = equal && (this.show_scope == null ? that.show_scope == null : this.show_scope.equals(that.show_scope));
    equal = equal && (this.suffix == null ? that.suffix == null : this.suffix.equals(that.suffix));
    equal = equal && (this.rate_show == null ? that.rate_show == null : this.rate_show.equals(that.rate_show));
    equal = equal && (this.user_level == null ? that.user_level == null : this.user_level.equals(that.user_level));
    equal = equal && (this.show_content == null ? that.show_content == null : this.show_content.equals(that.show_content));
    equal = equal && (this.use_coupon == null ? that.use_coupon == null : this.use_coupon.equals(that.use_coupon));
    equal = equal && (this.support_stage_pack == null ? that.support_stage_pack == null : this.support_stage_pack.equals(that.support_stage_pack));
    equal = equal && (this.homepage_recommend_sort_num == null ? that.homepage_recommend_sort_num == null : this.homepage_recommend_sort_num.equals(that.homepage_recommend_sort_num));
    equal = equal && (this.platform_type == null ? that.platform_type == null : this.platform_type.equals(that.platform_type));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.collection_mode == null ? that.collection_mode == null : this.collection_mode.equals(that.collection_mode));
    equal = equal && (this.borrows_range == null ? that.borrows_range == null : this.borrows_range.equals(that.borrows_range));
    equal = equal && (this.recommend_scope == null ? that.recommend_scope == null : this.recommend_scope.equals(that.recommend_scope));
    equal = equal && (this.product_name == null ? that.product_name == null : this.product_name.equals(that.product_name));
    equal = equal && (this.product_price == null ? that.product_price == null : this.product_price.equals(that.product_price));
    equal = equal && (this.product_nono_price == null ? that.product_nono_price == null : this.product_nono_price.equals(that.product_nono_price));
    equal = equal && (this.product_hot == null ? that.product_hot == null : this.product_hot.equals(that.product_hot));
    equal = equal && (this.product_mobile_img == null ? that.product_mobile_img == null : this.product_mobile_img.equals(that.product_mobile_img));
    equal = equal && (this.product_pc_img == null ? that.product_pc_img == null : this.product_pc_img.equals(that.product_pc_img));
    equal = equal && (this.is_auto_clone == null ? that.is_auto_clone == null : this.is_auto_clone.equals(that.is_auto_clone));
    equal = equal && (this.product_type == null ? that.product_type == null : this.product_type.equals(that.product_type));
    equal = equal && (this.rate_desc == null ? that.rate_desc == null : this.rate_desc.equals(that.rate_desc));
    equal = equal && (this.homepage_is_show == null ? that.homepage_is_show == null : this.homepage_is_show.equals(that.homepage_is_show));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof finance_plan)) {
      return false;
    }
    finance_plan that = (finance_plan) o;
    boolean equal = true;
    equal = equal && (this.id == null ? that.id == null : this.id.equals(that.id));
    equal = equal && (this.title == null ? that.title == null : this.title.equals(that.title));
    equal = equal && (this.scope == null ? that.scope == null : this.scope.equals(that.scope));
    equal = equal && (this.price == null ? that.price == null : this.price.equals(that.price));
    equal = equal && (this.price_finish == null ? that.price_finish == null : this.price_finish.equals(that.price_finish));
    equal = equal && (this.price_adjust == null ? that.price_adjust == null : this.price_adjust.equals(that.price_adjust));
    equal = equal && (this.price_increment == null ? that.price_increment == null : this.price_increment.equals(that.price_increment));
    equal = equal && (this.price_min == null ? that.price_min == null : this.price_min.equals(that.price_min));
    equal = equal && (this.price_max == null ? that.price_max == null : this.price_max.equals(that.price_max));
    equal = equal && (this.rate_min == null ? that.rate_min == null : this.rate_min.equals(that.rate_min));
    equal = equal && (this.rate_max == null ? that.rate_max == null : this.rate_max.equals(that.rate_max));
    equal = equal && (this.stop_bidding_days == null ? that.stop_bidding_days == null : this.stop_bidding_days.equals(that.stop_bidding_days));
    equal = equal && (this.auto_bid == null ? that.auto_bid == null : this.auto_bid.equals(that.auto_bid));
    equal = equal && (this.earnings_intro == null ? that.earnings_intro == null : this.earnings_intro.equals(that.earnings_intro));
    equal = equal && (this.buy_limit == null ? that.buy_limit == null : this.buy_limit.equals(that.buy_limit));
    equal = equal && (this.redeem_normal_way == null ? that.redeem_normal_way == null : this.redeem_normal_way.equals(that.redeem_normal_way));
    equal = equal && (this.redeem_other_way == null ? that.redeem_other_way == null : this.redeem_other_way.equals(that.redeem_other_way));
    equal = equal && (this.publish_date == null ? that.publish_date == null : this.publish_date.equals(that.publish_date));
    equal = equal && (this.finish_date == null ? that.finish_date == null : this.finish_date.equals(that.finish_date));
    equal = equal && (this.slogan == null ? that.slogan == null : this.slogan.equals(that.slogan));
    equal = equal && (this.explanation == null ? that.explanation == null : this.explanation.equals(that.explanation));
    equal = equal && (this.expect == null ? that.expect == null : this.expect.equals(that.expect));
    equal = equal && (this.expect_unit == null ? that.expect_unit == null : this.expect_unit.equals(that.expect_unit));
    equal = equal && (this.start_date == null ? that.start_date == null : this.start_date.equals(that.start_date));
    equal = equal && (this.operator == null ? that.operator == null : this.operator.equals(that.operator));
    equal = equal && (this.STATUS == null ? that.STATUS == null : this.STATUS.equals(that.STATUS));
    equal = equal && (this.protect_plan == null ? that.protect_plan == null : this.protect_plan.equals(that.protect_plan));
    equal = equal && (this.transfer_enable == null ? that.transfer_enable == null : this.transfer_enable.equals(that.transfer_enable));
    equal = equal && (this.need_bankcode == null ? that.need_bankcode == null : this.need_bankcode.equals(that.need_bankcode));
    equal = equal && (this.template == null ? that.template == null : this.template.equals(that.template));
    equal = equal && (this.show_scope == null ? that.show_scope == null : this.show_scope.equals(that.show_scope));
    equal = equal && (this.suffix == null ? that.suffix == null : this.suffix.equals(that.suffix));
    equal = equal && (this.rate_show == null ? that.rate_show == null : this.rate_show.equals(that.rate_show));
    equal = equal && (this.user_level == null ? that.user_level == null : this.user_level.equals(that.user_level));
    equal = equal && (this.show_content == null ? that.show_content == null : this.show_content.equals(that.show_content));
    equal = equal && (this.use_coupon == null ? that.use_coupon == null : this.use_coupon.equals(that.use_coupon));
    equal = equal && (this.support_stage_pack == null ? that.support_stage_pack == null : this.support_stage_pack.equals(that.support_stage_pack));
    equal = equal && (this.homepage_recommend_sort_num == null ? that.homepage_recommend_sort_num == null : this.homepage_recommend_sort_num.equals(that.homepage_recommend_sort_num));
    equal = equal && (this.platform_type == null ? that.platform_type == null : this.platform_type.equals(that.platform_type));
    equal = equal && (this.version == null ? that.version == null : this.version.equals(that.version));
    equal = equal && (this.create_time == null ? that.create_time == null : this.create_time.equals(that.create_time));
    equal = equal && (this.update_time == null ? that.update_time == null : this.update_time.equals(that.update_time));
    equal = equal && (this.collection_mode == null ? that.collection_mode == null : this.collection_mode.equals(that.collection_mode));
    equal = equal && (this.borrows_range == null ? that.borrows_range == null : this.borrows_range.equals(that.borrows_range));
    equal = equal && (this.recommend_scope == null ? that.recommend_scope == null : this.recommend_scope.equals(that.recommend_scope));
    equal = equal && (this.product_name == null ? that.product_name == null : this.product_name.equals(that.product_name));
    equal = equal && (this.product_price == null ? that.product_price == null : this.product_price.equals(that.product_price));
    equal = equal && (this.product_nono_price == null ? that.product_nono_price == null : this.product_nono_price.equals(that.product_nono_price));
    equal = equal && (this.product_hot == null ? that.product_hot == null : this.product_hot.equals(that.product_hot));
    equal = equal && (this.product_mobile_img == null ? that.product_mobile_img == null : this.product_mobile_img.equals(that.product_mobile_img));
    equal = equal && (this.product_pc_img == null ? that.product_pc_img == null : this.product_pc_img.equals(that.product_pc_img));
    equal = equal && (this.is_auto_clone == null ? that.is_auto_clone == null : this.is_auto_clone.equals(that.is_auto_clone));
    equal = equal && (this.product_type == null ? that.product_type == null : this.product_type.equals(that.product_type));
    equal = equal && (this.rate_desc == null ? that.rate_desc == null : this.rate_desc.equals(that.rate_desc));
    equal = equal && (this.homepage_is_show == null ? that.homepage_is_show == null : this.homepage_is_show.equals(that.homepage_is_show));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.title = JdbcWritableBridge.readString(2, __dbResults);
    this.scope = JdbcWritableBridge.readInteger(3, __dbResults);
    this.price = JdbcWritableBridge.readBigDecimal(4, __dbResults);
    this.price_finish = JdbcWritableBridge.readBigDecimal(5, __dbResults);
    this.price_adjust = JdbcWritableBridge.readBigDecimal(6, __dbResults);
    this.price_increment = JdbcWritableBridge.readBigDecimal(7, __dbResults);
    this.price_min = JdbcWritableBridge.readBigDecimal(8, __dbResults);
    this.price_max = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.rate_min = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.rate_max = JdbcWritableBridge.readBigDecimal(11, __dbResults);
    this.stop_bidding_days = JdbcWritableBridge.readInteger(12, __dbResults);
    this.auto_bid = JdbcWritableBridge.readBoolean(13, __dbResults);
    this.earnings_intro = JdbcWritableBridge.readString(14, __dbResults);
    this.buy_limit = JdbcWritableBridge.readString(15, __dbResults);
    this.redeem_normal_way = JdbcWritableBridge.readString(16, __dbResults);
    this.redeem_other_way = JdbcWritableBridge.readString(17, __dbResults);
    this.publish_date = JdbcWritableBridge.readTimestamp(18, __dbResults);
    this.finish_date = JdbcWritableBridge.readDate(19, __dbResults);
    this.slogan = JdbcWritableBridge.readString(20, __dbResults);
    this.explanation = JdbcWritableBridge.readString(21, __dbResults);
    this.expect = JdbcWritableBridge.readInteger(22, __dbResults);
    this.expect_unit = JdbcWritableBridge.readInteger(23, __dbResults);
    this.start_date = JdbcWritableBridge.readDate(24, __dbResults);
    this.operator = JdbcWritableBridge.readLong(25, __dbResults);
    this.STATUS = JdbcWritableBridge.readInteger(26, __dbResults);
    this.protect_plan = JdbcWritableBridge.readString(27, __dbResults);
    this.transfer_enable = JdbcWritableBridge.readBoolean(28, __dbResults);
    this.need_bankcode = JdbcWritableBridge.readInteger(29, __dbResults);
    this.template = JdbcWritableBridge.readString(30, __dbResults);
    this.show_scope = JdbcWritableBridge.readInteger(31, __dbResults);
    this.suffix = JdbcWritableBridge.readString(32, __dbResults);
    this.rate_show = JdbcWritableBridge.readString(33, __dbResults);
    this.user_level = JdbcWritableBridge.readString(34, __dbResults);
    this.show_content = JdbcWritableBridge.readString(35, __dbResults);
    this.use_coupon = JdbcWritableBridge.readInteger(36, __dbResults);
    this.support_stage_pack = JdbcWritableBridge.readInteger(37, __dbResults);
    this.homepage_recommend_sort_num = JdbcWritableBridge.readInteger(38, __dbResults);
    this.platform_type = JdbcWritableBridge.readBoolean(39, __dbResults);
    this.version = JdbcWritableBridge.readInteger(40, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(41, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(42, __dbResults);
    this.collection_mode = JdbcWritableBridge.readInteger(43, __dbResults);
    this.borrows_range = JdbcWritableBridge.readString(44, __dbResults);
    this.recommend_scope = JdbcWritableBridge.readInteger(45, __dbResults);
    this.product_name = JdbcWritableBridge.readString(46, __dbResults);
    this.product_price = JdbcWritableBridge.readBigDecimal(47, __dbResults);
    this.product_nono_price = JdbcWritableBridge.readBigDecimal(48, __dbResults);
    this.product_hot = JdbcWritableBridge.readBoolean(49, __dbResults);
    this.product_mobile_img = JdbcWritableBridge.readString(50, __dbResults);
    this.product_pc_img = JdbcWritableBridge.readString(51, __dbResults);
    this.is_auto_clone = JdbcWritableBridge.readInteger(52, __dbResults);
    this.product_type = JdbcWritableBridge.readString(53, __dbResults);
    this.rate_desc = JdbcWritableBridge.readString(54, __dbResults);
    this.homepage_is_show = JdbcWritableBridge.readBoolean(55, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.id = JdbcWritableBridge.readLong(1, __dbResults);
    this.title = JdbcWritableBridge.readString(2, __dbResults);
    this.scope = JdbcWritableBridge.readInteger(3, __dbResults);
    this.price = JdbcWritableBridge.readBigDecimal(4, __dbResults);
    this.price_finish = JdbcWritableBridge.readBigDecimal(5, __dbResults);
    this.price_adjust = JdbcWritableBridge.readBigDecimal(6, __dbResults);
    this.price_increment = JdbcWritableBridge.readBigDecimal(7, __dbResults);
    this.price_min = JdbcWritableBridge.readBigDecimal(8, __dbResults);
    this.price_max = JdbcWritableBridge.readBigDecimal(9, __dbResults);
    this.rate_min = JdbcWritableBridge.readBigDecimal(10, __dbResults);
    this.rate_max = JdbcWritableBridge.readBigDecimal(11, __dbResults);
    this.stop_bidding_days = JdbcWritableBridge.readInteger(12, __dbResults);
    this.auto_bid = JdbcWritableBridge.readBoolean(13, __dbResults);
    this.earnings_intro = JdbcWritableBridge.readString(14, __dbResults);
    this.buy_limit = JdbcWritableBridge.readString(15, __dbResults);
    this.redeem_normal_way = JdbcWritableBridge.readString(16, __dbResults);
    this.redeem_other_way = JdbcWritableBridge.readString(17, __dbResults);
    this.publish_date = JdbcWritableBridge.readTimestamp(18, __dbResults);
    this.finish_date = JdbcWritableBridge.readDate(19, __dbResults);
    this.slogan = JdbcWritableBridge.readString(20, __dbResults);
    this.explanation = JdbcWritableBridge.readString(21, __dbResults);
    this.expect = JdbcWritableBridge.readInteger(22, __dbResults);
    this.expect_unit = JdbcWritableBridge.readInteger(23, __dbResults);
    this.start_date = JdbcWritableBridge.readDate(24, __dbResults);
    this.operator = JdbcWritableBridge.readLong(25, __dbResults);
    this.STATUS = JdbcWritableBridge.readInteger(26, __dbResults);
    this.protect_plan = JdbcWritableBridge.readString(27, __dbResults);
    this.transfer_enable = JdbcWritableBridge.readBoolean(28, __dbResults);
    this.need_bankcode = JdbcWritableBridge.readInteger(29, __dbResults);
    this.template = JdbcWritableBridge.readString(30, __dbResults);
    this.show_scope = JdbcWritableBridge.readInteger(31, __dbResults);
    this.suffix = JdbcWritableBridge.readString(32, __dbResults);
    this.rate_show = JdbcWritableBridge.readString(33, __dbResults);
    this.user_level = JdbcWritableBridge.readString(34, __dbResults);
    this.show_content = JdbcWritableBridge.readString(35, __dbResults);
    this.use_coupon = JdbcWritableBridge.readInteger(36, __dbResults);
    this.support_stage_pack = JdbcWritableBridge.readInteger(37, __dbResults);
    this.homepage_recommend_sort_num = JdbcWritableBridge.readInteger(38, __dbResults);
    this.platform_type = JdbcWritableBridge.readBoolean(39, __dbResults);
    this.version = JdbcWritableBridge.readInteger(40, __dbResults);
    this.create_time = JdbcWritableBridge.readTimestamp(41, __dbResults);
    this.update_time = JdbcWritableBridge.readTimestamp(42, __dbResults);
    this.collection_mode = JdbcWritableBridge.readInteger(43, __dbResults);
    this.borrows_range = JdbcWritableBridge.readString(44, __dbResults);
    this.recommend_scope = JdbcWritableBridge.readInteger(45, __dbResults);
    this.product_name = JdbcWritableBridge.readString(46, __dbResults);
    this.product_price = JdbcWritableBridge.readBigDecimal(47, __dbResults);
    this.product_nono_price = JdbcWritableBridge.readBigDecimal(48, __dbResults);
    this.product_hot = JdbcWritableBridge.readBoolean(49, __dbResults);
    this.product_mobile_img = JdbcWritableBridge.readString(50, __dbResults);
    this.product_pc_img = JdbcWritableBridge.readString(51, __dbResults);
    this.is_auto_clone = JdbcWritableBridge.readInteger(52, __dbResults);
    this.product_type = JdbcWritableBridge.readString(53, __dbResults);
    this.rate_desc = JdbcWritableBridge.readString(54, __dbResults);
    this.homepage_is_show = JdbcWritableBridge.readBoolean(55, __dbResults);
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
    JdbcWritableBridge.writeString(title, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(scope, 3 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price, 4 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_finish, 5 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_adjust, 6 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_increment, 7 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_min, 8 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_max, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(rate_min, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(rate_max, 11 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(stop_bidding_days, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBoolean(auto_bid, 13 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeString(earnings_intro, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(buy_limit, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(redeem_normal_way, 16 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(redeem_other_way, 17 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(publish_date, 18 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeDate(finish_date, 19 + __off, 91, __dbStmt);
    JdbcWritableBridge.writeString(slogan, 20 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(explanation, 21 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeInteger(expect, 22 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(expect_unit, 23 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeDate(start_date, 24 + __off, 91, __dbStmt);
    JdbcWritableBridge.writeLong(operator, 25 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(STATUS, 26 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(protect_plan, 27 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeBoolean(transfer_enable, 28 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeInteger(need_bankcode, 29 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(template, 30 + __off, 1, __dbStmt);
    JdbcWritableBridge.writeInteger(show_scope, 31 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(suffix, 32 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(rate_show, 33 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(user_level, 34 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(show_content, 35 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(use_coupon, 36 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(support_stage_pack, 37 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeInteger(homepage_recommend_sort_num, 38 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeBoolean(platform_type, 39 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 40 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 41 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 42 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(collection_mode, 43 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(borrows_range, 44 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(recommend_scope, 45 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(product_name, 46 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(product_price, 47 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(product_nono_price, 48 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBoolean(product_hot, 49 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeString(product_mobile_img, 50 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(product_pc_img, 51 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(is_auto_clone, 52 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(product_type, 53 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(rate_desc, 54 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBoolean(homepage_is_show, 55 + __off, -7, __dbStmt);
    return 55;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeLong(id, 1 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeString(title, 2 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(scope, 3 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price, 4 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_finish, 5 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_adjust, 6 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_increment, 7 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_min, 8 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(price_max, 9 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(rate_min, 10 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(rate_max, 11 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeInteger(stop_bidding_days, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBoolean(auto_bid, 13 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeString(earnings_intro, 14 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(buy_limit, 15 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(redeem_normal_way, 16 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(redeem_other_way, 17 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeTimestamp(publish_date, 18 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeDate(finish_date, 19 + __off, 91, __dbStmt);
    JdbcWritableBridge.writeString(slogan, 20 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(explanation, 21 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeInteger(expect, 22 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(expect_unit, 23 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeDate(start_date, 24 + __off, 91, __dbStmt);
    JdbcWritableBridge.writeLong(operator, 25 + __off, -5, __dbStmt);
    JdbcWritableBridge.writeInteger(STATUS, 26 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(protect_plan, 27 + __off, -1, __dbStmt);
    JdbcWritableBridge.writeBoolean(transfer_enable, 28 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeInteger(need_bankcode, 29 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(template, 30 + __off, 1, __dbStmt);
    JdbcWritableBridge.writeInteger(show_scope, 31 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(suffix, 32 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(rate_show, 33 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(user_level, 34 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(show_content, 35 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(use_coupon, 36 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(support_stage_pack, 37 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeInteger(homepage_recommend_sort_num, 38 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeBoolean(platform_type, 39 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeInteger(version, 40 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeTimestamp(create_time, 41 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeTimestamp(update_time, 42 + __off, 93, __dbStmt);
    JdbcWritableBridge.writeInteger(collection_mode, 43 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeString(borrows_range, 44 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(recommend_scope, 45 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(product_name, 46 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(product_price, 47 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(product_nono_price, 48 + __off, 3, __dbStmt);
    JdbcWritableBridge.writeBoolean(product_hot, 49 + __off, -7, __dbStmt);
    JdbcWritableBridge.writeString(product_mobile_img, 50 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(product_pc_img, 51 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(is_auto_clone, 52 + __off, -6, __dbStmt);
    JdbcWritableBridge.writeString(product_type, 53 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeString(rate_desc, 54 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeBoolean(homepage_is_show, 55 + __off, -7, __dbStmt);
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
        this.title = null;
    } else {
    this.title = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.scope = null;
    } else {
    this.scope = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.price = null;
    } else {
    this.price = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price_finish = null;
    } else {
    this.price_finish = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price_adjust = null;
    } else {
    this.price_adjust = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price_increment = null;
    } else {
    this.price_increment = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price_min = null;
    } else {
    this.price_min = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.price_max = null;
    } else {
    this.price_max = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.rate_min = null;
    } else {
    this.rate_min = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.rate_max = null;
    } else {
    this.rate_max = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.stop_bidding_days = null;
    } else {
    this.stop_bidding_days = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.auto_bid = null;
    } else {
    this.auto_bid = Boolean.valueOf(__dataIn.readBoolean());
    }
    if (__dataIn.readBoolean()) { 
        this.earnings_intro = null;
    } else {
    this.earnings_intro = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.buy_limit = null;
    } else {
    this.buy_limit = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.redeem_normal_way = null;
    } else {
    this.redeem_normal_way = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.redeem_other_way = null;
    } else {
    this.redeem_other_way = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.publish_date = null;
    } else {
    this.publish_date = new Timestamp(__dataIn.readLong());
    this.publish_date.setNanos(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.finish_date = null;
    } else {
    this.finish_date = new Date(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.slogan = null;
    } else {
    this.slogan = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.explanation = null;
    } else {
    this.explanation = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.expect = null;
    } else {
    this.expect = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.expect_unit = null;
    } else {
    this.expect_unit = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.start_date = null;
    } else {
    this.start_date = new Date(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.operator = null;
    } else {
    this.operator = Long.valueOf(__dataIn.readLong());
    }
    if (__dataIn.readBoolean()) { 
        this.STATUS = null;
    } else {
    this.STATUS = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.protect_plan = null;
    } else {
    this.protect_plan = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.transfer_enable = null;
    } else {
    this.transfer_enable = Boolean.valueOf(__dataIn.readBoolean());
    }
    if (__dataIn.readBoolean()) { 
        this.need_bankcode = null;
    } else {
    this.need_bankcode = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.template = null;
    } else {
    this.template = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.show_scope = null;
    } else {
    this.show_scope = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.suffix = null;
    } else {
    this.suffix = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.rate_show = null;
    } else {
    this.rate_show = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.user_level = null;
    } else {
    this.user_level = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.show_content = null;
    } else {
    this.show_content = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.use_coupon = null;
    } else {
    this.use_coupon = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.support_stage_pack = null;
    } else {
    this.support_stage_pack = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.homepage_recommend_sort_num = null;
    } else {
    this.homepage_recommend_sort_num = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.platform_type = null;
    } else {
    this.platform_type = Boolean.valueOf(__dataIn.readBoolean());
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
    if (__dataIn.readBoolean()) { 
        this.collection_mode = null;
    } else {
    this.collection_mode = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.borrows_range = null;
    } else {
    this.borrows_range = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.recommend_scope = null;
    } else {
    this.recommend_scope = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.product_name = null;
    } else {
    this.product_name = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.product_price = null;
    } else {
    this.product_price = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.product_nono_price = null;
    } else {
    this.product_nono_price = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.product_hot = null;
    } else {
    this.product_hot = Boolean.valueOf(__dataIn.readBoolean());
    }
    if (__dataIn.readBoolean()) { 
        this.product_mobile_img = null;
    } else {
    this.product_mobile_img = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.product_pc_img = null;
    } else {
    this.product_pc_img = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.is_auto_clone = null;
    } else {
    this.is_auto_clone = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.product_type = null;
    } else {
    this.product_type = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.rate_desc = null;
    } else {
    this.rate_desc = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.homepage_is_show = null;
    } else {
    this.homepage_is_show = Boolean.valueOf(__dataIn.readBoolean());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.id);
    }
    if (null == this.title) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, title);
    }
    if (null == this.scope) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.scope);
    }
    if (null == this.price) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price, __dataOut);
    }
    if (null == this.price_finish) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_finish, __dataOut);
    }
    if (null == this.price_adjust) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_adjust, __dataOut);
    }
    if (null == this.price_increment) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_increment, __dataOut);
    }
    if (null == this.price_min) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_min, __dataOut);
    }
    if (null == this.price_max) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_max, __dataOut);
    }
    if (null == this.rate_min) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.rate_min, __dataOut);
    }
    if (null == this.rate_max) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.rate_max, __dataOut);
    }
    if (null == this.stop_bidding_days) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.stop_bidding_days);
    }
    if (null == this.auto_bid) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.auto_bid);
    }
    if (null == this.earnings_intro) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, earnings_intro);
    }
    if (null == this.buy_limit) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, buy_limit);
    }
    if (null == this.redeem_normal_way) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, redeem_normal_way);
    }
    if (null == this.redeem_other_way) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, redeem_other_way);
    }
    if (null == this.publish_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.publish_date.getTime());
    __dataOut.writeInt(this.publish_date.getNanos());
    }
    if (null == this.finish_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.finish_date.getTime());
    }
    if (null == this.slogan) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, slogan);
    }
    if (null == this.explanation) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, explanation);
    }
    if (null == this.expect) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.expect);
    }
    if (null == this.expect_unit) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.expect_unit);
    }
    if (null == this.start_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.start_date.getTime());
    }
    if (null == this.operator) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.operator);
    }
    if (null == this.STATUS) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.STATUS);
    }
    if (null == this.protect_plan) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, protect_plan);
    }
    if (null == this.transfer_enable) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.transfer_enable);
    }
    if (null == this.need_bankcode) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.need_bankcode);
    }
    if (null == this.template) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, template);
    }
    if (null == this.show_scope) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.show_scope);
    }
    if (null == this.suffix) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, suffix);
    }
    if (null == this.rate_show) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, rate_show);
    }
    if (null == this.user_level) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, user_level);
    }
    if (null == this.show_content) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, show_content);
    }
    if (null == this.use_coupon) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.use_coupon);
    }
    if (null == this.support_stage_pack) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.support_stage_pack);
    }
    if (null == this.homepage_recommend_sort_num) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.homepage_recommend_sort_num);
    }
    if (null == this.platform_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.platform_type);
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
    if (null == this.collection_mode) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.collection_mode);
    }
    if (null == this.borrows_range) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, borrows_range);
    }
    if (null == this.recommend_scope) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.recommend_scope);
    }
    if (null == this.product_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product_name);
    }
    if (null == this.product_price) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.product_price, __dataOut);
    }
    if (null == this.product_nono_price) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.product_nono_price, __dataOut);
    }
    if (null == this.product_hot) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.product_hot);
    }
    if (null == this.product_mobile_img) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product_mobile_img);
    }
    if (null == this.product_pc_img) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product_pc_img);
    }
    if (null == this.is_auto_clone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_auto_clone);
    }
    if (null == this.product_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product_type);
    }
    if (null == this.rate_desc) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, rate_desc);
    }
    if (null == this.homepage_is_show) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.homepage_is_show);
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.id) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.id);
    }
    if (null == this.title) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, title);
    }
    if (null == this.scope) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.scope);
    }
    if (null == this.price) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price, __dataOut);
    }
    if (null == this.price_finish) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_finish, __dataOut);
    }
    if (null == this.price_adjust) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_adjust, __dataOut);
    }
    if (null == this.price_increment) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_increment, __dataOut);
    }
    if (null == this.price_min) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_min, __dataOut);
    }
    if (null == this.price_max) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.price_max, __dataOut);
    }
    if (null == this.rate_min) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.rate_min, __dataOut);
    }
    if (null == this.rate_max) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.rate_max, __dataOut);
    }
    if (null == this.stop_bidding_days) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.stop_bidding_days);
    }
    if (null == this.auto_bid) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.auto_bid);
    }
    if (null == this.earnings_intro) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, earnings_intro);
    }
    if (null == this.buy_limit) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, buy_limit);
    }
    if (null == this.redeem_normal_way) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, redeem_normal_way);
    }
    if (null == this.redeem_other_way) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, redeem_other_way);
    }
    if (null == this.publish_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.publish_date.getTime());
    __dataOut.writeInt(this.publish_date.getNanos());
    }
    if (null == this.finish_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.finish_date.getTime());
    }
    if (null == this.slogan) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, slogan);
    }
    if (null == this.explanation) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, explanation);
    }
    if (null == this.expect) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.expect);
    }
    if (null == this.expect_unit) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.expect_unit);
    }
    if (null == this.start_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.start_date.getTime());
    }
    if (null == this.operator) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.operator);
    }
    if (null == this.STATUS) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.STATUS);
    }
    if (null == this.protect_plan) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, protect_plan);
    }
    if (null == this.transfer_enable) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.transfer_enable);
    }
    if (null == this.need_bankcode) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.need_bankcode);
    }
    if (null == this.template) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, template);
    }
    if (null == this.show_scope) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.show_scope);
    }
    if (null == this.suffix) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, suffix);
    }
    if (null == this.rate_show) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, rate_show);
    }
    if (null == this.user_level) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, user_level);
    }
    if (null == this.show_content) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, show_content);
    }
    if (null == this.use_coupon) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.use_coupon);
    }
    if (null == this.support_stage_pack) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.support_stage_pack);
    }
    if (null == this.homepage_recommend_sort_num) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.homepage_recommend_sort_num);
    }
    if (null == this.platform_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.platform_type);
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
    if (null == this.collection_mode) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.collection_mode);
    }
    if (null == this.borrows_range) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, borrows_range);
    }
    if (null == this.recommend_scope) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.recommend_scope);
    }
    if (null == this.product_name) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product_name);
    }
    if (null == this.product_price) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.product_price, __dataOut);
    }
    if (null == this.product_nono_price) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.product_nono_price, __dataOut);
    }
    if (null == this.product_hot) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.product_hot);
    }
    if (null == this.product_mobile_img) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product_mobile_img);
    }
    if (null == this.product_pc_img) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product_pc_img);
    }
    if (null == this.is_auto_clone) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.is_auto_clone);
    }
    if (null == this.product_type) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, product_type);
    }
    if (null == this.rate_desc) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, rate_desc);
    }
    if (null == this.homepage_is_show) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeBoolean(this.homepage_is_show);
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
    __sb.append(FieldFormatter.hiveStringDropDelims(title==null?"\\N":title, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(scope==null?"\\N":"" + scope, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price==null?"\\N":price.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_finish==null?"\\N":price_finish.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_adjust==null?"\\N":price_adjust.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_increment==null?"\\N":price_increment.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_min==null?"\\N":price_min.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_max==null?"\\N":price_max.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(rate_min==null?"\\N":rate_min.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(rate_max==null?"\\N":rate_max.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(stop_bidding_days==null?"\\N":"" + stop_bidding_days, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(auto_bid==null?"\\N":"" + auto_bid, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(earnings_intro==null?"\\N":earnings_intro, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(buy_limit==null?"\\N":buy_limit, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(redeem_normal_way==null?"\\N":redeem_normal_way, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(redeem_other_way==null?"\\N":redeem_other_way, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(publish_date==null?"\\N":"" + publish_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(finish_date==null?"\\N":"" + finish_date, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(slogan==null?"\\N":slogan, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(explanation==null?"\\N":explanation, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(expect==null?"\\N":"" + expect, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(expect_unit==null?"\\N":"" + expect_unit, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(start_date==null?"\\N":"" + start_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(operator==null?"\\N":"" + operator, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(STATUS==null?"\\N":"" + STATUS, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(protect_plan==null?"\\N":protect_plan, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(transfer_enable==null?"\\N":"" + transfer_enable, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(need_bankcode==null?"\\N":"" + need_bankcode, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(template==null?"\\N":template, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(show_scope==null?"\\N":"" + show_scope, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(suffix==null?"\\N":suffix, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(rate_show==null?"\\N":rate_show, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(user_level==null?"\\N":user_level, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(show_content==null?"\\N":show_content, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(use_coupon==null?"\\N":"" + use_coupon, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(support_stage_pack==null?"\\N":"" + support_stage_pack, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(homepage_recommend_sort_num==null?"\\N":"" + homepage_recommend_sort_num, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(platform_type==null?"\\N":"" + platform_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"\\N":"" + version, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"\\N":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"\\N":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(collection_mode==null?"\\N":"" + collection_mode, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(borrows_range==null?"\\N":borrows_range, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(recommend_scope==null?"\\N":"" + recommend_scope, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(product_name==null?"\\N":product_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(product_price==null?"\\N":product_price.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(product_nono_price==null?"\\N":product_nono_price.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(product_hot==null?"\\N":"" + product_hot, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(product_mobile_img==null?"\\N":product_mobile_img, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(product_pc_img==null?"\\N":product_pc_img, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_auto_clone==null?"\\N":"" + is_auto_clone, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(product_type==null?"\\N":product_type, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(rate_desc==null?"\\N":rate_desc, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(homepage_is_show==null?"\\N":"" + homepage_is_show, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(id==null?"\\N":"" + id, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(title==null?"\\N":title, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(scope==null?"\\N":"" + scope, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price==null?"\\N":price.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_finish==null?"\\N":price_finish.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_adjust==null?"\\N":price_adjust.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_increment==null?"\\N":price_increment.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_min==null?"\\N":price_min.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(price_max==null?"\\N":price_max.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(rate_min==null?"\\N":rate_min.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(rate_max==null?"\\N":rate_max.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(stop_bidding_days==null?"\\N":"" + stop_bidding_days, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(auto_bid==null?"\\N":"" + auto_bid, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(earnings_intro==null?"\\N":earnings_intro, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(buy_limit==null?"\\N":buy_limit, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(redeem_normal_way==null?"\\N":redeem_normal_way, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(redeem_other_way==null?"\\N":redeem_other_way, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(publish_date==null?"\\N":"" + publish_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(finish_date==null?"\\N":"" + finish_date, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(slogan==null?"\\N":slogan, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(explanation==null?"\\N":explanation, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(expect==null?"\\N":"" + expect, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(expect_unit==null?"\\N":"" + expect_unit, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(start_date==null?"\\N":"" + start_date, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(operator==null?"\\N":"" + operator, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(STATUS==null?"\\N":"" + STATUS, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(protect_plan==null?"\\N":protect_plan, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(transfer_enable==null?"\\N":"" + transfer_enable, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(need_bankcode==null?"\\N":"" + need_bankcode, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(template==null?"\\N":template, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(show_scope==null?"\\N":"" + show_scope, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(suffix==null?"\\N":suffix, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(rate_show==null?"\\N":rate_show, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(user_level==null?"\\N":user_level, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(show_content==null?"\\N":show_content, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(use_coupon==null?"\\N":"" + use_coupon, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(support_stage_pack==null?"\\N":"" + support_stage_pack, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(homepage_recommend_sort_num==null?"\\N":"" + homepage_recommend_sort_num, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(platform_type==null?"\\N":"" + platform_type, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(version==null?"\\N":"" + version, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(create_time==null?"\\N":"" + create_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(update_time==null?"\\N":"" + update_time, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(collection_mode==null?"\\N":"" + collection_mode, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(borrows_range==null?"\\N":borrows_range, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(recommend_scope==null?"\\N":"" + recommend_scope, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(product_name==null?"\\N":product_name, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(product_price==null?"\\N":product_price.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(product_nono_price==null?"\\N":product_nono_price.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(product_hot==null?"\\N":"" + product_hot, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(product_mobile_img==null?"\\N":product_mobile_img, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(product_pc_img==null?"\\N":product_pc_img, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(is_auto_clone==null?"\\N":"" + is_auto_clone, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(product_type==null?"\\N":product_type, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(rate_desc==null?"\\N":rate_desc, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(homepage_is_show==null?"\\N":"" + homepage_is_show, delimiters));
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
    if (__cur_str.equals("null")) { this.title = null; } else {
      this.title = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.scope = null; } else {
      this.scope = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price = null; } else {
      this.price = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_finish = null; } else {
      this.price_finish = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_adjust = null; } else {
      this.price_adjust = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_increment = null; } else {
      this.price_increment = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_min = null; } else {
      this.price_min = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_max = null; } else {
      this.price_max = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.rate_min = null; } else {
      this.rate_min = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.rate_max = null; } else {
      this.rate_max = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.stop_bidding_days = null; } else {
      this.stop_bidding_days = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.auto_bid = null; } else {
      this.auto_bid = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.earnings_intro = null; } else {
      this.earnings_intro = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.buy_limit = null; } else {
      this.buy_limit = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.redeem_normal_way = null; } else {
      this.redeem_normal_way = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.redeem_other_way = null; } else {
      this.redeem_other_way = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.publish_date = null; } else {
      this.publish_date = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.finish_date = null; } else {
      this.finish_date = java.sql.Date.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.slogan = null; } else {
      this.slogan = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.explanation = null; } else {
      this.explanation = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.expect = null; } else {
      this.expect = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.expect_unit = null; } else {
      this.expect_unit = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.start_date = null; } else {
      this.start_date = java.sql.Date.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.operator = null; } else {
      this.operator = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.STATUS = null; } else {
      this.STATUS = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.protect_plan = null; } else {
      this.protect_plan = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.transfer_enable = null; } else {
      this.transfer_enable = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.need_bankcode = null; } else {
      this.need_bankcode = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.template = null; } else {
      this.template = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.show_scope = null; } else {
      this.show_scope = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.suffix = null; } else {
      this.suffix = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.rate_show = null; } else {
      this.rate_show = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.user_level = null; } else {
      this.user_level = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.show_content = null; } else {
      this.show_content = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.use_coupon = null; } else {
      this.use_coupon = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.support_stage_pack = null; } else {
      this.support_stage_pack = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.homepage_recommend_sort_num = null; } else {
      this.homepage_recommend_sort_num = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.platform_type = null; } else {
      this.platform_type = BooleanParser.valueOf(__cur_str);
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

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.collection_mode = null; } else {
      this.collection_mode = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.borrows_range = null; } else {
      this.borrows_range = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.recommend_scope = null; } else {
      this.recommend_scope = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.product_name = null; } else {
      this.product_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.product_price = null; } else {
      this.product_price = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.product_nono_price = null; } else {
      this.product_nono_price = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.product_hot = null; } else {
      this.product_hot = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.product_mobile_img = null; } else {
      this.product_mobile_img = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.product_pc_img = null; } else {
      this.product_pc_img = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_auto_clone = null; } else {
      this.is_auto_clone = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.product_type = null; } else {
      this.product_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.rate_desc = null; } else {
      this.rate_desc = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.homepage_is_show = null; } else {
      this.homepage_is_show = BooleanParser.valueOf(__cur_str);
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
    if (__cur_str.equals("null")) { this.title = null; } else {
      this.title = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.scope = null; } else {
      this.scope = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price = null; } else {
      this.price = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_finish = null; } else {
      this.price_finish = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_adjust = null; } else {
      this.price_adjust = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_increment = null; } else {
      this.price_increment = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_min = null; } else {
      this.price_min = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.price_max = null; } else {
      this.price_max = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.rate_min = null; } else {
      this.rate_min = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.rate_max = null; } else {
      this.rate_max = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.stop_bidding_days = null; } else {
      this.stop_bidding_days = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.auto_bid = null; } else {
      this.auto_bid = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.earnings_intro = null; } else {
      this.earnings_intro = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.buy_limit = null; } else {
      this.buy_limit = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.redeem_normal_way = null; } else {
      this.redeem_normal_way = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.redeem_other_way = null; } else {
      this.redeem_other_way = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.publish_date = null; } else {
      this.publish_date = java.sql.Timestamp.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.finish_date = null; } else {
      this.finish_date = java.sql.Date.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.slogan = null; } else {
      this.slogan = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.explanation = null; } else {
      this.explanation = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.expect = null; } else {
      this.expect = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.expect_unit = null; } else {
      this.expect_unit = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.start_date = null; } else {
      this.start_date = java.sql.Date.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.operator = null; } else {
      this.operator = Long.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.STATUS = null; } else {
      this.STATUS = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.protect_plan = null; } else {
      this.protect_plan = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.transfer_enable = null; } else {
      this.transfer_enable = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.need_bankcode = null; } else {
      this.need_bankcode = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.template = null; } else {
      this.template = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.show_scope = null; } else {
      this.show_scope = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.suffix = null; } else {
      this.suffix = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.rate_show = null; } else {
      this.rate_show = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.user_level = null; } else {
      this.user_level = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.show_content = null; } else {
      this.show_content = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.use_coupon = null; } else {
      this.use_coupon = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.support_stage_pack = null; } else {
      this.support_stage_pack = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.homepage_recommend_sort_num = null; } else {
      this.homepage_recommend_sort_num = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.platform_type = null; } else {
      this.platform_type = BooleanParser.valueOf(__cur_str);
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

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.collection_mode = null; } else {
      this.collection_mode = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.borrows_range = null; } else {
      this.borrows_range = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.recommend_scope = null; } else {
      this.recommend_scope = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.product_name = null; } else {
      this.product_name = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.product_price = null; } else {
      this.product_price = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.product_nono_price = null; } else {
      this.product_nono_price = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.product_hot = null; } else {
      this.product_hot = BooleanParser.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.product_mobile_img = null; } else {
      this.product_mobile_img = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.product_pc_img = null; } else {
      this.product_pc_img = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.is_auto_clone = null; } else {
      this.is_auto_clone = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.product_type = null; } else {
      this.product_type = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.rate_desc = null; } else {
      this.rate_desc = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.homepage_is_show = null; } else {
      this.homepage_is_show = BooleanParser.valueOf(__cur_str);
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    finance_plan o = (finance_plan) super.clone();
    o.publish_date = (o.publish_date != null) ? (java.sql.Timestamp) o.publish_date.clone() : null;
    o.finish_date = (o.finish_date != null) ? (java.sql.Date) o.finish_date.clone() : null;
    o.start_date = (o.start_date != null) ? (java.sql.Date) o.start_date.clone() : null;
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
    return o;
  }

  public void clone0(finance_plan o) throws CloneNotSupportedException {
    o.publish_date = (o.publish_date != null) ? (java.sql.Timestamp) o.publish_date.clone() : null;
    o.finish_date = (o.finish_date != null) ? (java.sql.Date) o.finish_date.clone() : null;
    o.start_date = (o.start_date != null) ? (java.sql.Date) o.start_date.clone() : null;
    o.create_time = (o.create_time != null) ? (java.sql.Timestamp) o.create_time.clone() : null;
    o.update_time = (o.update_time != null) ? (java.sql.Timestamp) o.update_time.clone() : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("title", this.title);
    __sqoop$field_map.put("scope", this.scope);
    __sqoop$field_map.put("price", this.price);
    __sqoop$field_map.put("price_finish", this.price_finish);
    __sqoop$field_map.put("price_adjust", this.price_adjust);
    __sqoop$field_map.put("price_increment", this.price_increment);
    __sqoop$field_map.put("price_min", this.price_min);
    __sqoop$field_map.put("price_max", this.price_max);
    __sqoop$field_map.put("rate_min", this.rate_min);
    __sqoop$field_map.put("rate_max", this.rate_max);
    __sqoop$field_map.put("stop_bidding_days", this.stop_bidding_days);
    __sqoop$field_map.put("auto_bid", this.auto_bid);
    __sqoop$field_map.put("earnings_intro", this.earnings_intro);
    __sqoop$field_map.put("buy_limit", this.buy_limit);
    __sqoop$field_map.put("redeem_normal_way", this.redeem_normal_way);
    __sqoop$field_map.put("redeem_other_way", this.redeem_other_way);
    __sqoop$field_map.put("publish_date", this.publish_date);
    __sqoop$field_map.put("finish_date", this.finish_date);
    __sqoop$field_map.put("slogan", this.slogan);
    __sqoop$field_map.put("explanation", this.explanation);
    __sqoop$field_map.put("expect", this.expect);
    __sqoop$field_map.put("expect_unit", this.expect_unit);
    __sqoop$field_map.put("start_date", this.start_date);
    __sqoop$field_map.put("operator", this.operator);
    __sqoop$field_map.put("STATUS", this.STATUS);
    __sqoop$field_map.put("protect_plan", this.protect_plan);
    __sqoop$field_map.put("transfer_enable", this.transfer_enable);
    __sqoop$field_map.put("need_bankcode", this.need_bankcode);
    __sqoop$field_map.put("template", this.template);
    __sqoop$field_map.put("show_scope", this.show_scope);
    __sqoop$field_map.put("suffix", this.suffix);
    __sqoop$field_map.put("rate_show", this.rate_show);
    __sqoop$field_map.put("user_level", this.user_level);
    __sqoop$field_map.put("show_content", this.show_content);
    __sqoop$field_map.put("use_coupon", this.use_coupon);
    __sqoop$field_map.put("support_stage_pack", this.support_stage_pack);
    __sqoop$field_map.put("homepage_recommend_sort_num", this.homepage_recommend_sort_num);
    __sqoop$field_map.put("platform_type", this.platform_type);
    __sqoop$field_map.put("version", this.version);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("collection_mode", this.collection_mode);
    __sqoop$field_map.put("borrows_range", this.borrows_range);
    __sqoop$field_map.put("recommend_scope", this.recommend_scope);
    __sqoop$field_map.put("product_name", this.product_name);
    __sqoop$field_map.put("product_price", this.product_price);
    __sqoop$field_map.put("product_nono_price", this.product_nono_price);
    __sqoop$field_map.put("product_hot", this.product_hot);
    __sqoop$field_map.put("product_mobile_img", this.product_mobile_img);
    __sqoop$field_map.put("product_pc_img", this.product_pc_img);
    __sqoop$field_map.put("is_auto_clone", this.is_auto_clone);
    __sqoop$field_map.put("product_type", this.product_type);
    __sqoop$field_map.put("rate_desc", this.rate_desc);
    __sqoop$field_map.put("homepage_is_show", this.homepage_is_show);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("id", this.id);
    __sqoop$field_map.put("title", this.title);
    __sqoop$field_map.put("scope", this.scope);
    __sqoop$field_map.put("price", this.price);
    __sqoop$field_map.put("price_finish", this.price_finish);
    __sqoop$field_map.put("price_adjust", this.price_adjust);
    __sqoop$field_map.put("price_increment", this.price_increment);
    __sqoop$field_map.put("price_min", this.price_min);
    __sqoop$field_map.put("price_max", this.price_max);
    __sqoop$field_map.put("rate_min", this.rate_min);
    __sqoop$field_map.put("rate_max", this.rate_max);
    __sqoop$field_map.put("stop_bidding_days", this.stop_bidding_days);
    __sqoop$field_map.put("auto_bid", this.auto_bid);
    __sqoop$field_map.put("earnings_intro", this.earnings_intro);
    __sqoop$field_map.put("buy_limit", this.buy_limit);
    __sqoop$field_map.put("redeem_normal_way", this.redeem_normal_way);
    __sqoop$field_map.put("redeem_other_way", this.redeem_other_way);
    __sqoop$field_map.put("publish_date", this.publish_date);
    __sqoop$field_map.put("finish_date", this.finish_date);
    __sqoop$field_map.put("slogan", this.slogan);
    __sqoop$field_map.put("explanation", this.explanation);
    __sqoop$field_map.put("expect", this.expect);
    __sqoop$field_map.put("expect_unit", this.expect_unit);
    __sqoop$field_map.put("start_date", this.start_date);
    __sqoop$field_map.put("operator", this.operator);
    __sqoop$field_map.put("STATUS", this.STATUS);
    __sqoop$field_map.put("protect_plan", this.protect_plan);
    __sqoop$field_map.put("transfer_enable", this.transfer_enable);
    __sqoop$field_map.put("need_bankcode", this.need_bankcode);
    __sqoop$field_map.put("template", this.template);
    __sqoop$field_map.put("show_scope", this.show_scope);
    __sqoop$field_map.put("suffix", this.suffix);
    __sqoop$field_map.put("rate_show", this.rate_show);
    __sqoop$field_map.put("user_level", this.user_level);
    __sqoop$field_map.put("show_content", this.show_content);
    __sqoop$field_map.put("use_coupon", this.use_coupon);
    __sqoop$field_map.put("support_stage_pack", this.support_stage_pack);
    __sqoop$field_map.put("homepage_recommend_sort_num", this.homepage_recommend_sort_num);
    __sqoop$field_map.put("platform_type", this.platform_type);
    __sqoop$field_map.put("version", this.version);
    __sqoop$field_map.put("create_time", this.create_time);
    __sqoop$field_map.put("update_time", this.update_time);
    __sqoop$field_map.put("collection_mode", this.collection_mode);
    __sqoop$field_map.put("borrows_range", this.borrows_range);
    __sqoop$field_map.put("recommend_scope", this.recommend_scope);
    __sqoop$field_map.put("product_name", this.product_name);
    __sqoop$field_map.put("product_price", this.product_price);
    __sqoop$field_map.put("product_nono_price", this.product_nono_price);
    __sqoop$field_map.put("product_hot", this.product_hot);
    __sqoop$field_map.put("product_mobile_img", this.product_mobile_img);
    __sqoop$field_map.put("product_pc_img", this.product_pc_img);
    __sqoop$field_map.put("is_auto_clone", this.is_auto_clone);
    __sqoop$field_map.put("product_type", this.product_type);
    __sqoop$field_map.put("rate_desc", this.rate_desc);
    __sqoop$field_map.put("homepage_is_show", this.homepage_is_show);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("id".equals(__fieldName)) {
      this.id = (Long) __fieldVal;
    }
    else    if ("title".equals(__fieldName)) {
      this.title = (String) __fieldVal;
    }
    else    if ("scope".equals(__fieldName)) {
      this.scope = (Integer) __fieldVal;
    }
    else    if ("price".equals(__fieldName)) {
      this.price = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price_finish".equals(__fieldName)) {
      this.price_finish = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price_adjust".equals(__fieldName)) {
      this.price_adjust = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price_increment".equals(__fieldName)) {
      this.price_increment = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price_min".equals(__fieldName)) {
      this.price_min = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("price_max".equals(__fieldName)) {
      this.price_max = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("rate_min".equals(__fieldName)) {
      this.rate_min = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("rate_max".equals(__fieldName)) {
      this.rate_max = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("stop_bidding_days".equals(__fieldName)) {
      this.stop_bidding_days = (Integer) __fieldVal;
    }
    else    if ("auto_bid".equals(__fieldName)) {
      this.auto_bid = (Boolean) __fieldVal;
    }
    else    if ("earnings_intro".equals(__fieldName)) {
      this.earnings_intro = (String) __fieldVal;
    }
    else    if ("buy_limit".equals(__fieldName)) {
      this.buy_limit = (String) __fieldVal;
    }
    else    if ("redeem_normal_way".equals(__fieldName)) {
      this.redeem_normal_way = (String) __fieldVal;
    }
    else    if ("redeem_other_way".equals(__fieldName)) {
      this.redeem_other_way = (String) __fieldVal;
    }
    else    if ("publish_date".equals(__fieldName)) {
      this.publish_date = (java.sql.Timestamp) __fieldVal;
    }
    else    if ("finish_date".equals(__fieldName)) {
      this.finish_date = (java.sql.Date) __fieldVal;
    }
    else    if ("slogan".equals(__fieldName)) {
      this.slogan = (String) __fieldVal;
    }
    else    if ("explanation".equals(__fieldName)) {
      this.explanation = (String) __fieldVal;
    }
    else    if ("expect".equals(__fieldName)) {
      this.expect = (Integer) __fieldVal;
    }
    else    if ("expect_unit".equals(__fieldName)) {
      this.expect_unit = (Integer) __fieldVal;
    }
    else    if ("start_date".equals(__fieldName)) {
      this.start_date = (java.sql.Date) __fieldVal;
    }
    else    if ("operator".equals(__fieldName)) {
      this.operator = (Long) __fieldVal;
    }
    else    if ("STATUS".equals(__fieldName)) {
      this.STATUS = (Integer) __fieldVal;
    }
    else    if ("protect_plan".equals(__fieldName)) {
      this.protect_plan = (String) __fieldVal;
    }
    else    if ("transfer_enable".equals(__fieldName)) {
      this.transfer_enable = (Boolean) __fieldVal;
    }
    else    if ("need_bankcode".equals(__fieldName)) {
      this.need_bankcode = (Integer) __fieldVal;
    }
    else    if ("template".equals(__fieldName)) {
      this.template = (String) __fieldVal;
    }
    else    if ("show_scope".equals(__fieldName)) {
      this.show_scope = (Integer) __fieldVal;
    }
    else    if ("suffix".equals(__fieldName)) {
      this.suffix = (String) __fieldVal;
    }
    else    if ("rate_show".equals(__fieldName)) {
      this.rate_show = (String) __fieldVal;
    }
    else    if ("user_level".equals(__fieldName)) {
      this.user_level = (String) __fieldVal;
    }
    else    if ("show_content".equals(__fieldName)) {
      this.show_content = (String) __fieldVal;
    }
    else    if ("use_coupon".equals(__fieldName)) {
      this.use_coupon = (Integer) __fieldVal;
    }
    else    if ("support_stage_pack".equals(__fieldName)) {
      this.support_stage_pack = (Integer) __fieldVal;
    }
    else    if ("homepage_recommend_sort_num".equals(__fieldName)) {
      this.homepage_recommend_sort_num = (Integer) __fieldVal;
    }
    else    if ("platform_type".equals(__fieldName)) {
      this.platform_type = (Boolean) __fieldVal;
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
    else    if ("collection_mode".equals(__fieldName)) {
      this.collection_mode = (Integer) __fieldVal;
    }
    else    if ("borrows_range".equals(__fieldName)) {
      this.borrows_range = (String) __fieldVal;
    }
    else    if ("recommend_scope".equals(__fieldName)) {
      this.recommend_scope = (Integer) __fieldVal;
    }
    else    if ("product_name".equals(__fieldName)) {
      this.product_name = (String) __fieldVal;
    }
    else    if ("product_price".equals(__fieldName)) {
      this.product_price = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("product_nono_price".equals(__fieldName)) {
      this.product_nono_price = (java.math.BigDecimal) __fieldVal;
    }
    else    if ("product_hot".equals(__fieldName)) {
      this.product_hot = (Boolean) __fieldVal;
    }
    else    if ("product_mobile_img".equals(__fieldName)) {
      this.product_mobile_img = (String) __fieldVal;
    }
    else    if ("product_pc_img".equals(__fieldName)) {
      this.product_pc_img = (String) __fieldVal;
    }
    else    if ("is_auto_clone".equals(__fieldName)) {
      this.is_auto_clone = (Integer) __fieldVal;
    }
    else    if ("product_type".equals(__fieldName)) {
      this.product_type = (String) __fieldVal;
    }
    else    if ("rate_desc".equals(__fieldName)) {
      this.rate_desc = (String) __fieldVal;
    }
    else    if ("homepage_is_show".equals(__fieldName)) {
      this.homepage_is_show = (Boolean) __fieldVal;
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
    else    if ("title".equals(__fieldName)) {
      this.title = (String) __fieldVal;
      return true;
    }
    else    if ("scope".equals(__fieldName)) {
      this.scope = (Integer) __fieldVal;
      return true;
    }
    else    if ("price".equals(__fieldName)) {
      this.price = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price_finish".equals(__fieldName)) {
      this.price_finish = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price_adjust".equals(__fieldName)) {
      this.price_adjust = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price_increment".equals(__fieldName)) {
      this.price_increment = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price_min".equals(__fieldName)) {
      this.price_min = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("price_max".equals(__fieldName)) {
      this.price_max = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("rate_min".equals(__fieldName)) {
      this.rate_min = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("rate_max".equals(__fieldName)) {
      this.rate_max = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("stop_bidding_days".equals(__fieldName)) {
      this.stop_bidding_days = (Integer) __fieldVal;
      return true;
    }
    else    if ("auto_bid".equals(__fieldName)) {
      this.auto_bid = (Boolean) __fieldVal;
      return true;
    }
    else    if ("earnings_intro".equals(__fieldName)) {
      this.earnings_intro = (String) __fieldVal;
      return true;
    }
    else    if ("buy_limit".equals(__fieldName)) {
      this.buy_limit = (String) __fieldVal;
      return true;
    }
    else    if ("redeem_normal_way".equals(__fieldName)) {
      this.redeem_normal_way = (String) __fieldVal;
      return true;
    }
    else    if ("redeem_other_way".equals(__fieldName)) {
      this.redeem_other_way = (String) __fieldVal;
      return true;
    }
    else    if ("publish_date".equals(__fieldName)) {
      this.publish_date = (java.sql.Timestamp) __fieldVal;
      return true;
    }
    else    if ("finish_date".equals(__fieldName)) {
      this.finish_date = (java.sql.Date) __fieldVal;
      return true;
    }
    else    if ("slogan".equals(__fieldName)) {
      this.slogan = (String) __fieldVal;
      return true;
    }
    else    if ("explanation".equals(__fieldName)) {
      this.explanation = (String) __fieldVal;
      return true;
    }
    else    if ("expect".equals(__fieldName)) {
      this.expect = (Integer) __fieldVal;
      return true;
    }
    else    if ("expect_unit".equals(__fieldName)) {
      this.expect_unit = (Integer) __fieldVal;
      return true;
    }
    else    if ("start_date".equals(__fieldName)) {
      this.start_date = (java.sql.Date) __fieldVal;
      return true;
    }
    else    if ("operator".equals(__fieldName)) {
      this.operator = (Long) __fieldVal;
      return true;
    }
    else    if ("STATUS".equals(__fieldName)) {
      this.STATUS = (Integer) __fieldVal;
      return true;
    }
    else    if ("protect_plan".equals(__fieldName)) {
      this.protect_plan = (String) __fieldVal;
      return true;
    }
    else    if ("transfer_enable".equals(__fieldName)) {
      this.transfer_enable = (Boolean) __fieldVal;
      return true;
    }
    else    if ("need_bankcode".equals(__fieldName)) {
      this.need_bankcode = (Integer) __fieldVal;
      return true;
    }
    else    if ("template".equals(__fieldName)) {
      this.template = (String) __fieldVal;
      return true;
    }
    else    if ("show_scope".equals(__fieldName)) {
      this.show_scope = (Integer) __fieldVal;
      return true;
    }
    else    if ("suffix".equals(__fieldName)) {
      this.suffix = (String) __fieldVal;
      return true;
    }
    else    if ("rate_show".equals(__fieldName)) {
      this.rate_show = (String) __fieldVal;
      return true;
    }
    else    if ("user_level".equals(__fieldName)) {
      this.user_level = (String) __fieldVal;
      return true;
    }
    else    if ("show_content".equals(__fieldName)) {
      this.show_content = (String) __fieldVal;
      return true;
    }
    else    if ("use_coupon".equals(__fieldName)) {
      this.use_coupon = (Integer) __fieldVal;
      return true;
    }
    else    if ("support_stage_pack".equals(__fieldName)) {
      this.support_stage_pack = (Integer) __fieldVal;
      return true;
    }
    else    if ("homepage_recommend_sort_num".equals(__fieldName)) {
      this.homepage_recommend_sort_num = (Integer) __fieldVal;
      return true;
    }
    else    if ("platform_type".equals(__fieldName)) {
      this.platform_type = (Boolean) __fieldVal;
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
    else    if ("collection_mode".equals(__fieldName)) {
      this.collection_mode = (Integer) __fieldVal;
      return true;
    }
    else    if ("borrows_range".equals(__fieldName)) {
      this.borrows_range = (String) __fieldVal;
      return true;
    }
    else    if ("recommend_scope".equals(__fieldName)) {
      this.recommend_scope = (Integer) __fieldVal;
      return true;
    }
    else    if ("product_name".equals(__fieldName)) {
      this.product_name = (String) __fieldVal;
      return true;
    }
    else    if ("product_price".equals(__fieldName)) {
      this.product_price = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("product_nono_price".equals(__fieldName)) {
      this.product_nono_price = (java.math.BigDecimal) __fieldVal;
      return true;
    }
    else    if ("product_hot".equals(__fieldName)) {
      this.product_hot = (Boolean) __fieldVal;
      return true;
    }
    else    if ("product_mobile_img".equals(__fieldName)) {
      this.product_mobile_img = (String) __fieldVal;
      return true;
    }
    else    if ("product_pc_img".equals(__fieldName)) {
      this.product_pc_img = (String) __fieldVal;
      return true;
    }
    else    if ("is_auto_clone".equals(__fieldName)) {
      this.is_auto_clone = (Integer) __fieldVal;
      return true;
    }
    else    if ("product_type".equals(__fieldName)) {
      this.product_type = (String) __fieldVal;
      return true;
    }
    else    if ("rate_desc".equals(__fieldName)) {
      this.rate_desc = (String) __fieldVal;
      return true;
    }
    else    if ("homepage_is_show".equals(__fieldName)) {
      this.homepage_is_show = (Boolean) __fieldVal;
      return true;
    }
    else {
      return false;    }
  }
}
