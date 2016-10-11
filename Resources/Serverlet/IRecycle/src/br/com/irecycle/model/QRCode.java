package br.com.irecycle.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class QRCode {

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	private Double value;
	private Double weight;
	private Boolean wasUsed;
	@ManyToOne
	private User user;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Double getValue() {
		return value;
	}
	public void setValue(Double value) {
		this.value = value;
	}
	public Boolean getWasUsed() {
		return wasUsed;
	}
	public void setWasUsed(Boolean wasUsed) {
		this.wasUsed = wasUsed;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Double getWeight() {
		return weight;
	}
	public void setWeight(Double weight) {
		this.weight = weight;
	}
	
}
