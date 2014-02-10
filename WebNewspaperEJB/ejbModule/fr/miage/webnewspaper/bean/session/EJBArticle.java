package fr.miage.webnewspaper.bean.session;

import java.util.Date;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import fr.miage.webnewspaper.bean.entity.Article;
import fr.miage.webnewspaper.bean.entity.Comment;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Rate;
import fr.miage.webnewspaper.bean.entity.Reader;
import fr.miage.webnewspaper.bean.entity.Subscription;

/**
 * Session Bean implementation class EJBArticle
 */
@Stateless
@LocalBean
public class EJBArticle implements EJBArticleRemote, EJBArticleLocal {

	@PersistenceContext (unitName = "WebNewspaperEJB") 
	EntityManager em;
	
    public EJBArticle() {
        
    }
    
    @Override
    public Article previewArticle(Long id){
		TypedQuery<Article> query = em.createNamedQuery("Article.findById", Article.class);
		query.setParameter("id", id);
		List<Article> articles = query.getResultList();
		Article a = articles.get(0);
		StringBuilder content = new StringBuilder(a.getContent());
		content = new StringBuilder(content.substring(0, 20));
		content.append("...");
		Article preview = null;
		try {
			preview = (Article) a.clone();
			preview.setContent(content.toString());
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		return preview;
	}

	@Override
	public void commentArticle(Long id, String comment, Reader r) {
		TypedQuery<Article> query = em.createNamedQuery("Article.findById", Article.class);
		query.setParameter("id", id);
		Article article = query.getResultList().get(0);
		Comment c = new Comment();
		c.setCommentDate(new Date());
		c.setContent(comment);
		c.setOfArticle(article);
		c.setWriter(r);
		em.persist(c);
		article.getComments().add(c);
		em.merge(r);
		r.getComments().add(c);
		em.flush();
	}

	@Override
	public void rateArticle(Long id,Integer score,Reader r) {
		Rate rate = new Rate();
		Article a = em.find(Article.class, id);
		rate.setOfArticle(a);
		rate.setScore(score);
		rate.setWriter(r);
		em.persist(rate);
		a.getRates().add(rate);
		em.merge(r);
		r.getRates().add(rate);
		em.flush();
	}
	
	@Override
	public List<Rate> getRates(Article a){
		TypedQuery<Article> query = em.createNamedQuery("Article.findById", Article.class).setParameter("id", a.getId());
		Article article = query.getResultList().get(0);
		article.getRates().size();
		return article.getRates();
	}
	
	public Integer getMeanRates(Article a){
		TypedQuery<Article> query = em.createNamedQuery("Article.findById", Article.class).setParameter("id", a.getId());
		Article article = query.getResultList().get(0);
		List<Rate> rates = article.getRates();
		rates.size();
		Integer sum = 0;
		for (Rate rate : rates) {
			sum += rate.getScore();
		}
		if(rates.size() != 0){
			Integer meanRate = sum/rates.size();
			return meanRate;
		}
		return null;
	}

	@Override
	public void buyArticle(Long id, Reader r) {
		Article a = em.find(Article.class, id);
		Reader reader = em.find(Reader.class, r.getId());
		reader.getBuyArticles().add(a);
		em.merge(reader);
		em.flush();
	}

	@Override
	public Article readArticle(Long id, Reader r) {
		Article a = em.find(Article.class, id);
		a.getComments().size();
		TypedQuery<Subscription> querySub = em.createNamedQuery("Subscription.findByUserId", Subscription.class);
		querySub.setParameter("reader", r);
		Subscription s = null;
		try{
			s = querySub.getSingleResult();
		}catch(Exception e){
			System.out.println("No Subscription for this User");
		}
		// Si le user est en mode souscription, il peut accèder à tout les articles
		Date currentDate = new Date();
		if(s != null &&  currentDate.after(s.getSubscriptionDate()) && currentDate.before(s.getSubscriptionEndDate())){
			return a;
		}else{
			// Sinon on vérifie qu'il a acheté l'article
			Reader reader = em.find(Reader.class, r.getId());
			if (reader.getBuyArticles() != null && reader.getBuyArticles().contains(a)){
				return a;
			}
			// Sinon on renvoi que la préview
			return previewArticle(id);
		}
	}

	@Override
	public List<Article> getAll() {
		TypedQuery<Article> query = em.createNamedQuery("Article.findAll", Article.class);
		return query.getResultList();
	}
	
	public List<Article> getJournalistArticle(Journalist j){
		TypedQuery<Article> query = em.createNamedQuery("Article.findByWriter", Article.class).setParameter("journalist", j);
		return query.getResultList();
	}

	public void addArticle(String title, String contenu, Journalist j){
		Article article = new Article();
		article.setContent(contenu);
		article.setTitle(title);
		Date currentDate = new Date();
		article.setCreationDate(currentDate);
		article.setLastModifiedDate(currentDate);
		article.setIsValidated(false);
		article.setJournalist(j);
		em.persist(article);
		Journalist journalist = em.find(Journalist.class, j.getId());
		em.merge(journalist);
		em.flush();
	}

	@Override
	public Article getArticle(Long id) {
		Article article = em.find(Article.class, id);
		article.getComments().size();
		return article;
	}

	@Override
	public void updateArticle(Article a) {
		a.setLastModifiedDate(new Date());
		em.merge(a);
		em.flush();
	}

	@Override
	public void validate(Long id) {
		Article article = em.find(Article.class, id);
		article.setIsValidated(true);
		em.merge(article);
		em.flush();
	}

	@Override
	public void deleteArticle(Long id) {
		Article article = em.find(Article.class, id);
		em.remove(article);
		em.flush();
	}
	
}
