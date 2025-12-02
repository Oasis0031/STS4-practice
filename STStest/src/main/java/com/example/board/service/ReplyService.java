package com.example.board.service;

import java.util.List;

import com.example.board.model.Reply;

public interface ReplyService {

	Reply saveReply(Long boardId, Reply reply);
	
	List<Reply> getRepliesByBoardId(Long boardId);

	Reply saveSubReply(Long boardId, Long parentReplyId, Reply subReply);
}
