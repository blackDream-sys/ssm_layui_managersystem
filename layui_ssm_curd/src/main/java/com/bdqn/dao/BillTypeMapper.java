package com.bdqn.dao;

import com.bdqn.entity.BillType;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface BillTypeMapper {
    @Select("select * from billtype")//也可以在xml写sql
    List<BillType> findBillTypeList();
}
