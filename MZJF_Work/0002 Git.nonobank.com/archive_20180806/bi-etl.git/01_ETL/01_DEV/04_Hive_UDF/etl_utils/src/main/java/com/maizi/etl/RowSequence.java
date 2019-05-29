package com.maizi.etl;

/**
 * Created by cuirongjin on 2016/11/9.
 */

import org.apache.hadoop.hive.ql.exec.Description;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.hive.ql.udf.UDFType;
import org.apache.hadoop.io.LongWritable;

@Description(name = "row_sequence",
        value = "_FUNC_() - Returns a generated row sequence number starting from 1")
@UDFType(deterministic = false)
public class RowSequence extends UDF {
    private LongWritable result = new LongWritable();

    public RowSequence() {
        result.set(0);
    }

    public LongWritable evaluate() {
        result.set(result.get() + 1);
        return result;
    }
}
