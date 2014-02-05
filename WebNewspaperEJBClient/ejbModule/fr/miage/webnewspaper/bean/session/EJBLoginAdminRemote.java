package fr.miage.webnewspaper.bean.session;

import javax.ejb.Remote;

import fr.miage.webnewspaper.bean.entity.Administrator;

@Remote
public interface EJBLoginAdminRemote {

	public Boolean checkAdmin(String login, String password);

	public Boolean isLogged();

	public Administrator getAdmin();

}
