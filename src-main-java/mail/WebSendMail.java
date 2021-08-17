package mail;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import user.UserDAO;

@WebServlet("/WebSendMail")
public class WebSendMail extends HttpServlet {
	int EmailSend = 1;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getContentType().startsWith("multipart/form-data")) {
			try {
				HashMap data = getMailData(request, response);
				sendMail(data);
				if(EmailSend == 0) {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>alert('받는 분 이메일 관련해서 문제가 생긴것 같아요! \n 수정바다유리병 제작진에게 연락주시면 감사하겠습니다!'); location.href='write';</script>");
					out.flush();
				}
				else if(EmailSend == 2){
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>alert('데이터베이스에 문제가 생긴것 같아요! \n 수정바다유리병 제작진에게 연락주시면 감사하겠습니다!'); location.href='write';</script>");
					out.flush();
					}
				else{
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('수정바다에 유리병을 성공적으로 띄웠어요!'); location.href='write';</script>");
				out.flush();
				}
				


			} catch (MessagingException ex) {
				throw new ServletException(ex);
			}
		} else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}

	private HashMap getMailData(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException, MessagingException {
		String boundary = request.getHeader("Content-Type");
		int pos = boundary.indexOf('=');
		boundary = boundary.substring(pos + 1);
		boundary = "--" + boundary;
		ServletInputStream in = request.getInputStream();
		byte[] bytes = new byte[512];
		int state = 0;
		ByteArrayOutputStream buffer = new ByteArrayOutputStream();
		String name = null, value = null, filename = null, contentType = null;
		HashMap mailData = new HashMap();

		int i = in.readLine(bytes, 0, 512);
		while (-1 != i) {
			String st = new String(bytes, 0, i);
			if (st.startsWith(boundary)) {
				state = 0;
				if (null != name) {
					if (value != null)
						// -2 to remove CR/LF
						mailData.put(name, value.substring(0, value.length() - 2));
					else if (buffer.size() > 2) {
						MimeBodyPart bodyPart = new MimeBodyPart();
						DataSource ds = new ByteArrayDataSource(buffer.toByteArray(), contentType, filename);
						bodyPart.setDataHandler(new DataHandler(ds));
						bodyPart.setDisposition("attachment; filename=\"" + filename + "\"");
						bodyPart.setFileName(filename);
						mailData.put(name, bodyPart);
					}
					name = null;
					value = null;
					filename = null;
					contentType = null;
					buffer = new ByteArrayOutputStream();
				}
			} else if (st.startsWith("Content-Disposition: form-data") && state == 0) {
				StringTokenizer tokenizer = new StringTokenizer(st, ";=\"");
				while (tokenizer.hasMoreTokens()) {
					String token = tokenizer.nextToken();
					if (token.startsWith(" name")) {
						name = tokenizer.nextToken();
						state = 2;
					} else if (token.startsWith(" filename")) {
						filename = tokenizer.nextToken();
						StringTokenizer ftokenizer = new StringTokenizer(filename, "\\/:");
						filename = ftokenizer.nextToken();
						while (ftokenizer.hasMoreTokens())
							filename = ftokenizer.nextToken();
						state = 1;
						break;
					}
				}
			} else if (st.startsWith("Content-Type") && state == 1) {
				pos = st.indexOf(":");
				// + 2 to remove the space
				// - 2 to remove CR/LF
				contentType = st.substring(pos + 2, st.length() - 2);
			} else if (st.equals("\r\n") && state == 1)
				state = 3;
			else if (st.equals("\r\n") && state == 2)
				state = 4;
			else if (state == 4)
				value = value == null ? st : value + st;
			else if (state == 3)
				buffer.write(bytes, 0, i);
			i = in.readLine(bytes, 0, 512);
		}
		return mailData;
	}

	 private void sendMail(HashMap mailData) throws MessagingException {
	        System.setProperty("mail.smtp.starttls.enable", "true"); // gmail은 무조건 true 고정
	        System.setProperty("mail.smtp.auth", "true"); // gmail은 무조건 true 고정
	        System.setProperty("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
	        System.setProperty("mail.smtp.port", "587"); // gmail 포트
	        //구글 인증
	        Authenticator auth = new MyAuthentication();
	        Message msg = new MimeMessage(Session.getDefaultInstance(System.getProperties(), auth));
	        //받는사람        
	        UserDAO userDAO = new UserDAO();
	        String recverNname = (String)mailData.get("selectMatch");
	        String to = userDAO.searchRecverEmail(recverNname);
	        if(to == "null"){
	        	EmailSend = 0;
	        	return;
	        	}
	        
	        InternetAddress[] tos = InternetAddress.parse(to+"@sungshin.ac.kr");
	        msg.setRecipients(Message.RecipientType.TO, tos);
	        //한글을 위한 인코딩
	        msg.setHeader("Content-Type", "text/plain; charset=UTF-8");
	        //제목
	        msg.setSubject("수정바다 유리병! by." + (String)mailData.get("user_nname") + " :: "+(String)mailData.get("subject"));
	        msg.setSentDate(new Date());
	 
	        //첨부파일이 없으면 내용만 전송
	        if(null == mailData.get("attachment")){
	                 msg.setText((String)mailData.get("body"));
	          } else {
	            //첨부파일이 있으면
	            BodyPart body = new MimeBodyPart();
	              BodyPart attachment = (BodyPart)mailData.get("attachment");
	              body.setText((String)mailData.get("body"));
	              MimeMultipart multipart = new MimeMultipart();
	              multipart.addBodyPart(body);
	              multipart.addBodyPart(attachment);
	              msg.setContent(multipart, "text/plain; charset=UTF-8");
	           }
	        //전송
	        Transport.send(msg);
	      
	        //데이터베이스에 보낸 메일 입력
	        int result = userDAO.mailInput((String)mailData.get("user_id"), to,(String)mailData.get("subject"),(String)mailData.get("body"));
			if(result != 0) {//db저장 실패 
				EmailSend = 2;
	        	return;
	        	}
	    }


	class MyAuthentication extends Authenticator {

		private PasswordAuthentication pa;
		private String id;
		private String pw;

		private MyAuthentication() {

			id = "sujeongbada@gmail.com"; 
			pw = "subaU123!"; 
			pa = new PasswordAuthentication(id, pw);
		}

		
		public PasswordAuthentication getPasswordAuthentication() {
			return pa;
		}
	}

}