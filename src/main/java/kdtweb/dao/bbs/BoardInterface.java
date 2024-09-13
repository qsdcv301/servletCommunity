package kdtweb.dao.bbs;

import java.sql.SQLException;
import java.util.ArrayList;

import kdtweb.beans.BoardDto;

public interface BoardInterface {
  
	int insertBoard(BoardDto bbs) throws SQLException;
	int updateBoard(BoardDto bbs) throws SQLException;
	int updateCount(long num) throws SQLException;  //카운트 업데이트 updateBoard()메소드 오버로드
	int deleteBoard(long num) throws SQLException;
	int getTotalBoardCount() throws SQLException; //전체 개시글 수를 가져옴
	ArrayList<BoardDto> listBoard(int limit, int recordsPerPage) throws SQLException; 
	BoardDto viewBoard(long num) throws SQLException;
	int selectUserId(String userid, int num) throws SQLException;
	int isPass(long num, String pass) throws SQLException;
	int getSearchBoardCount(String searchKey, String searchVal) throws SQLException;
	ArrayList<BoardDto> listSearchBoard(String searchKey, String searchVal, int limit, int recordsPerPage) throws SQLException; 
}
