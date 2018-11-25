package com.huhu.crud.controller;

/**
 * 处理和部门有关的请求
 */

import com.huhu.crud.bean.Department;
import com.huhu.crud.bean.Msg;
import com.huhu.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        List<Department> list =  departmentService.getDepts();
        return Msg.success().add("depts", list);
    }
}
