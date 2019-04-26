/**
 * 
 */
package cn.rails.ims.core.service.system.serviceImpl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.rails.ims.core.dao.system.UserPositionDao;
import cn.rails.ims.core.entity.UserPosition;
import cn.rails.ims.core.service.system.UserPositionService;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

/**
 * 
 * @author wangqi
 * @date 2017年3月23日
 * @description
 */
@Service
@Transactional
public class UserPositionServiceImpl implements UserPositionService{
	@Autowired
	private UserPositionDao userPositionDao ;
	
	@Override
	public PageTion listByPage(int pageNo, int pageSize, Paramter par) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserPosition> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void save(UserPosition t) {
		userPositionDao.save(t);
	}

	@Override
	public void update(UserPosition t) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(UserPosition t) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public UserPosition queryById(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserPosition> queryByCondition(UserPosition t) {
		return userPositionDao.queryByCondition(t);
	}

	@Override
	public List<UserPosition> queryByCondition(String key, Object value) {
		return userPositionDao.queryByCondition(key, value);
	}

	@Override
	public UserPosition queryUserPosition(String userId, String positionId) {
		return userPositionDao.queryUserPosition(userId, positionId);
	}

	@Override
	public void deleteUserPositionByUserId(String userId) {
		userPositionDao.deleteUserPositionByUserId(userId);
		
	}
}
