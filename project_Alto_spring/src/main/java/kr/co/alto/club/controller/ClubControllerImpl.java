package kr.co.alto.club.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.alto.club.dto.ClubDTO;
import kr.co.alto.club.service.ClubService;
import kr.co.alto.common.base.BaseController;
import kr.co.alto.member.dto.MemberDTO;
import kr.co.alto.mypage.dto.likeDTO;
import kr.co.alto.mypage.service.MypageService;

@Controller("clubController")
@RequestMapping("/club")
public class ClubControllerImpl extends BaseController implements ClubController {
	
	private static final Logger logger = LoggerFactory.getLogger(ClubController.class);
	
	@Autowired
	private ClubService clubService;
	@Autowired
	private MypageService mypageService;
	@Autowired
	private ClubDTO clubDTO;
	
	@RequestMapping(value = "/clubInformation.do", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView clubInfo(@RequestParam(value="club_code", required = false) String club_code, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();		
		String viewName = (String)request.getAttribute("viewName");
		
		ClubDTO clubInfo = clubService.selectClubInfo(club_code);
		
		mav.addObject("clubInfo", clubInfo);
		mav.setViewName(viewName);
		
		return mav;
	}	
	
	@Override
	@RequestMapping(value = "/clubMain.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView clubMain(HttpServletRequest request, HttpSession httpSession) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		
		Map<String, Object> clubMainMap = new HashMap<>();
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("login");
		String mem_id = "";
		if (memberDTO != null) {
			mem_id = memberDTO.getMem_id();
		}
		
		clubMainMap = clubService.clubMainList(mem_id);
		
		mav.addObject("clubMainMap", clubMainMap);
		mav.setViewName(viewName);
		
		return mav;
	}
	
	@Override
	@RequestMapping(value = "/clubSearchList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView clubSearhList(@RequestParam(value="hobbyC", required = false) String hobbyC, HttpServletRequest request, HttpSession httpSession) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		Map<String, Object> clubSearchMap = new HashMap<>();
		
		//로그인 상태인 경우 관심목록 가져오기
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("login");
		if (memberDTO != null) {
			String mem_id = memberDTO.getMem_id();
			List<likeDTO> memlikeList = new ArrayList<>();
			memlikeList = mypageService.selectLikeList(mem_id);
			
			mav.addObject("memlikeList", memlikeList);
		}		
		
		if(hobbyC != null) {
			clubSearchMap = clubService.selectHobClubList(hobbyC);
			
			mav.addObject("hobbyC", hobbyC);
			mav.addObject("clubSearchMap", clubSearchMap);
		}else {
			clubSearchMap = clubService.clubSearchList();
			
			mav.addObject("clubSearchMap", clubSearchMap);
		}
						
		mav.setViewName(viewName);
		return mav;
	}
	

	@Override
	@RequestMapping(value = "/clubRegister.do", method = RequestMethod.POST)
	public ResponseEntity clubRegister(@ModelAttribute("club") ClubDTO clubDTO,  HttpServletRequest request, HttpSession httpSession) throws Exception {
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type","text/html; charset=utf-8");
		
		String message;
		ResponseEntity resEnt = null;
		
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("login");
		String manager = memberDTO.getMem_id();
		
		clubDTO.setManager(manager);	
		
		try {	
			clubService.clubOpen(clubDTO);			
			
			message = "<script>";
			message += " alert('모임 개설 완료');";
			message += " location.href='"+request.getContextPath()+"/club/clubInformation.do?club_code=';";
			message += "</script>";
			
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
		} catch (Exception e) {
			message = "<script>";
			message += " alert('오류가 발생했습니다. 다시 시도해 주세요.');";
			message += " location.href='"+request.getContextPath()+"/club/clubSearchList.do';";
			message += "</script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			
			e.printStackTrace();
		}
				
		return resEnt;
	}

}
