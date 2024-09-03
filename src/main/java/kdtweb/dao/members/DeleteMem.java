package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kdtweb.beans.User;
import kdtweb.dao.KdtwebDao;

public class DeleteMem {

	// 필드로 접속객체를 생성
	private KdtwebDao dao = new KdtwebDao();
	private CloseResource reso = new CloseResource();
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
}
