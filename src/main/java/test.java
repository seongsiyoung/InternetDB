import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class test {

    public static void main(String[] args){


        String jdbcURL = "jdbc:mysql://localhost:3306/internetDB";
        String username = "internetdb";
        String password = "internetdb";

        //만약 날짜를 삽입한다면,
        LocalDateTime localDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = localDateTime.format(formatter);


        String sql = "INSERT INTO REPLY (content, lost_id, user_id, createdAt) VALUES (?,?,?,?)";


        try {
            Connection connection = DriverManager.getConnection(jdbcURL, username, password);
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs;

            statement.setString(1, "testCONTENT");
            statement.setString(2, String.valueOf(1L));
            statement.setString(3, "loginId1");
            statement.setString(4, formattedDateTime);

            int rows = statement.executeUpdate();

            if (rows > 0) {
                System.out.println("Test data inserted.");
            }

            sql = "SELECT * FROM REPLY WHERE reply_id = ? ";

            statement = connection.prepareStatement(sql);
            statement.setString(1,"1");

            rs = statement.executeQuery();

            while (rs.next()) {
                System.out.println(rs.getLong(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3)+ "\t" + rs.getLong(4)+ "\t" + rs.getString(5));

                //데이터베이스로부터 받아온 DATETIME타입을 localdatetime으로 변환
                String createdAt = rs.getString(3);
                DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime dateTime = LocalDateTime.parse(createdAt,formatter2);
                System.out.println(dateTime);
            }

            rs.close();
            statement.close();
            connection.close();

        } catch (SQLException e) {

            e.printStackTrace();

        }

    }
}
