package cn.rails.ims.core.dao.system;
import cn.rails.ims.base.IBaseDao;
import cn.rails.ims.core.entity.PositionDepartment;
import cn.rails.ims.core.entity.UserDepartment;
/**
 * 
 * @author hzx
 * @date 2017年3月23日
 * @description 部门岗位实现层
 */
public interface PositionDepartmentDao extends IBaseDao<PositionDepartment>{
	/**
	 * 保存或更新
	 */
	public void saveOrUpdate(PositionDepartment t);
	
	public void updateByUserId(String userId,String departmentId);
	
	public void deleteByUserId(String userId);
	//根据人员ID获取部门ID
	public PositionDepartment getDepartmentIdByUserId(String positionId);
}
