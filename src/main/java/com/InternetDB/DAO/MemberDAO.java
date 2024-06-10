package com.InternetDB.DAO;

import java.sql.*;

public class MemberDAO {

    private static MemberDAO instance;
    MemberDAO(){}
    public static MemberDAO getInstance() {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }
    private Connection connection;
    private PreparedStatement statement;
    private ResultSet rs;


    public int checkId(String id) throws SQLException {
        String jdbcURL = "jdbc:mysql://localhost:3306/internetDB";
        String username = "internetdb";
        String password = "internetdb";

        String sql = "SELECT * FROM User WHERE user_id = ?";

        int idCheck = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, username, password);
            statement = connection.prepareStatement(sql);

            statement.setString(1, id);

            rs = statement.executeQuery();

            if(!rs.next() && !id.isEmpty())
                idCheck = 1;  // 존재하지 않는 경우, 생성 가능

        } catch (SQLException | ClassNotFoundException e ) {
            e.printStackTrace();
            throw new RuntimeException(e);

        } finally {
            close();
        }

        return idCheck;
    }

    public int checkNickname(String nickname) throws SQLException {
        String jdbcURL = "jdbc:mysql://localhost:3306/internetDB";
        String username = "internetdb";
        String password = "internetdb";

        String sql = "SELECT * FROM User WHERE nickname = ?";

        int nicknameCheck = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, username, password);
            statement = connection.prepareStatement(sql);

            statement.setString(1, nickname);

            rs = statement.executeQuery();

            if(!rs.next() && !nickname.equals(""))
                nicknameCheck = 1;  // 존재하지 않는 경우, 생성 가능

        } catch (SQLException | ClassNotFoundException e ) {
            e.printStackTrace();
            throw new RuntimeException(e);

        } finally {
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
