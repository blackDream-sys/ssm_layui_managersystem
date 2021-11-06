package com.bdqn.controller;

import com.alibaba.fastjson.JSON;
import com.bdqn.entity.User;
import com.bdqn.service.UserService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {
    @Resource
    UserService userService;
    //登录
    @RequestMapping("/login")
    public String login(String loginName, String password, HttpSession session){
        Map<String, Object> map = new HashMap<String,Object>();
        User loginUser = userService.login(loginName, password);
        if (loginUser!=null){
            session.setAttribute("loginUser",loginUser);//session存起来
            map.put("success",true);
        }else{
            map.put("success",false);
        }
        return JSON.toJSONString(map);
    }

}
