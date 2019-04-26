package cn.rails.ims.core.service.workflow;

import cn.rails.ims.utils.workflow.WorkFlowException;


/**
 * <p>Title      : 中国铁道科学研究院流程管理平台[流程管理]</p>
 * <p>Description: [H3BPM 流程相关接口]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-06
 */
public interface WorkFlowService {
	/**
	 * 启动流程
	 * @param workflowCode 流程编码
	 * @param userAlias 用户编码
	 * @param finishStart 是否结束第一个审批节点
	 * @param xmlData xml格式数据 点击接口定义具体查看用法：…… <XmlDataList><contract_importance>1</contract_importance><is_outside>1</cgwis_outsidelmc></XmlDataList>
	 * @throws WorkFlowException 流程异常
	 */
	public String StartWorkflowWithXmlData(String workflowCode,String userAlias,
			boolean finishStart,String xmlData,String instanceName) throws WorkFlowException;
	
	/**
	 * 转发流程（设置某个工作任务转办A->B，B提交后直接往下走）
	 * @param workItemId 工作实例ID
	 * @param userCode 操作者编码	
	 * @param commentText 转发意见
	 * @param participant 代办人编码
	 * @throws WorkFlowException 流程异常
	 * @return boolean 是否转发成功
	 */
	public boolean adjustWorkflow(String workItemId, String userCode,
			String commentText, String participant) throws WorkFlowException;
	
	/**
	 * 结束流程
	 * @param userCode 操作者编码	
	 * @param instanceId 流程实例ID
	 * @throws WorkFlowException 流程异常
	 * @return boolean 是否成功
	 */
	public boolean finishInstance(String userCode, String instanceId)
			throws WorkFlowException;
	
	/**
	 * 提交流程
	 * @param userCode 用户编码
	 * @param workItemIds 工作任务节点ID，用逗号分隔	
	 * @param activityCode 指定激活的节点（不能为空）
	 * @param participant 代办人编码,若为空取流程默认配置
	 * @param signature 签章信息
	 * @param commentText 审批意见
	 * @throws WorkFlowException 流程异常
	 * @return boolean 是否转发成功
	 */
	public boolean submitWorkItem(String userCode, String workItemIds,
			String activityCode, String participant, String signature,
			String commentText) throws WorkFlowException;

	/**
	 * 驳回流程
	 * @param userCode 用户编码
	 * @param workItemId 工作任务节点ID，用逗号分隔	
	 * @param commentText 审批意见
	 * @param type 驳回类型（1：驳回到起始节点 2：驳回到上个节点 3：驳回到指定节点）
	 * @param activityCode 当type为3时，驳回到指定节点，其他类型为空
	 * @param signature 签章信息
	 * @param participant 取回任务的参与者（默认参与者为上一步完成者，多人参与逗号分隔）
	 * @throws WorkFlowException 流程异常
	 * @return boolean 是否转发成功
	 */
	public boolean returnItem(String userCode, String workItemId, String commentText,
			String type, String activityCode, String signature)
			throws WorkFlowException;
	/**
	 * 获取下一节点信息
	 * @param workItemId 工作任务节点ID
	 * @throws WorkFlowException 流程异常
	 */
	public String getNextNode(String workItemId) throws WorkFlowException;

	/**
	 * 获取用户的任务列表
	 * @param userCode 用户编码(为空则查询所有用户)
	 * @param pageSize 每页显示数据量(pageSize，pageIndex，同时为0显示全部)
	 * @param pageIndex 当前页码，从1开始(pageSize，pageIndex，同时为0显示全部)，
	 * @param workflowCode 流程编码（为空则显示全部）
	 * @param state 类型（1待办，2已办）
	 * @param activityCodes 流程节点（为空则显示全部）
	 * @throws WorkFlowException 流程异常
	 */
	public String getWorkItem(String userCode, String pageSize, String pageIndex,
			String workflowCode, String state, String activityCodes)
			throws WorkFlowException;

	
	
	
}
