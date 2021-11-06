package com.bdqn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller//不用加RestController，因为不用返数据了
public class PageController {
    //跳转index首页，备注：登录成功，在前端页面有跳转代码
    @RequestMapping("/index")
    public String toIndex(){
        return "index";
    }
}
