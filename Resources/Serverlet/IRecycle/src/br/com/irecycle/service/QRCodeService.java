package br.com.irecycle.service;

import java.util.List;
import java.util.Locale;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import br.com.irecycle.model.QRCode;
import br.com.irecycle.model.User;
import br.com.irecycle.util.JPAUtil;

public class QRCodeService {

	public String validateQRCode(String id){
		String[] arrayOfString = id.split("_");
		
		if(arrayOfString.length >= 3) {
			double weight = Double.parseDouble( arrayOfString[0] );
			String securityKey = arrayOfString[1];
			String userId = arrayOfString[2];
			//long timestamp = Long.parseLong(arrayOfString[3]);
			
			if(securityKey.equals("fiap")){

				UserService userService = new UserService();
				User user = userService.getUserById(userId);
				
				if(user != null){
					EntityManager manager = new JPAUtil().getEntityManager();
					manager.getTransaction().begin();
					
					QRCode code = new QRCode();
					code.setUser(user);
					code.setWeight(weight);
					code.setWasUsed(false);
					
					double value = weight * 0.1;
							
					//if (value < 1) {value = 1;}
					
					code.setValue(value);
					
					manager.persist(code);
					
					manager.getTransaction().commit();
					manager.close();
					
					return "true_" + String.format(Locale.ENGLISH, "%.2f", code.getValue()) + 
							"_" + getUserTotalPoints(user);
				}
				else{
					return "false_UserNotFound";
				}
			}
		}
		return "false";		
	}
	
	public double getUserTotalPoints(User user){
		double result = 0.0;
		
		EntityManager manager = new JPAUtil().getEntityManager();
		Query query = manager
				.createQuery("Select q From QRCode q where q.user.name = :pName"
						+ " AND q.wasUsed = false");
		
		query.setParameter("pName", user.getName());
		
		List<QRCode> codes = query.getResultList();
		
		if(codes.size() > 0){
			for (QRCode code : codes) {
				result += code.getValue();
			}
		}
		
		return result;
	}
	
}
