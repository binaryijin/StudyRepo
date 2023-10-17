package com.spring.anotation;

import org.springframework.context.support.GenericXmlApplicationContext;


public class AnotationMainExample {

	public static void main(String[] args) {
		GenericXmlApplicationContext ctx
		= new GenericXmlApplicationContext("classpath:applicationContext.xml");
		
		TV tv = (TV)ctx.getBean("tv");
		tv.on();
	}

}
