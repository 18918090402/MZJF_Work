package canal.client.entry;
import java.util.Map;
/**
 * Created by lingyuangen on 2017/9/12.
 */
public class EventEntry {
    private long eventId = 0;//事件唯一标识
    private String serverName = null;
    private String schemaName = null;
    private String tableName = null;
    private String eventType = null;//事件类型
    private long timestamp = 0;//事件发生的时间戳[MySQL服务器的时间]
    private String binlogName = null;// binlog file name
    private long position = 0;
    private long serverId = 0;
    private Map<String,String> before = null;
    private Map<String,String> after = null;
    private Boolean isDdl= null;
    private String sql = null;
    private Map<String,String> primaryKey = null;//每个订阅表的主键
	
	public EventEntry(){

    }

    @Override
    public String toString(){
        StringBuilder builder = new StringBuilder();
        builder.append("{ eventId:").append(eventId);
        builder.append(",serverName:").append(serverName);
        builder.append(",schemaName:").append(schemaName);
        builder.append(",tableName:").append(tableName);
        builder.append(",primaryKey:").append(primaryKey);
        builder.append(",eventType:").append(eventType);
        builder.append(",timestamp:").append(timestamp);
        builder.append(",binlogName:").append(binlogName);
        builder.append(",position:").append(position);
        builder.append(",serverId:").append(serverId);
        builder.append(",isDdl:").append(isDdl);
        builder.append(",sql:").append(sql);
        builder.append(",before:").append(before);
        builder.append(",after:").append(after).append("}");

        return builder.toString();
    }
// 省略Getter和Setter方法
    
    public Boolean getIsDdl() {
  		return isDdl;
  	}

  	public String getSchemaName() {
		return schemaName;
	}

	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
	}

	public void setIsDdl(Boolean isDdl) {
  		this.isDdl = isDdl;
  	}

    public long getEventId() {
        return eventId;
    }

    public void setEventId(long eventId) {
        this.eventId = eventId;
    }

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }
    public String getBinlogName() {
        return binlogName;
    }

    public void setBinlogName(String binlogName) {
        this.binlogName = binlogName;
    }

    public long getPosition() {
        return position;
    }

    public void setPosition(long position) {
        this.position = position;
    }
    public long getServerId() {
        return serverId;
    }

    public void setServerId(long serverId) {
        this.serverId = serverId;
    }

    public Map<String, String> getBefore() {
        return before;
    }

    public void setBefore(Map<String, String> before) {
        this.before = before;
    }

    public Map<String, String> getAfter() {
        return after;
    }

    public void setAfter(Map<String, String> after) {
        this.after = after;
    }

    public Boolean getDdl() {
        return isDdl;
    }

    public void setDdl(Boolean ddl) {
        isDdl = ddl;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }
    
    public Map<String, String> getPrimaryKey() {
		return primaryKey;
	}

	public void setPrimaryKey(Map<String, String> primaryKey) {
		this.primaryKey = primaryKey;
	}

}
