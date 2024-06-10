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

            String userId = request.getParameter("userId");
            PrintWriter out = response.getWriter();

            MemberDAO dao = MemberDAO.getInstance();
            int idCheck = 0;
            try {
                idCheck = dao.checkId(userId);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            out.write(idCheck + ""); // --> ajax 결과 값인 result, String으로 값을 내보낼 수 있도록 + "" 를 해준다
        }
    }


