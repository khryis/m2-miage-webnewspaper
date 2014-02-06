package fr.miage.webnewspaper.bean.session;

import javax.ejb.Remote;

import fr.miage.webnewspaper.bean.entity.User;

@Remote
public interface EJBLoginRemote {

	public Boolean checkUser(String login, String password);
	
	public Boolean isLogged();
	
	public User getUser();
	
	public String getTypeOfUser();
}