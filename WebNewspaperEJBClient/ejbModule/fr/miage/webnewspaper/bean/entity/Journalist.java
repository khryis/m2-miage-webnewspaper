package fr.miage.webnewspaper.bean.entity;

import java.util.List;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name="USER")
@DiscriminatorValue("J")
public class Journalist extends User{
	private static final long serialVersionUID = 1L;
	private String status;
	private Boolean isChiefEditor;
	@OneToMany(fetch = FetchType.LAZY)
	private List<Article> wroteArticles;
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Boolean getIsChiefEditor() {
		return isChiefEditor;
	}
	public void setIsChiefEditor(Boolean isChiefEditor) {
		this.isChiefEditor = isChiefEditor;
	}
	public List<Article> getWroteArticles() {
		return wroteArticles;
	}
	public void setWroteArticles(List<Article> articlesEcrit) {
		this.wroteArticles = articlesEcrit;
	}
}
