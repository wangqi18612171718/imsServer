package cn.rails.ims.core.service.system;


import cn.rails.ims.base.IBaseService;
import cn.rails.ims.core.entity.PositionDepartment;
import cn.rails.ims.core.entity.UserDepartment;

/**
 * 
 * @author hzx
 * @date 2017年3月23日
 * @description 部门岗位service
 */
public interface PositionDepartmentService extends IBaseService<PositionDepartment>{
	//根据用户ID更新用户部门表的数据
	public void updateByUserId(String userId,String departmentId);
	public void deleteByUserId(String userId) ;
	public void update(PositionDepartment t) ;
	//根据人员ID获取部门ID
	public PositionDepartment getDepartmentIdByUserId(String userId);
}
