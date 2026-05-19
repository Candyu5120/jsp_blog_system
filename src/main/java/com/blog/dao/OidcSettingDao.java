package com.blog.dao;

import com.blog.model.OidcSetting;

import java.sql.SQLException;

public class OidcSettingDao extends BaseDao {

    public OidcSetting findEnabled() throws SQLException {
        String sql = "SELECT * FROM t_oidc_setting WHERE enabled = 1 LIMIT 1";
        return executeQueryOne(sql, this::mapSetting);
    }

    public OidcSetting findById(int id) throws SQLException {
        String sql = "SELECT * FROM t_oidc_setting WHERE id = ?";
        return executeQueryOne(sql, this::mapSetting, id);
    }

    public OidcSetting findFirst() throws SQLException {
        String sql = "SELECT * FROM t_oidc_setting LIMIT 1";
        return executeQueryOne(sql, this::mapSetting);
    }

    public int insert(OidcSetting s) throws SQLException {
        String sql = "INSERT INTO t_oidc_setting (provider_name, issuer_url, client_id, client_secret, redirect_uri, scope, enabled) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return executeInsertAndGetId(sql, s.getProviderName(), s.getIssuerUrl(), s.getClientId(),
                s.getClientSecret(), s.getRedirectUri(), s.getScope(), s.getEnabled());
    }

    public boolean update(OidcSetting s) throws SQLException {
        String sql = "UPDATE t_oidc_setting SET provider_name=?, issuer_url=?, client_id=?, client_secret=?, redirect_uri=?, scope=?, enabled=? WHERE id=?";
        return executeUpdate(sql, s.getProviderName(), s.getIssuerUrl(), s.getClientId(),
                s.getClientSecret(), s.getRedirectUri(), s.getScope(), s.getEnabled(), s.getId()) > 0;
    }

    private OidcSetting mapSetting(java.sql.ResultSet rs) throws SQLException {
        OidcSetting s = new OidcSetting();
        s.setId(rs.getInt("id"));
        s.setProviderName(rs.getString("provider_name"));
        s.setIssuerUrl(rs.getString("issuer_url"));
        s.setClientId(rs.getString("client_id"));
        s.setClientSecret(rs.getString("client_secret"));
        s.setRedirectUri(rs.getString("redirect_uri"));
        s.setScope(rs.getString("scope"));
        s.setEnabled(rs.getInt("enabled"));
        return s;
    }
}
