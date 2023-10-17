package com.yedam.app;

import org.springframework.context.support.GenericXmlApplicationContext;

public class SpringMainExample {

	public static void main(String[] args) {
		GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationContext.xml");
		
		TV tv = (TV)ctx.getBean("tv"); //인터페이스 변환
		tv.on();
	}

}
