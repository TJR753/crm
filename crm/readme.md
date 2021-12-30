$.ajax({
url:"",
data:"",
dataType:"",
type:"get",
success:function (data){
在这里进行修改
				}
			})
http://127.0.0.1:8080/crm/login.jsp
1. 关键字
    * add/create：跳转到添加页或者保存操作
    * save：执行添加操作
    * edit：跳转到修改页，或者打开修改的模态窗口
    * update：修改操作
    * get：查询操作
    * delete:删除操作
    * 特殊操作：login，登录
2. 登录功能
    * 验证账号密码
    select \* from tbl_user where loginAct=? and loginPwd=?
    * 验证失效时间,锁定状态,ip地址
      1. expireTime;//失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。
      2. lockState;//锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。
      3. allowIps;//允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，
      采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。
    * 登录页面,login.jsp
      1. 加载页面,聚焦用户名
      2. 回车确认
      3. 验证账号密码,显示错误信息
      4. 使用127.0.0.1访问
3. 市场活动
    * tbl_activity 市场活动
      tbl_activity_remark 市场活动备注
      一对多的关系
    * 市场活动的CRUD
    * 市场活动备注的CRUD
4. 线索模块
   * 线索模块相关表
     tbl_clue 线索表
     tbl_clue_remark 线索备注表
     tbl_clue_activity_relation 线索和市场活动关联关系表
   * 客户模块相关表
      tbl_customer 客户表
      tbl_customer_remark 客户备注表
   * 联系人模块相关表
      tbl_contacts 联系人相关表
      tbl_contacts_remark 联系人备注表
      tbl_contacts_activity_relation 联系人和市场活动关联表
   * 交易模块相关表
      tbl_tran 交易表
      tbl_tran_remark 交易备注表
      tbl_tran_history 交易历史表
   * 数据字典
      tbl_dic_type 字典类型表
      tbl_dic_value 字典值表
   服务器缓存+数据字典,使用监听器技术,数据字典按照typeCode进行分类
   
 
