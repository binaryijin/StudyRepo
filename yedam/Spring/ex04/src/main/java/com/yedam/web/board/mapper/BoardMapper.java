package com.yedam.web.board.mapper;

import java.util.List;

import com.yedam.web.board.service.BoardVO;

public interface BoardMapper {
	//전체조회
	public List<BoardVO> selectBoardAllList();
	
	//단건조회
	public BoardVO selectBoard(BoardVO board);
	
	//등록
	//1) 게시글 번호는 자동 생성 -> selectKey
	//2) 테이블을 참조해서 필수값과 옵션값을 구분해서 등록 -> 다이나믹SQL
	public int insertBoard(BoardVO board);
	
	//수정
	//1) 수정 대상 - 제목 || 내용 || 이미지 || 수정날짜
	//2) updatedate : 수정날짜는 항상 수정
	public int updateBoard(BoardVO board);
	
	//삭제
	public int deleteBoard(int boardNo);
}
