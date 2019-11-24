package com.iamvickyav.springbootmvcjsp.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DB {
    public static Connection getConnection(){
        Connection conn = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/workout_king";
            String username="workout_king";
            String password="comp426";
            conn = DriverManager.getConnection(url,username,password);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return conn;
    }

    public static void update(String sql){
        Connection conn=getConnection();
        try {
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static void main(String[] args){
        update("update Allergy set name='unknown' where aid=1");
    }
}