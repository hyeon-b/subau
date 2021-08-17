package com.subau.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.subau.service.MailBoxService;


@Controller
@RequestMapping("/subau/*")
public class SubauController {
	
	private static final Logger log = LoggerFactory.getLogger(SubauController.class);
    @Autowired
    private MailBoxService mservice;

    
    /*로그인/로그아웃 제어*/
    @RequestMapping(value = "/login")
	public void loginGET() {
		log.info("로그인 페이지 진입");	
	}
    
	@RequestMapping(value="/loginAction" )
    public void login() {
        log.info("로그인작동");
    }
	 
	@RequestMapping(value = "/logout")
	public void logoutGET() {
		log.info("로그아웃 페이지 진입");	
	}
    
	
	/*회원가입 제어*/
	@RequestMapping(value = "/signUp" )
	public void signUp() {
		log.info("회원가입 페이지 접근");	
	}
	
	
	@RequestMapping(value = "/sendMail")
	public void sendMail() {
		log.info("인증 메일 전송");	
	}
	
	@RequestMapping(value = "/signUpNnameCheck")
	public void nnameCheck() {
		log.info("닉네임 중복 검사");	
	}
	

	   
	/*메인/소개 페이지 제어*/
	 @RequestMapping(value = "/welcome")
		public void welcomeGET() {
			log.info("환영 페이지 진입");
		}

	 @RequestMapping(value = "/introduction")
		public void introGET() {
			log.info("소개 페이지 진입");
		}
	 
	 
	 
	 /*받은메일함 제어*/
	 @RequestMapping(value="/list")
	    public void mailBoxListGET(Model model, HttpServletRequest request) {   
		 log.info("게시판 목록 페이지 진입");
	        
	     HttpSession session = request.getSession();
	     String recver = (String)session.getAttribute("user_id");
	     
	     	
	     model.addAttribute("list", mservice.getList(recver));
	    }
	 

	 
	 
	 /*매칭 제어*/
	 @RequestMapping(value="/matching")
	    public void matching(Model model) {   
		 log.info("매칭신청");
	    }

	 @ResponseBody
	 @RequestMapping(value="/unmatching", method=RequestMethod.POST)
	 public String matchDel(@RequestParam(value="unmatching[]") List<String> unmatching, HttpServletRequest request, RedirectAttributes rttr) {
		 HttpSession session = request.getSession();
	     String recver = (String)session.getAttribute("user_id");
		 for(int i=0; i<unmatching.size(); i++) {
			 mservice.matchDel(recver, unmatching.get(i));
		 }
		 
		 rttr.addFlashAttribute("result", "unmatching : success");
		 
		 return "redirect:/mailBox/list";
		 
	 }
	 
	 
	 /*비밀번호 관련 페이지 제어*/
	 @RequestMapping(value = "/pwdChange")
	public void pwdChange() {
		 log.info("비밀번호 변경 페이지 진입");	
	}
	 
	 @RequestMapping(value="/pwdSearch" )
	 public void pwdSearch(Model model,HttpServletRequest request ) {
		 log.info("비밀번호 찾기 페이지 진입");
	 }
	 
	 @RequestMapping(value="/changepwd" )
	 public void changePwd() {
		 log.info("비밀번호 변경 페이지 진입");
	 }
		
	 @RequestMapping(value="/pwdSearchSendMail" )
	 public void pwdSearchSendMail() {
		 log.info("비밀번호 찾기 인증 메일 페이지 진입");
	 }
	 
	 @RequestMapping(value="/sendTempPwd" )
	 public void sendTempPwd() {
		 log.info("비밀번호 찾기 인증번호 확인");
	 }
	 
	 
		
	@RequestMapping(value = "/write")
	public void write() {
		log.info("글 작성 페이지 진입");	
		}
	    

	@RequestMapping(value = "/byebye")
	public void bye() {
		log.info("회원탈퇴");	
		}
	 
}


