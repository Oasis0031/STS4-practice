package com.example.board.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.board.model.Board;
import com.example.board.repository.BoardRepository;

import jakarta.transaction.Transactional;

@Service
public class BoardServiceImpl implements BoardService {

	private final BoardRepository boardRepository;

	public BoardServiceImpl(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}
	
	@Override
	public List<Board> findAll() {
		// TODO Auto-generated method stub
		return boardRepository.findAll();
	}

	@Override
	public Board save(Board board) {
		// TODO Auto-generated method stub
		return boardRepository.save(board);
	}

	@Override
	public Optional<Board> findById(Long id) {
		// TODO Auto-generated method stub
		return boardRepository.findById(id);
	}
	
	@Override
	@Transactional
	public void deleteById(Long id) {
		boardRepository.deleteById(id);
	}
}
