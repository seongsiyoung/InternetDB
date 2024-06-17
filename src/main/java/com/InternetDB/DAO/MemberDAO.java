package com.InternetDB.DAO;

import java.sql.*;

public class MemberDAO {

    //외부에서 MemberDAO를 생성할 수 없도록 싱글톤 설계
    private static MemberDAO instance;
    private MemberDAO(){}
    public static MemberDAO getInstance() {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }
    private Connection connection;
    private PreparedStatement statement;
    private ResultSet rs;

    String jdbcURL = "jdbc:mysql://localhost:3306/internetDB";
    String username = "internetdb";
    String password = "internetdb";


    public int checkId(String id) throws SQLException {


        //중복된 아이디가 있는지 검색
        String sql = "SELECT * FROM User WHERE user_id = ?";

        int idCheck = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, username, password);
            statement = connection.prepareStatement(sql);

            statement.setString(1, id);

            rs = statement.executeQuery();

            // 중복된 아이디가 존재하지 않는 경우, 생성 가능
            if(!rs.next() && !id.isEmpty())
                idCheck = 1;

        } catch (SQLException | ClassNotFoundException e ) {
            e.printStackTrace();
            throw new RuntimeException(e);

        } finally {
            //종료 메소드 호출
            close();
        }

        return idCheck;
    }

    public int checkNickname(String userId, String nickname) throws SQLException {

        //중복된 닉네임이 있는지 검색
        String sql = "SELECT * FROM User WHERE nickname = ?";

        int nicknameCheck = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, username, password);
            statement = connection.prepareStatement(sql);

            statement.setString(1, nickname);

            rs = statement.executeQuery();

            // 중복된 닉네임이 존재하지 않는 경우, 생성 가능
            if((!rs.next() || rs.getString("user_id").equals(userId)) && !nickname.equals("") )
                nicknameCheck = 1;

        } catch (SQLException | ClassNotFoundException e ) {
            e.printStackTrace();
            throw new RuntimeException(e);

        } finally {
            //종료 메소드 호출
            close();
        }

        return nicknameCheck;
    }

    private void close() throws SQLException{
        if(statement != null)
            statement.close();
        if(rs != null)
            rs.close();
        if(connection != null)
            connection.close();
    }

}
