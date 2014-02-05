package fr.miage.webnewspaper.bean.session;

import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import fr.miage.webnewspaper.bean.entity.User;

/**
 * Session Bean implementation class EJBLogin
 */
@Stateful
public class EJBLogin implements EJBLoginRemote, EJBLoginLocal {

	private User user;
	
	@PersistenceContext (unitName = "WebNewspaperEJB") 
	EntityManager em;

	public EJBLogin() {
	}
	
	public User getUser(String email){
		TypedQuery<User> query = em.createNamedQuery("User.findByEmail", User.class);
		return query.getSingleResult();
	}

	@Override
	public Boolean checkUser(String email, String password) {
		User u = getUser(email);
		if (u != null && u.getPassword().equals(password)) {
			this.user = u;
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Boolean isLogged() {
		if (user != null){
			return true;
		}else{
			return false;
		}
	}

}
