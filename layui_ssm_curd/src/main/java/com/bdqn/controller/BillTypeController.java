package com.bdqn.controller;

import com.bdqn.entity.BillType;
import com.bdqn.service.BillTypeService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/billType")
public class BillTypeController {
    @Resource
    private BillTypeService billTypeService;
    //查所有账单类型
    @RequestMapping("/list")
    public List<BillType> list(){
        return billTypeService.findBillTypeList();
    }
}
