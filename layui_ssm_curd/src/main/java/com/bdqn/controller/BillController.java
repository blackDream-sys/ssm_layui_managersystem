package com.bdqn.controller;

import com.alibaba.fastjson.JSON;
import com.bdqn.entity.Bill;
import com.bdqn.service.BillService;
import com.bdqn.utils.DataGridViewResult;
import com.bdqn.vo.BillVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*@RequestBody和@ResponseBody 区别
1.使用位置不一样，前者在参数前面，后者在方法上面
2.前者是将前端的参数名称和实体类的属性对应，并且要写一样，就调用实体类get方法在控制台输出前端返回信息
3.后者是返回json格式数据给前端*/

@RestController//等于@Controller和@ResponseBody(返回json格式数据)，支持前端页面无刷新
@RequestMapping("/bill")//路径映射
public class BillController {
    @Resource
    //@Resource和@Autowird区别
    /*
    @Resource按名称查找，找不到在按类型查找
    @Autowird只能按名称查找
    例子：
    private UserDao userdao;
    名称查找：就是通过userdao该属性名称在容器中查找id为userdao的bean。就是bean实体类对象
    类型查找：在容器中查找类型为UserDao的bean实体类。【通过全限定名】*/
    private BillService billService;
    /*查询所有账单*/
    @RequestMapping("/list")
    public DataGridViewResult list(BillVo billVo){//DataGridViewResult此类封装LayUI数据表格中返回的数据格式;参数为billvo，此类包含前端要查的所有数据。备注：继承了bill
        PageHelper.startPage(billVo.getPage(),billVo.getLimit());//当前页，每页多少条
        List<Bill> billList = billService.findBillList(billVo);//账单集合,传billVo而不是bill？因为要把前端页面page，limit，startDate，endDate封装
        PageInfo<Bill> pageInfo = new PageInfo<Bill>(billList);//根据账单集合拿到分页集合
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());//根据分页集合拿到总记录数和分页列表返回给前端
    }
    //添加账单
    @RequestMapping("/addBill")
    public String addBill(Bill bill){//参数bill就行
        Map<Object, Object> map = new HashMap<Object, Object>();//map集合存储成功失败key和value
        if (billService.addBill(bill)>0){
            map.put("success",true);
            map.put("message","添加成功");
        }else{
            map.put("success",false);
            map.put("message","添加失败");

        }
        return JSON.toJSONString(map);//json格式返回前端
    }
    //修改账单
    @RequestMapping("/updateBill")
    public String updateBill(Bill bill){//参数bill就行
        Map<Object, Object> map = new HashMap<Object, Object>();
        if (billService.updateBill(bill)>0){
            map.put("success",true);
            map.put("message","修改成功");
        }else{
            map.put("success",false);
            map.put("message","修改失败");

        }
        return JSON.toJSONString(map);
    }
    //根据删除
    @RequestMapping("/deleteById")
    public String deleteById(Integer id){//根据账单id删
        Map<Object, Object> map = new HashMap<Object, Object>();
        if (billService.deleteById(id)>0){
            map.put("success",true);
            map.put("message","删除成功");
        }else{
            map.put("success",false);
            map.put("message","删除失败");
        }
        return JSON.toJSONString(map);
    }
    //批量删除
    @RequestMapping("/batchDelete")
    public String batchDelete(String ids){//参数为多个账单的ids。字符串类型，因为前端如果返回数组类型，那这边用Integer[] ids接收，运行ids为空，不能批量删除
        Map<Object, Object> map = new HashMap<Object, Object>();
        int count = 0;
        String[] idsStr = ids.split(",");//把前端返回的ids用,分开成String类型的数组
       for (int i=0;i<idsStr.length;i++){
          count = billService.deleteById(Integer.valueOf(idsStr[i]));//转成Integer类型的idsStr[i],否则报错
          if (count>0){
              map.put("success",true);
              map.put("message","删除成功");
          }
       }
       if (count<=0){
           map.put("success",false);
           map.put("message","删除失败");
       }
        return JSON.toJSONString(map);
    }

}