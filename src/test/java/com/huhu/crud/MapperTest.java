package com.huhu.crud;

import com.huhu.crud.bean.Department;
import com.huhu.crud.bean.Employee;
import com.huhu.crud.dao.DepartmentMapper;
import com.huhu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

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

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
        /*
        // 创建spring IOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        // 从容器中获取mapper
        ioc.getBean(DepartmentMapper.class);
        */
        System.out.println(departmentMapper);

        // 测试部门，加入几个部门数据
        //departmentMapper.insertSelective(new Department(null, "开发部"));
        //departmentMapper.insertSelective(new Department(null, "测试部"));

        // 测试员工，插入几个员工数据
        //employeeMapper.insertSelective(new Employee(null, "huhu", "男", "252@qq.com", 2));
        //employeeMapper.insertSelective(new Employee(null, "rebecca", "女", "1213@163.com", 1));

        // 批量插入多个员工，使用可批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0; i<1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid+"@163.com", 1));
        }
        System.out.println("批量完成");


    }
}
