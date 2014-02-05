package fr.miage.webnewspaper.bean.session;

import java.util.Date;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import fr.miage.webnewspaper.bean.entity.User;

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
	public Boolean createAccount(User u) throws EntityExistsException {

		if(!u.getEmail().isEmpty() && !u.getPassword().isEmpty()){
			u.setRegistrationDate(new Date());
			em.persist(u);
			return true;
		}else{
			return false;
		}
	}

}
