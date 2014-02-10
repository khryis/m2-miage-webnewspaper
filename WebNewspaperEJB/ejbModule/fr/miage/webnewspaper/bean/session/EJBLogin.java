package fr.miage.webnewspaper.bean.session;

import java.util.Date;

import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import fr.miage.webnewspaper.bean.entity.Administrator;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Reader;
import fr.miage.webnewspaper.bean.entity.Subscription;
import fr.miage.webnewspaper.bean.entity.User;

/**
 * Session Bean implementation class EJBLogin
 */
@Stateful
public class EJBLogin implements EJBLoginRemote, EJBLoginLocal {

	private User user;
	
	@PersistenceContext(unitName = "WebNewspaperEJB")
	EntityManager em;

	public EJBLogin() {
	}
	
	public void setUser(User u){
		user = u;
	}

	private User fetchUser(String email) {
		TypedQuery<User> query = em.createNamedQuery("User.findByEmail",
				User.class);
		query.setParameter("email", email);
		try {
			return query.getSingleResult();
		} catch (NoResultException | NonUniqueResultException e) {
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
		if (user != null) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Subscription getSubscription(Reader reader) {
		Subscription s = reader.getSubscription();
		return s;
	}

	@Override
	public User getUser() {
		User u = em.find(User.class, user.getId());
		user = u;
		if (user instanceof Reader) {
			((Reader) user).getBuyArticles().size();
			((Reader) user).getComments().size();
			((Reader) user).getRates().size();
		}
		return user;
	}

	@Override
	public String getTypeOfUser() {
		if (user instanceof Reader) {
			return "R";
		}
		if (user instanceof Journalist) {
			return "J";
		}
		if (user instanceof Administrator) {
			return "A";
		}
		return "R";
	}

	@Override
	public void subscribe(Integer choice) {
		Date currentDate = new Date();
		Subscription subscription = new Subscription();
		subscription.setReader((Reader)user);
		switch (choice) {
		case 1:
			Date tomorrow = new Date(currentDate.getTime() + (1000 * 60 * 60 * 24));
			subscription.setSubscriptionDate(currentDate);
			subscription.setSubscriptionEndDate(tomorrow);
			break;
		case 2:
			Date weekAfter = new Date(currentDate.getTime() + (1000 * 60 * 60 * 24 * 7));
			subscription.setSubscriptionDate(currentDate);
			subscription.setSubscriptionEndDate(weekAfter);
			break;
		case 3:
			Date monthAfter = new Date(currentDate.getDate());
			monthAfter.setMonth(currentDate.getMonth() + 1);
			subscription.setSubscriptionDate(currentDate);
			subscription.setSubscriptionEndDate(monthAfter);
			break;
		case 4:
			Date yearAfter = new Date(currentDate.getDate());
			yearAfter.setYear(currentDate.getYear() + 1);
			subscription.setSubscriptionDate(currentDate);
			subscription.setSubscriptionEndDate(yearAfter);
			break;
		default:
			Date defaut = new Date(currentDate.getTime() + (1000 * 60 * 60 * 24));
			subscription.setSubscriptionDate(currentDate);
			subscription.setSubscriptionEndDate(defaut);
			break;
		}
		em.persist(subscription);
		((Reader)user).setSubscription(subscription);
		em.merge(user);
		em.flush();
	}
}
