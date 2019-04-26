package cn.rails.ims.utils;

import java.util.Properties;

public class Constants {
	public static Properties properties = ConfigUtil.properties;
	//系统TITLE
	public static final String TITLE_STRING=properties.getProperty("title");
	//管理员角色ID
	public static final String AdminRoleId = properties.getProperty("adminRoleId");
	//用户管理权限ID 
	public static final String manageRoleId=properties.getProperty("manageRoleId");
	//文件上传下载路径
	public static final String linuxPathString = properties.getProperty("uploadPath");
	public static final String uploadPath=properties.getProperty("uploadPath");
	//后台服务的IP配置
	public static final String DOMAIN = properties.getProperty("DOMAIN");//获取配置文件的domain
	
	
	
	public static final String D_BACKSLASH = properties.getProperty("D_BACKSLASH");
	
	//极光推送
	public static final String masterSecret = "4e60613c7bf3f909313e6df8";
	public static final String appKey = "d75efbd6881b3b08164d7b86";
	
	public enum MessageInfo{
		/**
		 * 新任务提示
		 */
		NEW_TASK("您有一条新任务,注意查收!");
		
		private String message;
		
		private MessageInfo(String message){
			this.message = message;
		}

		public String getMessage() {
			return message;
		}
	}
}
