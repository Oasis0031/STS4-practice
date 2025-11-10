package com.example.ststest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

// Spring Boot 애플리케이션의 시작점임을 알리는 필수 어노테이션
@SpringBootApplication(scanBasePackages = {"com.example.ststest", "com.example.board"})
@EntityScan(basePackages = {"com.example.board.model"})
@EnableJpaRepositories(basePackages = "com.example.board.repository")
public class StstestApplication extends SpringBootServletInitializer { // 💡 파일 이름과 클래스 이름이 일치해야 합니다.

	public static void main(String[] args) {
		// Spring 애플리케이션을 실행하는 핵심 메서드
		SpringApplication.run(StstestApplication.class, args);
	}

}