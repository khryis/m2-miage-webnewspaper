package fr.miage.webnewspaper.bean.session;

import java.util.List;

import javax.ejb.Remote;

import fr.miage.webnewspaper.bean.entity.Journalist;

@Remote
public interface EJBJournalistRemote {

	public List<Journalist> getAll();
	
	public void addJournalist(Journalist j);
	
	public void deleteJournalist(Long id);
	
	public void updateJournalist(Journalist j);
}
