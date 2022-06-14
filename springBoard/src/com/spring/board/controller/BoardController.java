package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.omg.CORBA.Object;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.dao.BoardDao;
import com.spring.board.dao.ComcodeDAO;
import com.spring.board.dao.UserDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;


@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	@Autowired
	BoardDao dao;
	@Autowired
	UserDao udao;
	@Autowired
	ComcodeDAO cdao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo,@RequestParam(value="sort",required=false) String[] sort ) throws Exception{
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}

		System.out.println(".............................pagepage"+pageVo.toString());
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt();
		
		System.out.println(".......................list11"+boardList);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("search", cdao.boardType());
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum, PageVo pageVo) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		int page = 1;
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		model.addAttribute("pageNo", page);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model, PageVo pageVo) throws Exception{
		int page = 1;
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		int totalCnt = boardService.selectBoardCnt();
		model.addAttribute("totalCnt",totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("boardType",cdao.boardType());
		System.out.println(cdao.boardType());
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(
			Locale locale,
			BoardVo boardVo
			) throws Exception{
		
		int resultCnt=0; 
		
		HashMap<String, String> result = new HashMap<String, String>();

		int size = boardVo.getBoardVoList().size();
		System.out.println("................ListSize"+size);
//		for(int i = 0; i< boardTitle.length; i++){
//			String title = boardTitle[i];
//			System.out.println("...........................vovo22"+boardTitle);
//			String comment = boardComment[i];
//			String type = boardType[i];
//			boardVo.setBoardTitle(title);
//			boardVo.setBoardComment(comment);
//			boardVo.setBoardType(type);
		System.out.println(boardVo.getBoardVoList().get(0).getBoardType());
		System.out.println(boardVo.getBoardVoList().get(0).getBoardTitle());
		System.out.println(boardVo.getBoardVoList().get(0).getCreator());
		resultCnt = boardService.boardInsert(boardVo);
			
//		}

		System.out.println("...........................vovo33"+boardVo);
		CommonUtil commonUtil = new CommonUtil();
		
		
		
		System.out.println("resultcnt:"+ resultCnt);
		result.put("success", (resultCnt > 0)?"Y":"N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg:"+callbackMsg);
		
		return callbackMsg;
	}
	

	@RequestMapping(value="/board/boardUpdate.do", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> boardUpdate(BoardVo vo) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt=0; 
		resultCnt = boardService.boardUpdate(vo);
		result.put("success", (resultCnt > 0)?"Y":"N");
		//String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		return result;
	}
	@RequestMapping(value="/board/boardDelete.do", method= RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> boardDelete(String boardType, int boardNum) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt=0; 
		resultCnt = boardService.boardDelete(boardType, boardNum);
		result.put("success", (resultCnt > 0)?"완료":"실패");
		//String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		return result;
	}
	@RequestMapping(value="/board/checkDelete.do", method= RequestMethod.POST)
	@ResponseBody
	public int checkDelete(String boardType, int boardNum){
		int check=dao.checkDelete(boardType, boardNum);
		return check;
		}
		
	@RequestMapping(value = "/board/adduser.do", method = RequestMethod.GET)
	public String adduser(Model model){
		return "board/adduser";
	}
	@RequestMapping(value = "/board/chkUser.do", method = RequestMethod.POST)
	@ResponseBody
	public int chkUser(String id){
		return udao.chkUser(id);
	}
}
