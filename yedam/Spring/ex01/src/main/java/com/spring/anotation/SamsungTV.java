package com.spring.anotation;

import org.springframework.stereotype.Component;

@Component("tv")
public class SamsungTV implements TV {

	@Override
	public void on() {
		System.out.println("어노테이션 방식) 삼성 TV를 켭니다.");
	}

}
