package a.p.i.api.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

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
public class Songpa_Controller {
	
	Logger logger = LogManager.getLogger(Songpa_Controller.class);


	//@RequestMapping("parking")
	@GetMapping("songpa_parking")
	public String parkingForm(Model model) {
		logger.info("Flask_Rss_Controller parkingForm 진입 >>> : ");
		
		return "songpa_parking";
	}

	
	@GetMapping("songpa_news")
	public String newsForm(Model model) {
		logger.info("Flask_Rss_Controller newsForm 진입 >>> : ");
		
		return "songpa_news";
	}	
	
	
	@GetMapping("songpa_api_all")
	public String api() {
		logger.info("Flask_Rss_Controller api 진입 >>> : ");

		return "songpa_api_all";
	}	

	
	@GetMapping("songpa_instagram")
	public String instagram() {
		logger.info("Flask_Rss_Controller instagram 진입 >>> : ");
	
		return "songpa_instagram";
	}	
	
	@GetMapping("songpa_slack")
	public String slack() {
		logger.info("Flask_Rss_Controller slack 진입 >>> : ");
	
		return "songpa_slack";
	}		
	
	
	@GetMapping("songpa_notion")
	public String notion() {
		logger.info("Flask_Rss_Controller notion 진입 >>> : ");
	
		return "songpa_notion";
	}
	
	@GetMapping("songpa_github")
	public String github() {
		logger.info("Flask_Rss_Controller github 진입 >>> : ");
	
		return "songpa_github";
	}
}
	