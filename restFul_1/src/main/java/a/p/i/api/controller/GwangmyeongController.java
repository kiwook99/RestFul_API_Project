package a.p.i.api.controller;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class GwangmyeongController {
	Logger logger = LogManager.getLogger(Controller.class);
	
	
	@GetMapping("Gwangmyeong")
    public ModelAndView pythonScript() {
	        ModelAndView mav = new ModelAndView();

	        try {
	            URL url = new URL("http://127.0.0.1:5001/gwangmyeong_weather/gwangmyeong_weather");
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
	            mav.setViewName("gwangmyeongPage");
	        } catch (Exception e) {
	            e.printStackTrace();
	            mav.addObject("error", "이미지를 가져오는 동안 오류 발생");
	            mav.setViewName("error");
	        }

	        return mav;
	    }
	
	@GetMapping("Gwangmyeong_school")
	public String school() {
		
		return "gmSchool";
	}
	
	@GetMapping("Gwangmyeong_parking")
	public String parking() {
		
		return "gmParking";
	}
	
	@GetMapping("Gwangmyeong_test")
	public String test() {
		
		return "test";
	}
}
