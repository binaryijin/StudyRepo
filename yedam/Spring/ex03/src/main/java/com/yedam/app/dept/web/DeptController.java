package com.yedam.app.dept.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yedam.app.dept.service.DeptService;
import com.yedam.app.dept.service.DeptVO;

@Controller
public class DeptController {
	@Autowired
	DeptService deptService;
	
	//전체조회
	@GetMapping("/deptList")
	public String getDeptAllList(Model model) {
		model.addAttribute("deptList", deptService.getDeptAll());
		return "dept/deptList";
	}
	
	//단건조회
	@GetMapping("/deptInfo")
	public String getDeptInfo(DeptVO deptVO, Model model) {
		DeptVO findVO = deptService.getDept(deptVO);
		model.addAttribute("deptInfo", findVO);
		return "dept/deptInfo";
	}
	
	//등록 페이지 - From 
	@GetMapping("/deptInsert")
	public String deptInsertForm() {
		return "dept/deptInsert";
	}
	
	//등록 - Process
	@PostMapping("/deptInsert")
	public String deptInsertProcess(DeptVO deptVO, RedirectAttributes rtt) {
		int result = deptService.insertDept(deptVO);
		String uri = null;
		String message = null;
		
		if(result == -1) {
			message = "등록되지 않았습니다.";
			uri = "deptList";
		}else {
			message = "등록되었습니다. \n 등록된 부서번호는 " + result + "입니다.";
			uri = "deptInfo?departmentId=" + result;
		}
		rtt.addFlashAttribute("message", message);
//		return "redirect:deptList";
//		return "redirect:deptInfo?departmentId="+result;
		return "redirect:" + uri;
	}
	
	//수정
	@PostMapping("/deptUpdate")
	@ResponseBody
	public Map<String, String> deptUpdateProcess(@RequestBody DeptVO deptVO){
		return deptService.updateDept(deptVO);
	}
	
	//삭제
	@PostMapping("/deptDelete")
	@ResponseBody
	public String deptDeleteProcess(@RequestParam int deptId) {
		Map<String, String> map = deptService.deleteDept(deptId);
		return map.get("결과");
		
	}
	
}
