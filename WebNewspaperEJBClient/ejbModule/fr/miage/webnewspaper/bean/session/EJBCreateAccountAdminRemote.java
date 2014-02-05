package fr.miage.webnewspaper.bean.session;

import javax.ejb.Remote;
import javax.persistence.EntityExistsException;

import fr.miage.webnewspaper.bean.entity.Administrator;

@Remote
public interface EJBCreateAccountAdminRemote {

	public Boolean createAccount(Administrator admin) throws EntityExistsException;
	
}
