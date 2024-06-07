package com.InternetDB.servlet;

import com.InternetDB.DAO.MemberDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/member/idCheck")
public class MemberServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        request.setCharacterEncoding("UTF-8"); // ajax로 값을 받기 때문에 UTF-8로 인코딩해준다
        response.setCharacterEncoding("UTF-8");

            String userId = request.getParameter("userId");// join.jsp에서 받아온 key값이 userId이고
            // value값은 유저가 실제로 적은 값, String userId에는 value값이 들어간다.
            PrintWriter out = response.getWriter();

            MemberDAO dao = MemberDAO.getInstance();
            int idCheck = 0;
            try {
                idCheck = dao.checkId(userId);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            // 성공여부 확인 : 개발자용
            if (idCheck == 0) {
                System.out.println("이미 존재하는 아이디입니다.");
            } else if (idCheck == 1) {
                System.out.println("사용 가능한 아이디입니다.");
            }

            out.write(idCheck + ""); // --> ajax 결과값인 result가 됨
            // --> String으로 값을 내보낼 수 있도록 + "" 를 해준다
        }
    }


