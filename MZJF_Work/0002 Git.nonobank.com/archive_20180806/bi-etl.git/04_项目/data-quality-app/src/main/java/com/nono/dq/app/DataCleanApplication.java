package com.nono.dq.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 
 *
 */
@SpringBootApplication(scanBasePackages={"com.nono.dq"})
@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
public class DataCleanApplication {
	
	public static void main(String[] args) throws Exception {
		if (System.getProperty("spring.profiles.active") == null) {
			System.setProperty("spring.profiles.active", UserProfile.INTG);
		}
		SpringApplication.run(DataCleanApplication.class, args);
	}
}