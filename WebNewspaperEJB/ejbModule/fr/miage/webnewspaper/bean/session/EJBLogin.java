package fr.miage.webnewspaper.bean.session;

import javax.ejb.Stateful;

import fr.miage.webnewspaper.bean.entity.User;

/**
 * Session Bean implementation class EJBLogin
 */
@Stateful
public class EJBLogin implements EJBLoginRemote, EJBLoginLocal {

	private User user;
	private Boolean isLogged;

	public EJBLogin() {
		user = new User();
		user.setEmail("test@test.fr");
		user.setPassword("test");
	}

	@Override
	public Boolean checkUser(String email, String password) {
		if (user.getPassword().equals(password) && user.getEmail().equals(email)) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Boolean isLogged() {
		return isLogged;
	}

}
