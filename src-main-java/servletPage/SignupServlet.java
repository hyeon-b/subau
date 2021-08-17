  
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

import user.UserDAO;

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet("/subau/signup")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");  
  		
		PrintWriter script = response.getWriter();
		
		String usrid = request.getParameter("user_id");			//사용자가 입력한 회원 정보 저장
        String usrnname = request.getParameter("nickName");
        String usrpwd = request.getParameter("user_pwd");

		UserDAO userDAO = new UserDAO();						//회원db에 저장
		int result = userDAO.signUp(usrid, usrnname, usrpwd);
		if(result == 0) {										//db저장 성공 == 회원 가입 성공 -> 로그인 페이지
	        ServletContext context =getServletContext();
	        RequestDispatcher dispatcher = context.getRequestDispatcher("/login");
	        dispatcher.forward(request, response);	
		} else if(result == -2){								//db저장 실패 
			script.println("<script>");
			script.println("alert('이메일 주소, 별명, 비밀번호를 한번 더 확인해 주십시오.')");
			script.println("history.back()");
			script.println("</script>");
		} 
	}

}