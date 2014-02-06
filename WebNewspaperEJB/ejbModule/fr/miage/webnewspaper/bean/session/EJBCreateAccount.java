package fr.miage.webnewspaper.bean.session;

import java.util.Date;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import fr.miage.webnewspaper.bean.entity.Administrator;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Reader;

/**
 * Session Bean implementation class EJBCreateAccount
 */
@Stateless
@LocalBean
public class EJBCreateAccount implements EJBCreateAccountRemote,
		EJBCreateAccountLocal {

	@PersistenceContext(unitName = "WebNewspaperEJB")
	EntityManager em;

	/**
	 * Default constructor.
	 */
	public EJBCreateAccount() {
	}

	@Override
	public Boolean createAccountReader(Reader r) throws EntityExistsException {
		if(!r.getEmail().isEmpty() && !r.getPassword().isEmpty()){
			r.setRegistrationDate(new Date());
			em.persist(r);
			return true;
		}else{
			return false;
		}
	}

	@Override
	public Boolean createAccountJournalist(Journalist j)
			throws EntityExistsException {
		if(!j.getEmail().isEmpty() && !j.getPassword().isEmpty()){
			j.setRegistrationDate(new Date());
			em.persist(j);
			return true;
		}else{
			return false;
		}
	}

	@Override
	public Boolean createAccountAdministrator(Administrator a)
			throws EntityExistsException {
		if(!a.getEmail().isEmpty() && !a.getPassword().isEmpty()){
			em.persist(a);
			return true;
		}else{
			return false;
		}
	}

}
