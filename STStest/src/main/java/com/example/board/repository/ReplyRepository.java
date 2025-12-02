package com.example.board.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.board.model.Reply;

public interface ReplyRepository extends JpaRepository<Reply, Long> {
	List<Reply> findByBoard_Id(Long boardId);
}
