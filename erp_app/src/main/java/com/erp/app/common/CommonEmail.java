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

	/** �ڹ� ���� �߼� 
	 * @throws MessagingException 
	 * @throws AddressException **/
	public void mailSender(MemberDTO member, String subject, String content) throws AddressException, MessagingException {
		
		// ���̹��� ��� smtp.naver.com �� �Է��մϴ�.
		// Google�� ��� smtp.gmail.com �� �Է��մϴ�.
		String host = "smtp.naver.com";
		
		final String username = "ljj02111";       //���̹� ���̵� �Է����ּ���. @nave.com�� �Է����� ���ñ���.
		final String password = "";   //���̹� �̸��� ��й�ȣ�� �Է����ּ���.
		int port=465; //��Ʈ��ȣ
		 
		// ���� ����
		String recipient = member.getEmail();    //�޴� ����� �����ּҸ� �Է����ּ���.
		 
		Properties props = System.getProperties(); // ������ ��� ���� ��ü ����
		 
		// SMTP ���� ���� ����
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		   
		//Session ����
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un=username;
			String pw=password;
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true); //for debug
		   
		MimeMessage mimeMessage = new MimeMessage(session); //MimeMessage ����
		try {
			mimeMessage.setFrom(new InternetAddress("ljj02111@naver.com", "My Tour"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} //�߽��� ���� , ������ ����� �̸����ּҸ� �ѹ� �� �Է��մϴ�. �̶��� �̸��� Ǯ �ּҸ� �� �ۼ����ּ���.
		
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //�����ڼ��� //.TO �ܿ� .CC(����) .BCC(��������) �� ����
		mimeMessage.setSubject(subject);  //�������
		mimeMessage.setContent(content, "text/html; charset=euc-kr");
		Transport.send(mimeMessage); //javax.mail.Transport.send() �̿�
		
	}

	// ȸ������
	public void signUpEmail(MemberDTO member) throws AddressException, MessagingException {

		String subject = member.getName() + ", Welcome to My Tour"; //���� ���� �Է����ּ���.
		
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


	// ��й�ȣ ã��
	public void findUserInfoEmail(MemberDTO member, String password) throws AddressException, MessagingException {

		String subject = member.getName() + "'s a temporary password has been issued"; //���� ���� �Է����ּ���.
		StringBuilder content = new StringBuilder();
		content.append("<html>");
		content.append("<body>");
		content.append("Hi. My Tour �Դϴ�.<br>");
		content.append("A temporary password has been issued at your request.<br>");
		content.append("A temporary password: " + password + "<br>");
		content.append("Please make sure to change your password after logging in with your temporary password.<br>");
		content.append("Thank you.<br>");
		content.append("</body>");
		content.append("</html>");
		
		mailSender(member, subject, content.toString());
	}
	
	
}
