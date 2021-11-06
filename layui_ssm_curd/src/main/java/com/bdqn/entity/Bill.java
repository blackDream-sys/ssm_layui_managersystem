package com.bdqn.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data//生成getter，setter，toString等方法
public class Bill {//账单
    private Integer id;
    private String title;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")//前端传后端时间格式，不写报错
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")//后端传前端时间格式，不写报错
    private Date billTime;
    private Integer typeId;
    private Double price;
    private String remark;

    private String typeName;//增加一个账单名字字段，账单类型实体类也有这个，原
    // 因是把前端页面上账单类型的数字弄成汉字，一目了然。通过在前端表格方法代码中把typeId改成typeName
}
