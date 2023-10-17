package com.yedam.app.emp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yedam.app.emp.service.EmpVO;

public interface EmpMapper {
	//전체조회
	public List<EmpVO> selectEmpAllList();
	
	//단건조회
	public EmpVO selectEmpInfo(EmpVO empVO);
	
	//등록(DML은 리턴값이 정수임)
	public int insertEmpInfo(EmpVO empVO);
	
	//수정 - 급여를 정해진 비율로 인상, VO클래서 사용X
	//2개 이상의 매개변수를 사용할때 Param을 씀. Param - sql문에서 사용할 이름 정함
	public int updateEmpSal(@Param("emp") EmpVO empVO, @Param("raise") int raise);
	//@Param("emp") -> mapper.xml에서 #{emp.employeeId} 로 사용하면됨 => 객체
	//@Param("empId") -> #{empId}, int employeeId
	
	
	//수정 - 사원정보를 수정
	public int updateEmpInfo(EmpVO empVO);
	
	//삭제
	public int deleteEmpInfo(int employeeId);
}
