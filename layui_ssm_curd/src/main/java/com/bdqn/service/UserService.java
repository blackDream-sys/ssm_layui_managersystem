package com.bdqn.service;

import com.bdqn.entity.User;

public interface UserService {
    User login(String loginName,String password);
}
