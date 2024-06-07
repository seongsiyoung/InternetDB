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

        String nickname = request.getParameter("nickname");
        PrintWriter out = response.getWriter();

        MemberDAO dao = MemberDAO.getInstance();
        int nicknameCheck = 0;
        try {
            nicknameCheck = dao.checkNickname(nickname);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (nicknameCheck == 0) {
            System.out.println("이미 존재하는 닉네임입니다.");
        } else if (nicknameCheck == 1) {
            System.out.println("사용 가능한 닉네임입니다.");
        }

        out.write(nicknameCheck + "");

        }
    }


