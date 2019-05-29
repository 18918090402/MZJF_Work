package com.nonobank.bi.serialization;

import java.io.ByteArrayInputStream;
import java.io.ObjectInputStream;
import java.util.Map;

import org.apache.kafka.common.errors.SerializationException;
import org.apache.kafka.common.serialization.Deserializer;

import com.nonobank.bi.model.EventEntry;

public class EventEntryDeserializer implements Deserializer<EventEntry> {

    @Override
    public void configure(Map<String, ?> configs, boolean isKey) {
        // nothing to do
    }

    @Override
    public EventEntry deserialize(String topic, byte[] data) {
        if (data == null)
            return null;
        
        EventEntry obj = null;      
        try {        
            ByteArrayInputStream bis = new ByteArrayInputStream (data);        
            ObjectInputStream ois = new ObjectInputStream (bis);        
            obj = (EventEntry) ois.readObject();      
            ois.close();   
            bis.close();   
        } catch (Exception ex) {
            ex.printStackTrace();   
            throw new SerializationException(" Deserializer Error!");
        }     
        return obj; 
    }

    @Override
    public void close() {
        // nothing to do
    }
}