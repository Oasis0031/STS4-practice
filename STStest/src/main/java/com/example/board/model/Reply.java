package com.example.board.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@SequenceGenerator(
		name = "REPLY_SEQ_GEN",			// 생성기 이름
		sequenceName = "REPLY_SEQ",		// 오라클 DB 시퀀스 이름
		initialValue =1,
		allocationSize = 1
	)
@Data
@Entity(name = "REPLY")
public class Reply {
	
	//부모댓글
	@Id
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,
			generator = "REPLY_SEQ_GEN")
	@Column(name = "REPLY_ID")
	private Long replyId;
	
	@Column(name = "REPLY_AUTHOR")
	private String replyAuthor;
	
	@Column(name = "REPLY_CONTENT")
	private String replyContent;
	
	@Column(name = "CREATE_AT")
	private LocalDateTime createdAt = LocalDateTime.now();
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BOARD_ID")
	private Board board;
	
	//대댓
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PARENT_REPLY_ID")
	private Reply parentReply;
	
	@OneToMany(mappedBy = "parentReply", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Reply> subReplies = new ArrayList<>(); // 대댓글 목록
}
	
