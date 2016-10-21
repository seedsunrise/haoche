package com.haoche.bos.util;

/**
 * Created By : CHen fei
 */
public class DictEnum {

	//API 全局返回code
	public static final String success_code = "1000";
	public static final String fail_code = "1001";


	//车辆完成与否状态
	public static class carAction{
		public static final int CA_CANCEL = 0;//已经取消
		public static final int CA_NOCOMPLETE = 1;//未完成
		public static final int CA_COMPLETE = 2;//已完成
	}


	//全局保存
	public static class Save{
		public static final String save_success = "保存成功";
		public static final String save_fail = "保存失败";
	}

	//邮件发送
	public static class Email{
		public static final String send_success = "邮件发送成功";
		public static final String send_fail = "邮件发送失败";
	}

	//系统设置
	public static class System{
		public static final String pdt = "漆面检测临界值";
	}

	//车辆检测状态
	public static class CarIdentify{
		public static final int IDENTIFY_NO = 1;
		public static final int IDENTIFY_START = 0;
		public static final int IDENTIFY_COMPLETE = 2;
	}

	//默认Id
	public static class DefaultID{
		public static final String DNYQ_CHECKID = "48";
		public static final String DNYQ_GROUPID = "3333";
		public static final String QMJC_GROUPID = "2222";
		public static final String WFZ_GROUPID = "0";
		//public static final String JDSADMIN_GROUPID = "13";//鉴定师管理员角色ID（78测试环境）
		public static final String JDSADMIN_GROUPID = "23";//鉴定师管理员角色ID（产品环境）
		public static final String SUPER_ADMIN_ID = "1";//超级管理员用户ID

		public static final String ZCMK_CHECKID = "63";
		public static final String YCMK_CHECKID = "69";

		public static final String JIANCUNXUAN_USERID = "8";//jiancunxuan用户ID（产品环境）
		//public static final String JIANCUNXUAN_USERID = "8";//jiancunxuan用户ID（78测试环境）

	}

	//单选，多选，输入
	public static class CheckChildType{
		public static final int SINGLE =0;
		public static final int MC = 1;
		public static final int INPUT = 2;
	}

	//检查项分类大项
	public static class OptionType{
		public static final String OPTION_SG = "sg";//事故
		public static final String OPTION_DETAIL_DNDM = "dndm";//电脑代码
		public static final String OPTION_DETAIL_SCGJ = "scgj";//随车工具
		public static final String OPTION_DETAIL_LS = "ls";//路试
	}

	//分数
	public static class Score{
		public static final double TOTAL_SCORE = 100;
	}

	//费用
	public static class Expenses{
		public static final double JR_SERVICE_EXP = 3300;//金融服务费
	}

	public static class identifyType{
		public static final int IDENTIFY_ONLINE = 1;//在线鉴定
		public static final int IDENTIFY_OFFLINE = 9;//离线鉴定
	}

	public static class licenseSelectType{
		public static final int BYPHONE =1 ;//电话选号
		public static final int BYUSER = 9;//客户自选
	}
}
