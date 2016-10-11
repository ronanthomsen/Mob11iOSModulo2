package br.com.irecycle.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import br.com.irecycle.model.User;
import br.com.irecycle.util.JPAUtil;

public class UserService {

	public String validaLogin(String user, String pass){
		
		EntityManager manager = new JPAUtil().getEntityManager();
		
		Query query = manager
				.createQuery("Select u From User u where u.name = :pName"
						+ " and u.pass = :pPass");
		
		query.setParameter("pName", user);
		query.setParameter("pPass", pass);
		
		List<User> users = query.getResultList();
		
		if(users.size() > 0){
			User userToReturn = users.get(0);
			
			if(userToReturn != null){
				QRCodeService codeService = new QRCodeService();
				return "true_" + userToReturn.getId() + "_" + codeService.getUserTotalPoints(userToReturn);
			}
			else{
				return "false";
			}
		}
		
		return "false";
	}
	
	public User getUserById(String id){
		
		EntityManager manager = new JPAUtil().getEntityManager();
		
		Query query = manager
				.createQuery("Select u From User u where u.id = :pId");
		
		query.setParameter("pId", Integer.parseInt(id));
		
		List<User> users = query.getResultList();
		
		if(users.size() > 0){
			User user = users.get(0);
			return user;
		}
		
		return null;
	}
	
	public String createLogin(String userName, String pass){
		EntityManager manager = new JPAUtil().getEntityManager();
		
		User user = new User();
		user.setName(userName);
		user.setPass(pass);
		
		manager.getTransaction().begin();
		manager.persist(user);
		manager.getTransaction().commit();
		manager.close();
		
		return validaLogin(userName, pass);
	}
	
}
