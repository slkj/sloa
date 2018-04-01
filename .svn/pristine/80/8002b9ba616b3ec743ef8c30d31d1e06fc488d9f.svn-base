package cn.slkj.hbsl.util.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * 用户名和密码的验证
 * 
 * @author lgf
 * 
 */
public class MailAuthenticator extends Authenticator {
	private String username = "maxuhui2113@163.com";
	private String password = "xg5366213";

	public MailAuthenticator() {
		super();
	}

	/**
	 * 设置验证的用户名和密码
	 */
	public MailAuthenticator(String userName, String password) {
		super();
		this.username = userName;
		this.password = password;
	}

	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(this.username, this.password);
	}
}
