package canal.client;

import java.util.List;
import java.util.Map;

import org.apache.kafka.clients.producer.Partitioner;
import org.apache.kafka.common.Cluster;
import org.apache.kafka.common.PartitionInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MyPartition implements Partitioner{
	private static Logger LOG = LoggerFactory.getLogger(MyPartition.class); 
	public void configure(Map<String, ?> arg0) {
		// TODO Auto-generated method stub
		
	}

	public void close() {
		// TODO Auto-generated method stub
		
	}

	public int partition(String topic, Object key, byte[] keyBytes, Object value, byte[] valueBytes, Cluster cluster) {
		List<PartitionInfo> partitions = cluster.partitionsForTopic(topic);  
        int numPartitions = partitions.size();  
        int partitionNum = 0;  
        try {  
            partitionNum = Integer.parseInt((String) key);
        } catch (Exception e) {  
            partitionNum = key.hashCode();  
        }  
        //LOG.info("the message sendTo topic:" + topic + " and the partitionNum:"+ partitionNum + " and the numPartitions:" + Math.abs(partitionNum % numPartitions));  
        return Math.abs(partitionNum % numPartitions);  
	}

}
