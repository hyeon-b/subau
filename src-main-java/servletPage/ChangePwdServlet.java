package servletPage;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;

/**
 * Servlet implementation class ChangePwdServlet
 */

@WebServlet("/subau/changepwd")
public class ChangePwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePwdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");  
		HttpSession session = request.getSession();
		PrintWriter script = response.getWriter();
		
		String usrid = (String) session.getAttribute("user_id");			//사용자가 입력한 회원 정보 저장
		String orgpwd = request.getParameter("orgPwd");
        String usrpwd = request.getParameter("user_pwd");
	    String pwdCk = request.getParameter("passwordCheck");
	    
//	    script.println("userId: " + usrid + " orgpwd: " + orgpwd + " usrpwd: " + usrpwd + " pwdCk: " + pwdCk);
	    UserDAO userdao = new UserDAO();
	    int result = userdao.changePwdByUser(usrid, orgpwd, pwdCk);
	    if (result == 0) {
	        ServletContext context =getServletContext();
	        session.invalidate();
	        
			script.println("<script>");
			script.println("alert('비밀번호 변경이 완료되었습니다. 다시 로그인 해주십시오.')");
			script.println("location.href='login'");
			script.println("</script>");
	    } else if (result == -1) {
			script.println("<script>");
			script.println("alert('비밀번호를 다시 확인하십시오.')");
			script.println("history.back()");
			script.println("</script>");
	    } else {
			script.println("<script>");
			script.println("alert('DB오류')");
			script.println("</script>");
	    }
	}

}