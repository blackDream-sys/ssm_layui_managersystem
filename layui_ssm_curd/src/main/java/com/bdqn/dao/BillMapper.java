package com.bdqn.dao;

import com.bdqn.entity.Bill;
import com.bdqn.vo.BillVo;

import java.util.List;

public interface BillMapper {
    List<Bill> findBillList(BillVo billVo);
    int addBill(Bill bill);
    int updateBill(Bill bill);
    int deleteById(Integer id);
}
