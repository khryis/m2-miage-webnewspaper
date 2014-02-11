package fr.miage.webnewspaper.bean.session;

import java.util.List;

import javax.ejb.Remote;
import javax.persistence.EntityExistsException;

import fr.miage.webnewspaper.bean.entity.Administrator;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Reader;
import fr.miage.webnewspaper.bean.entity.User;

@Remote
public interface EJBAccountRemote {

	public Boolean createAccountReader(Reader r) throws EntityExistsException;

	public Boolean createAccountJournalist(Journalist j)
			throws EntityExistsException;

	public Boolean createAccountAdministrator(Administrator a)
			throws EntityExistsException;

	public List<Journalist> getAllJournalists();

	public List<Reader> getAllReaders();

	public User getUser(Long id);

	public void deleteUser(Long id);

	public void updateJournalist(Journalist j);
}
