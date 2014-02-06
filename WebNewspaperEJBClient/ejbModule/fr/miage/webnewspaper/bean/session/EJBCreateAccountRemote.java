package fr.miage.webnewspaper.bean.session;

import javax.ejb.Remote;
import javax.persistence.EntityExistsException;

import fr.miage.webnewspaper.bean.entity.Administrator;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Reader;

@Remote
public interface EJBCreateAccountRemote {
	
	public Boolean createAccountReader(Reader r) throws EntityExistsException;
	
	public Boolean createAccountJournalist(Journalist j) throws EntityExistsException;
	
	public Boolean createAccountAdministrator(Administrator a) throws EntityExistsException;
}
