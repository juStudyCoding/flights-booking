package com.erp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.erp.app.common.CommonEmail;
import com.erp.app.dao.HomeDao;
import com.erp.app.dto.MemberDTO;
import com.erp.app.dto.TourDTO;

@Service
public class HomeService {

	@Autowired
	private HomeDao homeDao;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private CommonEmail commonEmail;

	// 로그인
	public Map<Object, Object> SelectMember(MemberDTO member) {

		String checkLogin = "";
		
		MemberDTO result = homeDao.SelectMember(member);	

		// 일치하는 계정이 없을 시 null로 return
		if(result == null) {
			checkLogin = "User ID 또는 Password를 다시 확인하세요.";
		}
		//naver로 로그인했는지 체크
		/*else if(result.getJoin_Type().equals("NAVER")) {
			request.getSession().setAttribute("LoginInfo", result);
			homeDao.updateLastLogin(member); 
		}*/
		// 이메일 인증을 거치지 않은 사용자
		else if(result.getApproval().equals("F")) {
			checkLogin = "인증이 필요한 User ID 입니다.";
		}
		// 로그인 성공
		else {
			request.getSession().setAttribute("LoginInfo", result);
			
			// 마지막 로그인 시간 update
			homeDao.updateLastLogin(member); 
		}
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("result", checkLogin);
		
		return map;
	}
	
	//비밀번호 찾기
	public Map<Object, Object> findUserInfo(MemberDTO member) {

		boolean checkLogin = false;
		
		MemberDTO result = homeDao.SelectMember(member);

		// 일치하는 계정이 없을 시 false로 return
		if(result == null) {
			checkLogin = false;
		}
		else {
			
			// 임시 비밀번호 생성
			char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7',
					'8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 
					'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
					'U', 'V', 'W', 'X', 'Y', 'Z' };

			  int idx = 0;
			  StringBuffer sb = new StringBuffer();
			  
			  for (int i = 0; i < 8; i++) {
				
				  idx = (int) (charSet.length * Math.random()); //  36 * 생성된 난수를  Int로 추출 (소숫점제거)
				  sb.append(charSet[idx]);
			  }
			  
			  // 임시 비밀번호 update
			  result.setPassword(sb.toString());
			  homeDao.updatePassword(result); 
			  
			  // 이메일 전송
			  try {
					commonEmail.findUserInfoEmail(result, sb.toString());
			  } catch (MessagingException e) {
					e.printStackTrace();
			  }

			  checkLogin = true;
		}

		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("result", checkLogin);
		return map;
	}
	
	
	//naver 이메일 정보 체크
	public MemberDTO selectNaverInfo(MemberDTO member){
		MemberDTO result = homeDao.selectNaverInfo(member);
		return result;
	}

	//naver 정보로 자동 회원가입
	public int insertNaverInfo(MemberDTO member){
		return homeDao.insertNaverInfo(member);
	}
}
