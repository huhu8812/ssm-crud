package com.huhu.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.huhu.crud.bean.Employee;
import com.huhu.crud.bean.Msg;
import com.huhu.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理员工CRUD请求
 */

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据（分页查询）
     * @return
     */

    @RequestMapping(value = "/emps")
    @ResponseBody //需要导入jackson包
    public Msg getEmpsWithAjax(@RequestParam(value = "pn", defaultValue = "1")Integer pn) {
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        // 在查询之前只需调用，传入页码，及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用PageInfo包装查询后的结果，只需将pageInfo交给页面就行了
        // 它封装了详细的分页信息，包括查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 保存员工信息
     * @param employee
     * @return
     */

    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.saveEmp(employee);
        return Msg.success();
    }


    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model) {
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        // 在查询之前只需调用，传入页码，及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用PageInfo包装查询后的结果，只需将pageInfo交给页面就行了
        // 它封装了详细的分页信息，包括查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "/list";
    }
}
