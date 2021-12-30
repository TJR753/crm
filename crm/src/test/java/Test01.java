import com.example.crm.settings.dao.UserDao;
import com.example.crm.settings.domain.User;
import com.example.crm.workbench.dao.ActivityDao;
import com.example.crm.workbench.dao.ActivityRemarkDao;
import com.example.crm.workbench.domain.Activity;
import com.example.crm.workbench.service.ClueService;
import com.example.crm.workbench.service.impl.ClueServiceImpl;
import com.example.crm.workbench.web.controller.ClueController;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class Test01 {
//    测试login
    @Test
    public void test01(){
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserDao userDao = (UserDao)ac.getBean("userDao");
        User user = userDao.login("zs", "123");
        System.out.println(user);
    }

    @Test
    public void test02(){
        try {
            System.out.println(Inet4Address.getLocalHost());
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }
    @Test
    public void test03() {
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        ActivityDao activityDao = (ActivityDao) ac.getBean("activityDao");
        HashMap<String, Object> map = new HashMap<>();
        map.put("skipCount",0);
        map.put("pageSize",2);
//        int total = activityDao.getTotal(map);
        List<Activity> pageList = activityDao.getPageList(map);
        for(Activity a:pageList){
            System.out.println(a);
        }
//        System.out.println(total);
    }

    @Test
    public void test04() {
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        ActivityDao activityDao = (ActivityDao) ac.getBean("activityDao");
        String[] ids={"2882966ebdba44ec8b62c2314ef0f15f","19deb086e0b14ef3b9aae6a477072244"};
        int i = activityDao.deleteActivity(ids);
        System.out.println(i);
    }
    @Test
    public void test05() {
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        ActivityRemarkDao activityRemarkDao = (ActivityRemarkDao) ac.getBean("activityRemarkDao");
        String[] ids={"2882966ebdba44ec8b62c2314ef0f15f","19deb086e0b14ef3b9aae6a477072244"};
        int i = activityRemarkDao.getActivityRemark(ids);
        System.out.println(i);
    }
    @Test
    public void test06(){
        int n=10;
        int x=1;
        while(n>0){
            x=(x+1)*2;
            n--;
        }
        System.out.println(x);
    }
    @Test
    public void test07(){
        //总人数
        int n=10;
        //剩余人数
        int left=n;
        //报数
        int x=1;
        //标记数组，是否出圈
        boolean[] flag=new boolean[n+1];
//        System.out.println(flag[0]);
        while(left!=1){
            for (int i = 1; i <= n; i++) {
                //报道三出圈
                if(x==3&&flag[i]==false){
                    flag[i]=true;
                    left--;
                    x=1;
                }else{
                    if(flag[i]==false){
                        x++;
                    }
                }
            }
        }
        for (int i = 1; i < flag.length; i++) {
            if(flag[i]==false){
                System.out.println(i);
            }
        }
    }
    @Test
    public void test08(){
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        ClueService clueServiceImpl = (ClueService) ac.getBean("clueServiceImpl");
        clueServiceImpl.save();
    }
}
