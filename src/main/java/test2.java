import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class test2 {

    public static void main(String[] args){


        String jdbcURL = "jdbc:mysql://localhost:3306/internetDB";
        String username = "internetdb";
        String password = "internetdb";

        String sql = "select now()";

        try {
            Connection connection = DriverManager.getConnection(jdbcURL, username, password);
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs;

            rs = statement.executeQuery();

            while (rs.next()) {
                System.out.println(rs.getString(1));
            }

            rs.close();
            statement.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
