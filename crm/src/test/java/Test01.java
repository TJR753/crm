import com.example.crm.settings.dao.UserDao;
import com.example.crm.settings.domain.User;
import com.example.crm.workbench.dao.ActivityDao;
import com.example.crm.workbench.dao.ActivityRemarkDao;
import com.example.crm.workbench.domain.Activity;
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
}
