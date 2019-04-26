package cn.rails.ims.core.service.system;
import java.util.List;

import cn.rails.ims.base.IBaseService;
import cn.rails.ims.core.entity.Department;
import cn.rails.ims.utils.page.Paramter;

/**
 * 
 * @author hzx
 * @date 2017年3月22日
 * @description 部门的实现层
 */
public interface DepartmentService extends IBaseService<Department>{
	List<Department> queryByCondition(String key,Object value);
	List<Object> getdeptIds(String DepartsmentId,String orders);
	
	//根据paramer查询数据
	List<Department> queryByCondition(Paramter par);
	List<Object> mysqlgetdeptIds(String DepartmentId, String orders);

}
