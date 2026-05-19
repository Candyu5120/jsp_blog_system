package com.blog.dao;

import com.blog.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public abstract class BaseDao {

    @FunctionalInterface
    public interface RowMapper<T> {
        T mapRow(ResultSet rs) throws SQLException;
    }

    protected int executeUpdate(String sql, Object... params) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            setParams(ps, params);
            return ps.executeUpdate();
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    protected <T> T executeQueryOne(String sql, RowMapper<T> mapper, Object... params) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            setParams(ps, params);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapper.mapRow(rs);
            }
            return null;
        } finally {
            DBUtil.close(conn, ps, rs);
        }
    }

    protected <T> List<T> executeQueryList(String sql, RowMapper<T> mapper, Object... params) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            setParams(ps, params);
            rs = ps.executeQuery();
            List<T> list = new ArrayList<>();
            while (rs.next()) {
                list.add(mapper.mapRow(rs));
            }
            return list;
        } finally {
            DBUtil.close(conn, ps, rs);
        }
    }

    protected int executeInsertAndGetId(String sql, Object... params) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            setParams(ps, params);
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        } finally {
            DBUtil.close(conn, ps, rs);
        }
    }

    protected int executeQueryInt(String sql, Object... params) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            setParams(ps, params);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        } finally {
            DBUtil.close(conn, ps, rs);
        }
    }

    private void setParams(PreparedStatement ps, Object... params) throws SQLException {
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
        }
    }
}
