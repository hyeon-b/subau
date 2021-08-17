package mail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class JavaMailUtil {

	public static void sendMail(String recepient, String code) throws Exception {
		Properties properties = new Properties();

		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		
		final String myAccountEmail = "sujeongbada@gmail.com";
		final String password = "subaU123!";
		
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(myAccountEmail, password);
			}
		});
	
		Message message = prepareMessage(session, myAccountEmail, recepient, code);
		Transport.send(message);
		}
	
	private static Message prepareMessage(Session session, String myAccountEmail, String recepient, String code) {
		try {
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(myAccountEmail));
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
		message.setSubject("수정바다유리병 :: 회원가입 인증메일");
		message.setText("인증문구 : " + code);
		return message;
		} catch (Exception ex) {
			System.err.println("Exception이 발생했습니다.");
			}
		return null;
	}
}