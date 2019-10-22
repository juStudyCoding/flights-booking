package com.erp.app.common;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.stereotype.Service;
import com.erp.app.dto.MemberDTO;

/**
 * Common
 */
@Service
public class CommonEmail {

	/** 자바 메일 발송 
	 * @throws MessagingException 
	 * @throws AddressException **/
	public void mailSender(MemberDTO member, String subject, String content) throws AddressException, MessagingException {
		
		// 네이버일 경우 smtp.naver.com 을 입력합니다.
		// Google일 경우 smtp.gmail.com 을 입력합니다.
		String host = "smtp.naver.com";
		
		final String username = "ljj02111";       //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요.
		final String password = "";   //네이버 이메일 비밀번호를 입력해주세요.
		int port=465; //포트번호
		 
		// 메일 내용
		String recipient = member.getEmail();    //받는 사람의 메일주소를 입력해주세요.
		 
		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성
		 
		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		   
		//Session 생성
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un=username;
			String pw=password;
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true); //for debug
		   
		MimeMessage mimeMessage = new MimeMessage(session); //MimeMessage 생성
		try {
			mimeMessage.setFrom(new InternetAddress("ljj02111@naver.com", "My Tour"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요.
		
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
		mimeMessage.setSubject(subject);  //제목셋팅
		mimeMessage.setContent(content, "text/html; charset=euc-kr");
		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
		
	}

	// 회원가입
	public void signUpEmail(MemberDTO member) throws AddressException, MessagingException {

		String subject = member.getName() + ", Welcome to My Tour"; //메일 제목 입력해주세요.
		
		StringBuilder content = new StringBuilder();
		content.append("<html>");
		content.append("<body>");
		content.append("Hi. We are My Tour.<br>");
		content.append(member.getName() + ", Congratulations on your membership!<br>");
		content.append("Authentication is required<br>");
		content.append("Click the following link to activate account <br>");
		content.append("<a href='http://localhost:8080/ex/MemberConfirm?No=" + member.getNo() + "'>");
		content.append("Click Link!</a>");
		content.append("</body>");
		content.append("</html>");

		mailSender(member, subject, content.toString());
	}


	// 비밀번호 찾기
	public void findUserInfoEmail(MemberDTO member, String password) throws AddressException, MessagingException {

		String subject = member.getName() + "'s a temporary password has been issued"; //메일 제목 입력해주세요.
		StringBuilder content = new StringBuilder();
		content.append("<html>");
		content.append("<body>");
		content.append("Hi. My Tour 입니다.<br>");
		content.append("A temporary password has been issued at your request.<br>");
		content.append("A temporary password: " + password + "<br>");
		content.append("Please make sure to change your password after logging in with your temporary password.<br>");
		content.append("Thank you.<br>");
		content.append("</body>");
		content.append("</html>");
		
		mailSender(member, subject, content.toString());
	}
	
	
}
