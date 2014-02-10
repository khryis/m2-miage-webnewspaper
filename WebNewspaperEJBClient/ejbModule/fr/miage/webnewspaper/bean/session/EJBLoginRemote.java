package fr.miage.webnewspaper.bean.session;

import javax.ejb.Remote;

import fr.miage.webnewspaper.bean.entity.Reader;
import fr.miage.webnewspaper.bean.entity.Subscription;
import fr.miage.webnewspaper.bean.entity.User;

@Remote
public interface EJBLoginRemote {

	public Boolean checkUser(String login, String password);
	
	public Boolean isLogged();
	
	public User getUser();
	
	public String getTypeOfUser();
	
	public Subscription getSubscription(Reader reader);
	
	public void subscribe(Integer choice);
	
	public void setUser(User u);
}