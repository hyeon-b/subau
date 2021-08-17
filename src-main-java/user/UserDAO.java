package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

public class UserDAO {
	
	private String user_nname = "null";
	
	private Connection conn;
	private PreparedStatement pstmt;
	
	private int urs;
	
	private ResultSet rs;

public UserDAO() {
		
		
		try{
			String dbURL = "jdbc:mysql://localhost:3306/subau";
			String dbID ="root";
			String dbPassword = "vmfhwprxm3!";
		Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
	}catch(Exception e) {
		e.printStackTrace();
	}
}
public int login (String user_id, String user_pwd) {
	String SQL = "SELECT user_pwd,user_nname FROM USERTBL WHERE user_id= ?";
	try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(user_pwd)) {
					user_nname = rs.getString("user_nname");
					return 1;
				}
				else
					return 0;
			}
			return -1;
	}catch(Exception e) {
		e.printStackTrace();
	}
	return -2;
}


public String searchRecverEmail (String user_nname) {
	String SQL = "SELECT user_id FROM USERTBL WHERE user_nname= ?";
	try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_nname);
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				return rs.getString("user_id");
			}
	}catch(Exception e) {
		e.printStackTrace();
	}
	return "null";
}


public int mailInput(String sender, String recver, String subject, String content) {   //전송한 메일 데이터 베이스에 입력
    String SQL = "INSERT INTO MAILTBL(sender, recver, subject, content, sndtime) VALUES( ?, ?, ?, ?, default);";
    try {
          pstmt = conn.prepareStatement(SQL);
          pstmt.setString(1, sender);
          pstmt.setString(2, recver);
          pstmt.setString(3, subject);
          pstmt.setString(4, content);
      
          urs = pstmt.executeUpdate();
          
          if(urs == 1) {
             return 0;
          }
          return -1;
    }catch(SQLException e) {
       e.printStackTrace();
    }
    return -2;
 }

public String getNickName () {
	return user_nname;
}

public int signUp(String user_id, String user_nname, String user_pwd) {   //회원가입
    String SQL = "INSERT INTO USERTBL(user_id, user_nname, user_pwd) VALUES( ?, ?, ? );";
    try {
          pstmt = conn.prepareStatement(SQL);
          pstmt.setString(1, user_id);
          pstmt.setString(2, user_nname);
          pstmt.setString(3, user_pwd);
          urs = pstmt.executeUpdate();
          
          if(urs == 1) {
             return 0;
          }
          return -1;
    }catch(SQLException e) {
       e.printStackTrace();
    }
    return -2;
 }


public int idCheck(String user_id) {
    String SQL = "SELECT count(*) FROM usertbl WHERE user_id = ?";
    try {
       int result = 0;      //초기화. 그대로 0이면 id 없음
       pstmt = conn.prepareStatement(SQL);
       pstmt.setString(1, user_id);
       rs = pstmt.executeQuery();
       rs.next();
       result = rs.getInt(1); 
       
       return result;      //0이 아니면 이미 id 존재
    } catch(SQLException e) {
       e.printStackTrace();
    }
    return -2;
 }

public int nnameCheck(String nname) {   //별명 중복 체크
    String SQL = "SELECT count(*) FROM usertbl WHERE user_nname = ?;";
    try {
       int result = 0;
       pstmt = conn.prepareStatement(SQL);
       pstmt.setString(1, nname);
       rs = pstmt.executeQuery();
       rs.next();
       result = rs.getInt(1); 
       
       return result;
    }catch(SQLException e) {
       e.printStackTrace();
    }
    return -2;
 }


 public String[] searchMatch(String userId) {
	    String[] matches = new String[5];
	    int i = 0;
	    String SQL = "SELECT usertbl.user_nname FROM matchtbl join usertbl on matchtbl.match1=usertbl.user_id WHERE matchtbl.user_id= ?"
	          + "UNION SELECT usertbl.user_nname FROM matchtbl JOIN usertbl ON matchtbl.match2=usertbl.user_id WHERE matchtbl.user_id= ?"
	          + "UNION SELECT usertbl.user_nname FROM matchtbl join usertbl on matchtbl.match3=usertbl.user_id WHERE matchtbl.user_id= ?"
	          + "UNION SELECT usertbl.user_nname FROM matchtbl join usertbl on matchtbl.match4=usertbl.user_id WHERE matchtbl.user_id= ?"
	          + "UNION SELECT usertbl.user_nname FROM matchtbl join usertbl on matchtbl.match5=usertbl.user_id WHERE matchtbl.user_id= ?"
	          + ";";
	    try {
	       pstmt = conn.prepareStatement(SQL);
	       pstmt.setString(1, userId);
	       pstmt.setString(2, userId);
	       pstmt.setString(3, userId);
	       pstmt.setString(4, userId);
	       pstmt.setString(5, userId);
	       rs = pstmt.executeQuery();
	       
	       while(rs.next()) {
	          matches[i] = rs.getString(1);
	          i++;
	       }
	    }catch(SQLException e) {
	       e.printStackTrace();
	    }
	    return matches;
	 }


public int matching(String userId) {
    String SQL = "CALL matching(?);";
    try {
       pstmt = conn.prepareStatement(SQL);
       pstmt.setString(1, userId);
       rs = pstmt.executeQuery();
       return 0;   //매칭 성공
    }catch(SQLException e) {   //매칭할 사람이 없으면 matchreq true로 고치고 return
       String SQLL = "UPDATE usertbl SET user_matchreq = true WHERE user_id = ?";
       try {
          pstmt = conn.prepareStatement(SQLL);
          pstmt.setString(1,  userId);
           pstmt.executeUpdate();
          
       }catch(SQLException e1) {
          e.printStackTrace();
       }
       return -1;   //매칭 대기 필요
    }
 }


public int changePwd(String userId, String chPwd) {
    String SQL = "UPDATE usertbl SET user_pwd=? WHERE user_id=?;";
    try {
       pstmt = conn.prepareStatement(SQL);
       pstmt.setString(1, chPwd);
       pstmt.setString(2, userId);

       urs = pstmt.executeUpdate();
       while(urs == 1) {   //성공하면 1 return
          return 0;
       }
       return -1;   //실패하면 -1 return
    }catch(SQLException e) {
       e.printStackTrace();
    }
    return -2;   //에러나면 -2 return
 }   
 
 public int changePwdByUser(String userId, String origPwd, String chPwd) {
    String SQL = "UPDATE usertbl SET user_pwd=? WHERE user_id=? and user_pwd = ?;";
    try {
       pstmt = conn.prepareStatement(SQL);
       pstmt.setString(1, chPwd);
       pstmt.setString(2, userId);
       pstmt.setString(3, origPwd);

       urs = pstmt.executeUpdate();
       while(urs == 1) {   //성공하면 1 return
          return 0;
       }
       return -1;   //실패하면 -1 return
    }catch(SQLException e) {
       e.printStackTrace();
    }
    return -2;   //에러나면 -2 return
 } 
 
 public int deleteUser(String userId) {
     String SQL = "call deleteUser(?)";
     try {
        pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, userId);

        urs = pstmt.executeUpdate();
        return 0;   //성공하면 0리턴

     }catch(SQLException e) {
        e.printStackTrace();
     }
     return -2;   //에러나면 -2 return
  }

}
 