package fr.miage.webnewspaper.bean.session;

import javax.ejb.Remote;

import fr.miage.webnewspaper.bean.entity.User;

@Remote
public interface EJBCreateAccountRemote {
	
	public Boolean createAccount(User u);
}
