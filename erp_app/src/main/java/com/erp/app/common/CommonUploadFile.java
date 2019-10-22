package com.erp.app.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.erp.app.dto.MemberDTO;

/**
 * Common
 */
@Service
public class CommonUploadFile {

	  // 리눅스 기준으로 파일 경로를 작성 ( 루트 경로인 /으로 시작한다. )
	  // 윈도우라면 workspace의 드라이브를 파악하여 JVM이 알아서 처리해준다.
	  // 따라서 workspace가 C드라이브에 있다면 C드라이브에 upload 폴더를 생성해 놓아야 한다.
	  private static final String PREFIX_URL = "/akiid18/tomcat/webapps/upload/profile/";
	   
	  public void restore(HttpServletRequest request, MemberDTO member) {

	    try {
	    	
	      File file = new File(PREFIX_URL + member.getNo() + ".jpg"); 
	      
	      if(file.exists()) 
	      { 
	    	  file.delete();
	      } 

	      // 파일 정보
	      String originFilename = member.getFileUpload().getOriginalFilename();
	      String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());

	      //서버에서 저장 할 파일 이름
	      String saveFileName = member.getNo() + extName;
	       
	      writeFile(request, member.getFileUpload(), saveFileName);
	    }
	    catch (IOException e) {
	    	// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
		    // 편의상 RuntimeException을 던진다.
		    // throw new FileUploadException(); 
	      throw new RuntimeException(e);
	    }
	  }
	  
	   
	  // 파일을 실제로 write 하는 메서드
	  private boolean writeFile(HttpServletRequest request, MultipartFile multipartFile, String saveFileName) throws IOException
	  {
	    boolean result = false;
	 
	    byte[] data = multipartFile.getBytes();
	    FileOutputStream fos = new FileOutputStream(PREFIX_URL + saveFileName);
	    fos.write(data);
	    fos.close();
	     
	    return result;
	  }

	  
}
