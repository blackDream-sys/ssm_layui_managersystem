package com.bdqn.service;

import com.bdqn.entity.Bill;
import com.bdqn.vo.BillVo;

import java.util.List;

public interface BillService {
    List<Bill> findBillList(BillVo billVo);
    int addBill(Bill bill);
    int updateBill(Bill bill);
    int deleteById(Integer id);
}
