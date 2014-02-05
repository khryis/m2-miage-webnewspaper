package fr.miage.webnewspaper.bean.session;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import fr.miage.webnewspaper.bean.entity.Administrator;

/**
 * Session Bean implementation class EJBLoginAdmin
 */
@Stateless
@LocalBean
public class EJBLoginAdmin implements EJBLoginAdminRemote, EJBLoginAdminLocal {

	private Administrator admin;
	
	@PersistenceContext(unitName = "WebNewspaperEJB")
	EntityManager em;
	
    public EJBLoginAdmin() {
    }
    
    public Administrator getAdmin(String email){
		TypedQuery<Administrator> query = em.createNamedQuery("Administrator.findByEmail", Administrator.class);
		query.setParameter("email", email);
		try{
			return query.getSingleResult();
		}catch(NoResultException|NonUniqueResultException e){
			return null;
		}
	}

	@Override
	public Boolean checkAdmin(String email, String password) {
		Administrator a = getAdmin(email);
		if (a != null && a.getPassword().equals(password)) {
			this.admin = a;
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Boolean isLogged() {
		if (admin != null){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public Administrator getAdmin() {
		return admin;
	}

}
