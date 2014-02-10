package fr.miage.webnewspaper.bean.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="RATE")
public class Rate implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Integer score;
	
	@OneToOne(fetch = FetchType.EAGER)
	private Reader writer;
	@OneToOne(fetch = FetchType.EAGER)
	private Article ofArticle;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public Reader getWriter() {
		return writer;
	}
	public void setWriter(Reader writer) {
		this.writer = writer;
	}
	public Article getOfArticle() {
		return ofArticle;
	}
	public void setOfArticle(Article ofArticle) {
		this.ofArticle = ofArticle;
	}
	
	
}
