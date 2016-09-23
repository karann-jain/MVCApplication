package com.testapp.service;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.testapp.hibernate.util.HibernateUtil;
import com.testapp.model.Users;

public class LoginService {

	public boolean authenticateUser(String userId, String password) {
		Users users = getUserByUserId(userId);
		if (users != null && users.getUserId().equals(userId) && users.getPassword().equals(password)) {
			return true;
		} else {
			return false;
		}
	}

	public Users getUserByUserId(String userId) {
		Session session = HibernateUtil.openSession();
		Transaction tx = null;
		Users users = null;
		try {
			tx = session.getTransaction();
			tx.begin();
			Query query = session.createQuery("from Users where userId='"+ userId + "'");
			users = (Users) query.uniqueResult();
			tx.commit();
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}
		return users;
	}

	@SuppressWarnings("unchecked")
	public List<Users> getListOfUsers() {
		List<Users> list = new ArrayList<Users>();
		Session session = HibernateUtil.openSession();
		Transaction tx = null;
		try {
			tx = session.getTransaction();
			tx.begin();
			list = session.createQuery("from Users").list();
			tx.commit();
		} catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
}