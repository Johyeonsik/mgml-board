package com.spring.board.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("daoimpl"+boardVo);
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int boardUpdate(BoardVo vo) {
		return sqlSession.update("board.boardUpdate", vo);
		
	}
	@Override
	public int boardDelete(String boardType, int boardNum) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("boardType", boardType);
		map.put("boardNum", boardNum);
		return sqlSession.delete("board.boardDelete", map);
		
	}
	@Override
	public int checkDelete(String boardType, int boardNum) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("boardType", boardType);
		map.put("boardNum", boardNum);
		return sqlSession.selectOne("board.checkDelete",map);
	}
	
	
}
