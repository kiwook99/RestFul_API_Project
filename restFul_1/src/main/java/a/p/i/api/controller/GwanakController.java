package a.p.i.api.controller;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class GwanakController {
	Logger logger = LogManager.getLogger(GwanakController.class);
	
	@GetMapping("gwanak")
    public ModelAndView pythonScript() {
	        ModelAndView mav = new ModelAndView();

	        try {
	            URL url = new URL("http://127.0.0.1:5001/gw2/people");
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("GET");
	            
	            // 이미지 데이터를 읽어옴
	            InputStream inputStream = conn.getInputStream();
	            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

	            byte[] buffer = new byte[1024];
	            int bytesRead;
	            while ((bytesRead = inputStream.read(buffer)) != -1) {
	                outputStream.write(buffer, 0, bytesRead);
	            }

	            byte[] imageData = outputStream.toByteArray();

	            // 이미지 데이터를 Base64로 인코딩하여 문자열로 변환
	            String base64Image = Base64.getEncoder().encodeToString(imageData);

	            // JSP로 전달
	            mav.addObject("imageData", base64Image);
	            mav.setViewName("gwanakPage");
	        } catch (Exception e) {
	            e.printStackTrace();
	            mav.addObject("error", "이미지를 가져오는 동안 오류 발생");
	            mav.setViewName("error");
	        }

	        return mav;
	    }
	

	@GetMapping("parking")
	public String parking() {
		logger.info("parking 컨트롤러 진입>>> : ");

        return "gwanakParking";
	}
	
	@GetMapping("school")
	public String school() {
		
		return "gwanakSchool";
	}
	
	@GetMapping("test")
	public String test() {
		
		return "test";
	}
}
