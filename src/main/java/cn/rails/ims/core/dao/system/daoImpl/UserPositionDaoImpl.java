package cn.rails.ims.core.dao.system.daoImpl;

import org.springframework.stereotype.Repository;

import cn.rails.ims.base.HibernateBaseDao;
import cn.rails.ims.core.dao.system.UserPositionDao;
import cn.rails.ims.core.entity.UserPosition;
/**
 * @author       : wangqi
 * @date         ：2017-02-16
 */
@Repository
public class UserPositionDaoImpl extends HibernateBaseDao<UserPosition> implements UserPositionDao {
	@Override
	public Class<UserPosition> getEntityClass() {
		return UserPosition.class;
	}

	public UserPosition queryUserPosition(String userId, String positionId) {
		String hql ="from UserPosition where userId =? and positionId =?";
		UserPosition userPosition = (UserPosition) getSession().createQuery(hql).setParameter(0,
				userId).setParameter(1, positionId).uniqueResult();
		return userPosition;
	}
	
	public void deleteUserPositionByUserId(String userId){
		String hql ="delete from UserPosition where userId =?";
		getSession().createQuery(hql).setParameter(0,userId).executeUpdate();
	}
} 