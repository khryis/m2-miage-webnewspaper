package fr.miage.webnewspaper.bean.session;

import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import fr.miage.webnewspaper.bean.entity.Administrator;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Reader;
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
	
	private User fetchUser(String email){
		TypedQuery<User> query = em.createNamedQuery("User.findByEmail", User.class);
		query.setParameter("email", email);
		try{
			return query.getSingleResult();
		}catch(NoResultException|NonUniqueResultException e){
			return null;
		}
		
	}

	@Override
	public Boolean checkUser(String email, String password) {
		User u = fetchUser(email);
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

	@Override
	public User getUser() {
		return user;
	}

	@Override
	public String getTypeOfUser(){
		if(user instanceof Reader){
			return "R";
		}
		if(user instanceof Journalist){
			return "J";
		}
		if(user instanceof Administrator){
			return "A";
		}
		return "R";
	}
}
