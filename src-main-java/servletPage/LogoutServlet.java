  
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
 * Servlet implementation class LogoutServlet
 */

@WebServlet("/subau/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");  
		HttpSession session = request.getSession();
        session.invalidate();		
        
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그아웃 되었습니다')");
		script.println("location.href='login'");
		script.println("</script>");	
		
//        ServletContext context =getServletContext();
//        RequestDispatcher dispatcher = context.getRequestDispatcher("/login1.jsp");
//        dispatcher.forward(request, response);	
	}

}