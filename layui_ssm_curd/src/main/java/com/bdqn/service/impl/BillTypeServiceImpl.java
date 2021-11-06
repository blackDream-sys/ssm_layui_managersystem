package com.bdqn.service.impl;

import com.bdqn.dao.BillTypeMapper;
import com.bdqn.entity.BillType;
import com.bdqn.service.BillTypeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
@Service
@Transactional
public class BillTypeServiceImpl implements BillTypeService {
    @Resource
    private BillTypeMapper billTypeMapper;
    @Override
    public List<BillType> findBillTypeList() {
        return billTypeMapper.findBillTypeList();
    }
}
