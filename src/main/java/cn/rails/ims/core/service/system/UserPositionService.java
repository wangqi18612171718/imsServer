package cn.rails.ims.core.service.system;
import java.util.List;

import cn.rails.ims.base.IBaseService;
import cn.rails.ims.core.entity.UserPosition;

/**
 * 
 * @author wangqi
 * @date 2017年3月23日
 * @description 用户岗位表
 */
public interface UserPositionService extends IBaseService<UserPosition>{
	public void save(UserPosition userPosition);
	
	public List<UserPosition> queryByCondition(String key, Object value);
	
	public UserPosition queryUserPosition(String userId,String positionId);
	
	public void deleteUserPositionByUserId(String userId);
}
