package com.yedam.app.user.service;

import lombok.Data;

@Data
public class UserVO {
	private String name;
	private Integer age; //int는 null,공백 못받음
}
