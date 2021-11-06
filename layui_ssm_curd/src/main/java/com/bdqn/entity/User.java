package com.bdqn.entity;

import lombok.Data;

@Data
public class User {//用户
    private Integer id;
    private String userName;
    private String loginName;
    private String pwd;
    private String sex;
}

