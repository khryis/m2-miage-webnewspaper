package fr.miage.webnewspaper.bean.session;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import fr.miage.webnewspaper.bean.entity.Journalist;

/**
 * Session Bean implementation class EJBJournalist
 */
@Stateless
@LocalBean
public class EJBJournalist implements EJBJournalistRemote {

	@PersistenceContext (unitName = "WebNewspaperEJB") 
	EntityManager em;
	
    /**
     * Default constructor. 
     */
    public EJBJournalist() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public List<Journalist> getAll() {
		TypedQuery<Journalist> journalists = em.createNamedQuery("Journalist.findAll", Journalist.class);
		return journalists.getResultList();
	}

	@Override
	public void addJournalist(Journalist j) {
		j.setStatus("off");
		em.persist(j);
		em.flush();
	}

	@Override
	public void deleteJournalist(Long id) {
		Journalist j = em.find(Journalist.class, id);
		em.remove(j);
		em.flush();
	}

	@Override
	public void updateJournalist(Journalist j) {
		em.merge(j);
		em.flush();
	}

}
