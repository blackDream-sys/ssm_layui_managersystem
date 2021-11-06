package com.bdqn.dao;

import com.bdqn.entity.User;
import org.apache.ibatis.annotations.Select;

public interface UserMapper {
    @Select("select * from user where loginName=#{loginName}")
    User findUserByLoginName(String loginName);
}
