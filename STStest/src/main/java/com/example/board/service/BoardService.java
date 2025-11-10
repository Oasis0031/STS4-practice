package com.example.board.service;

import java.util.List;
import java.util.Optional;

import com.example.board.model.Board;


public interface BoardService {

	List<Board> findAll();		//목록 전체 조회
	Board save(Board board);	//게시글 저장 (c)
	Optional<Board> findById(Long id);	// ID로 게시글 1개 조회(R)
	void deleteById(Long id);		//삭제 메서드 정의
}
