package com.haoche.bos.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class StatisticsDBHelper {

    private static final String name = "com.mysql.jdbc.Driver";

    private Connection conn = null;
    private PreparedStatement pst = null;

    public StatisticsDBHelper() {
        try {
            Class.forName(name);//指定连接类型
            //conn = DriverManager.getConnection(url, user, password);//获取连接
            //pst = conn.prepareStatement(sql);//准备执行语句
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("获取数据库驱动失败",e);
        }
    }

    public void close() {
        try {
            this.conn.close();
            this.pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private synchronized Connection getConn(String url, String user, String password) throws SQLException {
        if (conn==null) {
            conn = DriverManager.getConnection(url, user, password);//获取连接
        }
        return conn;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }

    public synchronized PreparedStatement getPst(String url, String user, String password, String sql) throws SQLException {
        if (pst==null) {
            pst = getConn(url,user,password).prepareStatement(sql);//准备执行语句
        }
        return pst;
    }

    public void setPst(PreparedStatement pst) {
        this.pst = pst;
    }
}
