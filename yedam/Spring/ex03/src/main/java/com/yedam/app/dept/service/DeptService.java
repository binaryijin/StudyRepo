package com.yedam.app.dept.service;

import java.util.List;
import java.util.Map;

public interface DeptService {
	//전체조회
	public List<DeptVO> getDeptAll();

	//단건조회
	public DeptVO getDept(DeptVO deptVO);
		
	//등록
	public int insertDept(DeptVO deptVO);
	
	//수정
	public Map<String, String> updateDept(DeptVO deptVO);
	
	//삭제
	public Map<String, String> deleteDept(int deptId);
}
