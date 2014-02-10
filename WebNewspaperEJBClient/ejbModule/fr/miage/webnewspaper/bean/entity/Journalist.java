package fr.miage.webnewspaper.bean.entity;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


@Entity
@Table(name="USER")
@DiscriminatorValue("J")
@NamedQueries({
	@NamedQuery(name="Journalist.findAll",
            query="SELECT j FROM Article j"),
    @NamedQuery(name="Journalist.findById",
            query="SELECT j FROM Article j WHERE j.id = :id"),
})

public class Journalist extends User{
	private static final long serialVersionUID = 1L;
	private String status;
	private Boolean isChiefEditor;
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
}
