package co.micol.prj.project.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.prj.common.Command;

public class Projects implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 
		return "project/project";
	}

}
