package fr.miage.webnewspaper.bean.session;

import java.util.Date;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import fr.miage.webnewspaper.bean.entity.Administrator;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Reader;
import fr.miage.webnewspaper.bean.entity.User;

/**
 * Session Bean implementation class EJBAccount
 */
@Stateless
@LocalBean
public class EJBAccount implements EJBAccountRemote,
		EJBAccountLocal {

	@PersistenceContext(unitName = "WebNewspaperEJB")
	EntityManager em;

	/**
	 * Default constructor.
	 */
	public EJBAccount() {
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
			j.setStatus("actif");
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

	@Override
	public List<Journalist> getAllJournalists() {
		TypedQuery<Journalist> journalists = em.createNamedQuery("Journalist.findAll", Journalist.class);
		return journalists.getResultList();
	}

	@Override
	public List<Reader> getAllReaders() {
		TypedQuery<Reader> readers = em.createNamedQuery("Reader.findAll", Reader.class);
		return readers.getResultList();
	}

	@Override
	public void deleteUser(Long id) {
		User user = em.find(User.class, id);
		em.merge(user);
		em.remove(user);
		em.flush();
	}

	@Override
	public void updateJournalist(Journalist j) {
		em.merge(j);
		em.flush();
	}

}
