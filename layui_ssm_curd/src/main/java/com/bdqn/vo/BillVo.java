package com.bdqn.vo;

import com.bdqn.entity.Bill;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class BillVo extends Bill {//账单扩展类，配合前端增加开始和结束日期，page，limit。来搜索
    private Integer page;
    private Integer limit;
    @DateTimeFormat(pattern = "yyyy-MM-dd")//前端传后端时间格式，不写报错，只需年月日
    @JsonFormat(pattern = "yyyy-MM-dd")//后端传前端时间格式，不写报错
    private Date startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")//前端传后端时间格式，不写报错，只需年月日
    @JsonFormat(pattern = "yyyy-MM-dd")//后端传前端时间格式，不写报错
    private Date endDate;

    //前端有代码写日期格式，type类型选择
//            laydate.render({
//        elem:"#startDate"
//    });
//        laydate.render({
//        elem:"#endDate"
//    });
//        laydate.render({
//        elem:"#billtime",
//                type:"datetime"
//    });
}
