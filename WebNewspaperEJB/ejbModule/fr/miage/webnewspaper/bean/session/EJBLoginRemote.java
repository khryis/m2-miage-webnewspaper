package fr.miage.webnewspaper.bean.session;

import javax.ejb.Remote;

@Remote
public interface EJBLoginRemote {

	public Boolean checkUser(String login, String password);
	
	public Boolean isLogged();
}