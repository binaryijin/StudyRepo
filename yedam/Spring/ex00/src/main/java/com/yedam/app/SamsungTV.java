package com.yedam.app;

public class SamsungTV implements TV {

	@Override
	public void on() {
		System.out.println("삼성 TV를 켰습니다.");
	}

}
