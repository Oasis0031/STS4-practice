package com.example.board.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@SequenceGenerator(
	name = "BOARD_SEQ_GEN",			// 생성기 이름
	sequenceName = "BOARD_SEQ",		// 오라클 DB 시퀀스 이름
	initialValue =1,
	allocationSize = 1
)
@Data
@Entity
public class Board {

	@Id
	@GeneratedValue(
		strategy = GenerationType.SEQUENCE,
		generator = "BOARD_SEQ_GEN"
	)
	private Long id;				// 게시글 번호
	
	@NotBlank(message = "제목은 필수 입력 항목입니다.")	
	@Size(max = 100, message = "제목은 100자를 초과할 수 없습니다.")
	private String title;		// 제목
	
	@NotBlank(message = "내용을 입력해주세요")	
	private String content;		// 내용
	
	@NotBlank(message = "작성자는 필수 입력 항목입니다.")	
	@Size(max = 20, message = "작성자는 20자를 초과할 수 없습니다.")
	private String author;			// 작성자
	
	// Oracle DB 컬럼 이름 'LOCATION'에 매핑
	@Column(name = "LOCATION")
	@Size(max = 50, message = "위치는 50자를 초과할 수 없습니다.")
	private String location;		// 위치
	
	// Oracle DB 컬럼 이름 'WEATHER'에 매핑
	@Column(name = "WEATHER")
	@Size(max = 20, message = "날씨는 20자를 초과할 수 없습니다.")
	private String weather;			// 날씨

	// Oracle DB 컬럼 이름 'CREATED_AT'에 매핑 (가장 중요)
	@Column(name = "CREATED_AT")
	private LocalDateTime createdAt = LocalDateTime.now();	// 작성일자
}