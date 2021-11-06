package com.bdqn.service.impl;

import com.bdqn.dao.BillMapper;
import com.bdqn.entity.Bill;
import com.bdqn.service.BillService;
import com.bdqn.vo.BillVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
@Service
@Transactional//业务层实现类上加事务注解
public class BillServiceImpl implements BillService {
    @Resource
    private BillMapper billMapper;
    @Override
    public List<Bill> findBillList(BillVo billVo) {
        return billMapper.findBillList(billVo);
    }

    @Override
    public int addBill(Bill bill) {
        return billMapper.addBill(bill);
    }

    @Override
    public int updateBill(Bill bill) {
        return billMapper.updateBill(bill);
    }

    @Override
    public int deleteById(Integer id) {
        return billMapper.deleteById(id);
    }
}
