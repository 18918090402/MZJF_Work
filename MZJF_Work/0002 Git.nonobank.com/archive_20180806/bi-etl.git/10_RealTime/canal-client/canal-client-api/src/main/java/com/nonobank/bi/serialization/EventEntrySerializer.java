package com.nonobank.bi.serialization;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.Map;

import org.apache.kafka.common.serialization.Serializer;

import com.nonobank.bi.model.EventEntry;

public class EventEntrySerializer implements Serializer<EventEntry> {

	@Override
	public void configure(Map<String, ?> configs, boolean isKey) {
		// nothing to do
	}

	@Override
	public void close() {
		// nothing to do
	}

	@Override
	public byte[] serialize(String topic, EventEntry data) {
		// TODO Auto-generated method stub
		byte[] bytes = null;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		try {
			ObjectOutputStream oos = new ObjectOutputStream(bos);
			oos.writeObject(data);
			oos.flush();
			bytes = bos.toByteArray();
			oos.close();
			bos.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return bytes;
	}
}