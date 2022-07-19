package kr.co.alto.hobby.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import kr.co.alto.hobby.dto.HobbyDTO;
import kr.co.alto.hobby.dto.HobbysubDTO;
import kr.co.alto.hobby.service.HobbyService;


@Controller("hobbyController")
public class HobbyControllerImpl extends MultiActionController implements HobbyController {
	
	@Autowired
	private HobbyService hobbyService;

	@Override
	@RequestMapping(value = "/member/memHobby.do", method = RequestMethod.GET)
	public ModelAndView listHobbys(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		List<HobbyDTO> hobbyList = hobbyService.listHobbys();
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("hobbyList", hobbyList);
		
		return mav;
	}
	

	@Override
	@RequestMapping(value = "/member/memHobby_sub.do", method = RequestMethod.POST)
	public ModelAndView listHobbySub(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		
		String hobbyCodeList = request.getParameter("hobbyCodeList");
		String[] arrhcodelist = hobbyCodeList.split(",");
		HashMap<String, String> codeList = new HashMap<String, String>();
		
		codeList.put("code1", arrhcodelist[0]);
		codeList.put("code2", arrhcodelist[1]);
		codeList.put("code3", arrhcodelist[2]);
		codeList.put("code4", arrhcodelist[3]);
		codeList.put("code5", arrhcodelist[4]);
		
		
		List<HobbysubDTO> hobbysublist = hobbyService.listHobbysub(codeList);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("hobbysublist", hobbysublist);
		return mav;
	}

	
	
	@RequestMapping(value="/select/hobbysub.do", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<List<HobbysubDTO>> ajaxhobbysub(String main_code) throws Exception {
		
		System.out.println(main_code+"테스트");
		ResponseEntity<List<HobbysubDTO>> entity = null;
		try{
			List<HobbysubDTO> list= hobbyService.listHobbysub2(main_code);
			entity = new ResponseEntity<List<HobbysubDTO>>(list, HttpStatus.OK);
			System.out.println(entity+"테스트");
		}catch(Exception e){
			e.printStackTrace();	
		}
		
		return entity;
		
	}

}
