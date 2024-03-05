package a.p.i.api.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class IncheonController {
	Logger logger = LogManager.getLogger(IncheonController.class);
	
	@GetMapping("incheon")
	public String loginForm() {
		logger.info("incheon() 함수 진입");
		return "incheon_main";
	}
	
	@GetMapping("incheon_parking")
	public String parking() {
		logger.info("parking() 함수 진입");
		return "parking";
	}
	
	@GetMapping("incheon_books")
	public String books() {
		logger.info("books() 함수 진입");
		return "books";
	}
	
	@GetMapping("incheon_bus")
	public String bus() {
		logger.info("bus() 함수 진입");
		return "bus";
	}
}