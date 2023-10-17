package co.micol.notice.main.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.notice.common.Command;

public class MainCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// main.jsp 돌려주는 곳
		return "main/main"; //main밑의 main.jsp
	}

}
