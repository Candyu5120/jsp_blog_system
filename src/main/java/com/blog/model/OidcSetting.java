package com.blog.model;

public class OidcSetting {
    private int id;
    private String providerName;
    private String issuerUrl;
    private String clientId;
    private String clientSecret;
    private String redirectUri;
    private String scope;
    private int enabled;

    public OidcSetting() {
        this.scope = "openid profile email";
        this.enabled = 0;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getProviderName() { return providerName; }
    public void setProviderName(String providerName) { this.providerName = providerName; }
    public String getIssuerUrl() { return issuerUrl; }
    public void setIssuerUrl(String issuerUrl) { this.issuerUrl = issuerUrl; }
    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }
    public String getClientSecret() { return clientSecret; }
    public void setClientSecret(String clientSecret) { this.clientSecret = clientSecret; }
    public String getRedirectUri() { return redirectUri; }
    public void setRedirectUri(String redirectUri) { this.redirectUri = redirectUri; }
    public String getScope() { return scope; }
    public void setScope(String scope) { this.scope = scope; }
    public int getEnabled() { return enabled; }
    public void setEnabled(int enabled) { this.enabled = enabled; }
}
