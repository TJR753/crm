package com.example.crm.settings.web.listener;

import com.example.crm.settings.domain.DicValue;
import com.example.crm.settings.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.List;
import java.util.Map;
import java.util.Set;

@WebListener
public class DicInitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ClassPathXmlApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        DicService dicService = (DicService)ac.getBean("dicServiceImpl");
        System.out.println("初始化上下文作用域对象");
        ServletContext servletContext = sce.getServletContext();
        //map(code,List<DicValue>)
        Map<String, List<DicValue>> map=dicService.getAll();
        Set<String> keySet = map.keySet();
        for(String key:keySet){
            servletContext.setAttribute(key,map.get(key));
        }
    }
}
