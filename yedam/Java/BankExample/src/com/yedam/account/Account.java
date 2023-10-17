package com.yedam.account;

import java.sql.Date;

import lombok.Data;

//import lombok.Getter;
//import lombok.NoArgsConstructor;
//import lombok.Setter;
//import lombok.ToString;
//
//@Getter
//@Setter
//@NoArgsConstructor //기본생성자
//@ToString

@Data

public class Account {
	private String accountId;
	private int accountBalance;
	private Date accountCredate;
	private String memberId;
	
}
