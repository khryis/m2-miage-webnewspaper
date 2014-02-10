package fr.miage.webnewspaper.bean.entity;

import java.util.List;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.eclipse.persistence.annotations.CascadeOnDelete;

@Entity
@Table(name="USER")
@DiscriminatorValue("R")
@NamedQueries({
	@NamedQuery(name="Reader.findAll",
				query="SELECT r FROM Reader r"),
})
@CascadeOnDelete
public class Reader extends User {

	private static final long serialVersionUID = 1L;
	
	@OneToMany(fetch = FetchType.LAZY)
	private List<Rate> rates;
	
	@OneToMany(fetch = FetchType.LAZY)
	private List<Comment> comments;
	
	@ManyToMany(fetch = FetchType.LAZY)
	private List<Article> buyArticles;
	
	@OneToOne(fetch = FetchType.EAGER)
	private Subscription subscription;

	public List<Rate> getRates() {
		return rates;
	}

	public void setRates(List<Rate> rates) {
		this.rates = rates;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Article> getBuyArticles() {
		return buyArticles;
	}

	public void setBuyArticles(List<Article> readArticles) {
		this.buyArticles = readArticles;
	}

	public Subscription getSubscription() {
		return subscription;
	}

	public void setSubscription(Subscription subscription) {
		this.subscription = subscription;
	}
	
}
