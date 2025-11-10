package com.example.board.controller;

import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.board.model.Board;
import com.example.board.service.BoardService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/board")
public class BoardController {

	private final BoardService boardService;

	// 생성자 주입
	public BoardController(BoardService boardService) {
		this.boardService = boardService;
	}

	// Create 게시글 작성 (폼)
	@GetMapping("/write")
	public String writeForm(Model model) {
		model.addAttribute("board", new Board());
		return "board/write";
	}

	// Create 게시글 작성 (처리)
	@PostMapping("/write")
	public String write(@Valid Board board, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "board/write";
		}
		boardService.save(board);
		return "redirect:/board/list";
	}

	// Read 목록 조회
	@GetMapping("/list")
	public String boardList(Model model) {
		model.addAttribute("boardList", boardService.findAll());
		return "board/list";
	}

	// Read 상세보기 (JSP에서 Optional 오류 방지 및 Null 처리 개선)
	@GetMapping("/view/{id}")
	public String boardView(@PathVariable("id") Long id, Model model) {
		Optional<Board> boardOptional = boardService.findById(id);
        
        if (boardOptional.isPresent()) {
            // Optional을 해제하여 실제 Board 객체를 모델에 담습니다.
            model.addAttribute("board", boardOptional.get());
            return "board/view";
        } else {
            // 게시글이 없는 경우
            System.err.println("게시글 조회 오류: ID " + id + "번 게시글을 찾을 수 없습니다.");
            return "redirect:/board/list"; // 목록으로 리다이렉트
        }
	}

	// 수정 폼 로드
	@GetMapping("/modify/{id}")
	public String modifyForm(@PathVariable("id") Long id, Model model) {
		
		// 1. 서비스를 통해 해당 ID의 게시글을 DB에서 조회한다.
		Optional<Board> boardOptional = boardService.findById(id);
		
		if (boardOptional.isPresent()) {
			// 2. 데이터가 있다면, 모델에 담아 수정 jsp로 전달
			model.addAttribute("board", boardOptional.get());
			return "board/modify";
		} else {
			// 3. 데이터가 없다면 목록으로 리다이렉트 (경로 수정)
			return "redirect:/board/list"; // ⬅️ /board/list로 수정
		}
	}

	// 수정 처리 (Post) 유효성 검사 적용
	@PostMapping("/modify")
	public String modify(@Valid Board board, BindingResult bindingResult) {
		
		// 1. 유효성 검사 (@notblank 등) 오류 확인
		if (bindingResult.hasErrors()) {
			// 오류 발생 시 수정 폼으로 돌아가되, model에 board 객체가 이미 담겨있으므로 별도 처리 불필요
			return "board/modify";
		}
		// 2. ID 포함된 Board 객체를 Service에 넘기면 JPA가 Update 쿼리 실행
		boardService.save(board);
		
		// 3. 수정 후 해당 게시글의 상세 보기 페이지로 리다이렉트
		return "redirect:/board/view/" + board.getId(); // ⬅️ /view/ 앞에 /board를 추가하여 절대 경로 완성
	}
	
	// 삭제 처리
	@GetMapping("/delete/{id}")
	public String delete(@PathVariable("id") Long id) {
		boardService.deleteById(id);
		return "redirect:/board/list"; // ⬅️ /board/list로 수정
	}
}