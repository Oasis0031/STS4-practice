package com.example.board.service;

import java.util.List;

import com.example.board.model.Board;
import com.example.board.model.Reply;
import com.example.board.repository.BoardRepository;
import com.example.board.repository.ReplyRepository;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

public class ReplyServiceImpl implements ReplyService {
	
	private final ReplyRepository replyRepository;
	private final BoardRepository boardRepository;
	
	public ReplyServiceImpl(ReplyRepository replyRepository, BoardRepository boardRepository) {
		this.replyRepository = replyRepository;
		this.boardRepository = boardRepository;
	}

	@Override
	@Transactional
	public Reply saveReply(Long boardId, Reply reply) {
		Board board = boardRepository.findById(boardId)
				.orElseThrow(() -> new EntityNotFoundException("게시글 ID를 찾을 수 없습니다." + boardId));
		
		reply.setBoard(board);
		return replyRepository.save(reply);
	}
	
	@Override
	@Transactional
	public Reply saveSubReply(Long boardId, Long parentReplyId, Reply subReply) {
		Board board = boardRepository.findById(boardId)
				.orElseThrow(() -> new EntityNotFoundException("게시글 ID를 찾을 수 없습니다.: " + boardId)); 
	
	Reply parent = replyRepository.findById(parentReplyId).orElseThrow(() -> new EntityNotFoundException("원 댓글을 찾을 수 없습니다." + parentReplyId));
		
	subReply.setBoard(board); //원본 게시글
	subReply.setParentReply(parent);
	
	return replyRepository.save(subReply);
	}

	@Override
	public List<Reply> getRepliesByBoardId(Long boardId) {
		
		return replyRepository.findByBoard_Id(boardId);
	}

}
