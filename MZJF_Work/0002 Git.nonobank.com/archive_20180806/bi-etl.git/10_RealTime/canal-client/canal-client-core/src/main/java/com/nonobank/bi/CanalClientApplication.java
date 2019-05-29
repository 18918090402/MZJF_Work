package com.nonobank.bi;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;

import com.nonobank.bi.config.UserProfile;
import com.nonobank.bi.service.CanalClientService;

@SpringBootApplication
@EnableAutoConfiguration(exclude = { DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class })
public class CanalClientApplication implements CommandLineRunner {

	private static final Logger LOGGER = LoggerFactory.getLogger(CanalClientApplication.class);
	
	@Autowired
	private CanalClientService canalclientService;
	public static void main(String[] args) throws Exception {
		if (System.getProperty("spring.profiles.active") == null) {
			System.setProperty("spring.profiles.active", UserProfile.INTG);
		}
		SpringApplication.run(CanalClientApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		canalclientService.canalMain();
	}
}