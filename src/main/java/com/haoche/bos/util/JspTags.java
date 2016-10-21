package com.haoche.bos.util;


import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class JspTags extends SimpleTagSupport {

    private String href = "";

    private String style = "";

    private String data_msg = "";

    private String data_pending = "";

    private String data_url = "";

    private String body = "";

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getData_pending() {
        return data_pending;
    }

    public void setData_pending(String data_pending) {
        this.data_pending = data_pending;
    }

    public String getData_msg() {
        return data_msg;
    }

    public void setData_msg(String data_msg) {
        this.data_msg = data_msg;
    }

    public String getData_url() {
        return data_url;
    }

    public void setData_url(String data_url) {
        this.data_url = data_url;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public void doTag() throws JspException, IOException {
        JspWriter out=getJspContext().getOut();
        String url = "";
        if (href.contains("?")) {
            url = href.split("[?]")[0];
        }
        if (CurrentUser.check(url)) {
            out.print("<a href='" + href + "' class='" + style + "' data-msg='" + data_msg +"' data-pending='"+ data_pending+"' data-url='" + data_url + "'>" + body + "</a>");
        }
    }
}
