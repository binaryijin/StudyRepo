package com.yedam.web.board.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	private int bno;			// 게시글 번호 - PRIMARY KEY
	private String title;		// 게시글 제목 - NOT NULL
	private String contents;	// 게시글 내용
	private String writer;		// 게시글 작성자 - NOT NULL
	//default : yyyy/MM/dd -> input[type=date] : yyyy-MM-dd
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regdate;		// 게시글 등록일자 - NOT NULL //@DateTimeFormat -> 출력할때의 포맷이 아님
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedate;	// 게시글 수정날짜
	private String image;		// 게시글 첨부파일
}
