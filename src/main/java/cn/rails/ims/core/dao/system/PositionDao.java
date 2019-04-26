/**
 * 
 */
package cn.rails.ims.core.dao.system;

import java.util.List;

import cn.rails.ims.base.IBaseDao;
import cn.rails.ims.core.entity.Position;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

/**
 * 
 * @author hzx
 * @date 2017年3月22日
 * @description 岗位DAO层
 */
public interface PositionDao extends IBaseDao<Position>{
	public List<Object> getdeptIds(String departmentId,String orders);
	
	//根据paramer查询数据
	public List<Position> queryByCondition(Paramter par);

	public List<Object> MySQLgetdeptIds(String departmentId, String orders);

}
