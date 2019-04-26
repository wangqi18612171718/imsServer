package cn.rails.ims.utils;
import java.util.Properties;
/**
 * <p>Title      : 中国铁道科学研究院业务流程管理平台[]</p>
 * <p>Description: []</p>
 * <p>Copyright  : Copyright (c) 2015</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-20
 */
public class Constant {
	public static Properties properties = ConfigUtil.properties;
	//根部门ID
	public static final String rootDepart=properties.getProperty("rootdepart");
	/**
	 * 是否删除
	 * @author sunyh
	 */
	public enum IsDelete{
		// 未删除 0
		YES(0),
		// 已删除 1
		NO(1);
		private int state;
		private IsDelete(int state){
			this.state = state;
		}
		public int getState() {
			return state;
		}
	}
	
	/**
	 * 返回状态
	 * @author sunyh
	 */
	public enum StatusCode{
		//不正常
		ERROR(0),
		//正常
		CORRECT(1);
		private int statusCode;
		private StatusCode(int statusCode){
			this.statusCode = statusCode;
		}
		public int getStatusCode() {
			return statusCode;
		}
	}
	
	/**
	 * 返回信息
	 * @author sunyh
	 */
	public enum Message{
		//新增失败
		ADDFAIL("新增失败"),
		ADDSUCCESS("add success"),
		//修改失败
		MODIFYFAIL("修改失败"),
		//修改成功
		MODIFYSUCCESS("修改成功"),
		//删除失败
		DELETEFAIL("删除失败"),
		//删除成功
		DELETESUCCESS("删除成功"),
		//操作失败
		FAIL("操作失败"),
		//操作成功
		SUCCESS("操作成功");
		private String msg;
		private Message(String msg){
			this.msg = msg;
		}
		public String getMsg() {
			return msg;
		}
	}
}

