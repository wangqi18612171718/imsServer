package cn.rails.ims.core.dao.system;

import cn.rails.ims.base.IBaseDao;
import cn.rails.ims.core.entity.UserPosition;
/**
 * 
 * @author wangqi
 * @date 2017年3月23日
 * @description
 */
public interface UserPositionDao extends IBaseDao<UserPosition>{
	public UserPosition queryUserPosition(String userId,String positionId);
	
	public void deleteUserPositionByUserId(String userId);
}
