package com.bdqn.service.impl;

import com.bdqn.dao.UserMapper;
import com.bdqn.entity.User;
import com.bdqn.service.UserService;
import com.bdqn.utils.PasswordUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Transactional
@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;
    @Override
    public User login(String loginName, String password) {//传用户名，密码，返回User对象
        User user = userMapper.findUserByLoginName(loginName);
        if (user!=null){
            String newPassword = PasswordUtil.md5(password, user.getLoginName(), 5);//md5加密密码
            if (user.getPwd().equals(newPassword)){
                return user;
            }
        }
        return user;
    }
}
