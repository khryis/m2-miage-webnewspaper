package fr.miage.webnewspaper.bean.session;

import java.util.List;

import javax.ejb.Remote;

import fr.miage.webnewspaper.bean.entity.Article;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Rate;
import fr.miage.webnewspaper.bean.entity.Reader;

@Remote
public interface EJBArticleRemote {
	
	public Article previewArticle(Long id);
	
	public Article getArticle(Long id);
	
	public void commentArticle(Long id, String comment, Reader r);
	
	public void rateArticle(Long id, Integer rate, Reader r);
	
	public List<Rate> getRates(Article a);
	
	public Integer getMeanRates(Article a);
	
	public void buyArticle(Long id, Reader r);
	
	public Article readArticle(Long id, Reader r);
	
	public List<Article> getAll();
	
	public List<Article> getJournalistArticle(Journalist j);
	
	public void addArticle(String title, String contenu, Journalist j);
	
	public void updateArticle(Article a);
	
	public void validate(Long id);
	
	public void deleteArticle(Long id);
	
	public void deleteComment(Long id);
	
}
