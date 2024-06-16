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

@WebServlet("/member/nicknameCheck")
public class NicknameServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String userId = (String)request.getSession().getAttribute("id");
        String nickname = request.getParameter("nickname");
        PrintWriter out = response.getWriter();

        MemberDAO dao = MemberDAO.getInstance();

        int nicknameCheck = 0;
        try {
            nicknameCheck = dao.checkNickname(userId, nickname);//dao의 메소드를 통해 중복 검사
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        out.write(nicknameCheck + "");
        out.flush();
        out.close();

        }
    }


