package fr.miage.webnewspaper.bean.session;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import fr.miage.webnewspaper.bean.entity.Administrator;

/**
 * Session Bean implementation class EJBCreateAccountAdmin
 */
@Stateless
@LocalBean
public class EJBCreateAccountAdmin implements EJBCreateAccountAdminRemote, EJBCreateAccountAdminLocal {

	@PersistenceContext(unitName = "WebNewspaperEJB")
	EntityManager em;
	
    public EJBCreateAccountAdmin() {
    }

	@Override
	public Boolean createAccount(Administrator admin) throws EntityExistsException {
		if(!admin.getEmail().isEmpty() && !admin.getPassword().isEmpty()){
			em.persist(admin);
			return true;
		}else{
			return false;
		}
	}

}
