package com.bdqn.utils;

import lombok.Data;
import lombok.NoArgsConstructor;

//此类封装LayUI数据表格中返回的数据格式,要求这四个必须有
@Data
@NoArgsConstructor//无参，方便在下面只加两个参数
public class  DataGridViewResult {
    private Integer code=0;
    private String msg="";
    private Long count;
    private Object data;

    /**
     * 封装数据表格
     * @param count
     * @param data
     */
    public DataGridViewResult(Long count, Object data) {//code和msg可以不用管
        this.count = count;
        this.data = data;
    }
}
