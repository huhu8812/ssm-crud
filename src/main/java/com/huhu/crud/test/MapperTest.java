package com.huhu.crud;

import com.huhu.crud.dao.DepartmentMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试dao层
 *
 * 推荐spring项目使用spring的单元测试，可以自动注入我们需要的组件
 * 1、导入springtest模块
 * 2、@ContextConfiguration指定spring配置文件的位置
 * 3、直接autowire 要使用的组件
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Test
    public void testCRUD() {
        /*
        // 创建spring IOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        // 从容器中获取mapper
        ioc.getBean(DepartmentMapper.class);
        */
        System.out.println(departmentMapper);

    }
}
