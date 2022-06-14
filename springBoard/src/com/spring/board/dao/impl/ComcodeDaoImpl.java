package com.spring.board.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.dao.ComcodeDAO;
import com.spring.board.dao.UserDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComcodeVO;
import com.spring.board.vo.PageVo;

@Repository
public class ComcodeDaoImpl implements ComcodeDAO{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ComcodeVO> boardType() {
		return sqlSession.selectList("comcode.boardType");
	}




}
