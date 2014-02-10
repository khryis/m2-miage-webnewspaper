package fr.miage.webnewspaper.bean.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="ARTICLE")
@NamedQueries({
    @NamedQuery(name="Article.findAll",
                query="SELECT a FROM Article a"),
    @NamedQuery(name="Article.findById",
                query="SELECT a FROM Article a WHERE a.id = :id"),
    @NamedQuery(name="Article.findByWriter",
                query="SELECT a FROM Article a WHERE a.journalist = :journalist"),
}) 
public class Article implements Serializable, Cloneable{
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String title;
	private String content;
	@Temporal(value=TemporalType.DATE)
	private Date creationDate;
	@Temporal(value=TemporalType.DATE)
	private Date lastModifiedDate;
	private Boolean isValidated;
	@OneToOne(fetch = FetchType.EAGER)
	private Journalist journalist;
	@OneToMany(fetch = FetchType.LAZY)
	private List<Rate> rates;
	@OneToMany(fetch = FetchType.LAZY)
	private List<Comment> comments;
	
	public Article(){
	}
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public Date getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(Date lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
	public Boolean getIsValidated() {
		return isValidated;
	}
	public void setIsValidated(Boolean isValidated) {
		this.isValidated = isValidated;
	}
	public Journalist getJournalist() {
		return journalist;
	}
	public void setJournalist(Journalist journalist) {
		this.journalist = journalist;
	}
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
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
}
