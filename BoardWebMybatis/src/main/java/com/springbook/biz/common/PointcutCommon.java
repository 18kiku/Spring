package com.springbook.biz.common;

import org.aspectj.lang.annotation.Pointcut;

public class PointcutCommon {

	@Pointcut("execution(* com.springbook.biz..*Impl.*(..))")
	public void allPointcut() {} // 참조 메소드, 포인트컷 메소드

	@Pointcut("execution(* com.springbook.biz..*Impl.get*(..))")
	public void getPointcut() {}
	
}
