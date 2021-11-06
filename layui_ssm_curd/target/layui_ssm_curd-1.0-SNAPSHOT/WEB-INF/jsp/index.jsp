<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<%--    页面跳转：运行就到log.jsp，登录成功就到index.jsp，其实是web.xml里面配的运行就到login.jsp，在login.jsp页面根据post请求来到userController登录方法，在login.jsp页面成功就跳转到index.jsp--%>
    <title>账单列表</title>
<%--    重点是引入layui.js（body里面有），和layui.css;结合layui官方文档做,https://www.layuiweb.com/doc/index.htm--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
<%--    调整页面id左边的所有复选框位置--%>
    <style>
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
            top: 50%;
            transform: translateY(-50%);
        }
    </style>
</head>
<body>

<!-- 标题 -->
<h1 align="center">帐单列表</h1>

<!-- 查询条件开始 -->
<div style="width: 80%;margin-left: 100px;text-align: center">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
        <legend>搜索条件</legend>
    </fieldset>
<%--    Get和post区别
    GET请求在URL中传送的参数是有长度限制的，而POST么有。
    Get请求会把参数显示在浏览器url位置，不安全，post不会
    GET参数通过URL传递，POST放在Request body中。--%>
    <form class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">账单类型</label>
                <div class="layui-input-inline">
<%--                    下拉框要显示内容，最后要加上form的方法调用select。。。。--%>
                    <select name="typeId" class="layui-input">
                        <option value="">请选择账单类型</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">开始日期</label>
                <div class="layui-input-block">
<%--                    name和实体类写一样，name和id都可以在前端用js，jq调用；id和name写一样最好--%>
                    <input type="text" name="startDate" id="startDate" readonly autocomplete="off" class="layui-input" placeholder="请选择开始时间">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">结束日期</label>
                <div class="layui-input-block">
                    <input type="text" name="endDate" id="endDate" readonly autocomplete="off" class="layui-input" placeholder="请选择结束时间">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
<%--                搜索按钮提交用lay-submit lay-filter="doSearch"--%>
                <button class="layui-btn" lay-submit lay-filter="doSearch">搜索</button>
                <button type="reset" class="layui-btn layui-btn-warm">重置</button>
            </div>
        </div>
    </form>
</div>
<!-- 查询条件结束 -->

<!-- 数据表格开始 -->
<div style="width: 80%;margin-left: 100px">
    <!-- 表格 -->
<%--    id="billTable" lay-filter="billTable"最好写一样，调用form用lay-filter="billTable"，id调用根据layui文档使用--%>
    <table class="layui-hide" id="billTable" lay-filter="billTable"></table>

    <!-- 头部工具栏 -->
<%--    根据id="billToolbar"操作头部工具栏--%>
    <script type="text/html" id="billToolbar">
        <div class="layui-btn-container">
<%--            根据lay-event="add"操作添加按钮，<i></i>添加按钮前面的小图标--%>
            <button class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-circle"></i>添加账单</button>
            <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="batchDelete"><i class="layui-icon layui-icon-delete"></i>批量删除</button>
        </div>
    </script>
    <!-- 行工具栏 -->
    <script type="text/html" id="billRowBar">
        <button class="layui-btn layui-btn-xs" lay-event="edit">编辑</button>
<%--        layui-btn-xs是设置按钮尺寸--%>
        <button class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</button>
    </script>

</div>
<!-- 数据表格结束 -->

<!-- 添加和修改账单的弹出层开始 -->
<div id="addOrUpdateBillDiv" style="display: none;margin: 10px">
<%--    根据lay-filter="dataFrm"操作表单--%>
    <form id="dataFrm" method="post" class="layui-form  layui-form-pane" lay-filter="dataFrm">
        <!-- hidden看不见，前端页面添加和修改页面不需要看id -->
        <input type="hidden" name="id">
        <div class="layui-form-item">
            <label class="layui-form-label">帐单类型</label>
            <div class="layui-input-block" id="billTypeDiv">
<%--                lay-verify="required"验证必填--%>
                <select name="typeId" class="layui-input" lay-verify="required" lay-reqText="请选择账单类型">
                    <option value="">请选择账单类型</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">帐单标题</label>
            <div class="layui-input-block">
                <input type="text" name="title" placeholder="请输入账单标题" lay-verify="required" lay-reqText="请输入账单标题"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">账单时间</label>
            <div class="layui-input-block">
                <input type="text" name="billTime" id="billtime" readonly="readonly" lay-reqText="请输入选择账单时间"   placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">帐单金额</label>
            <div class="layui-input-inline">
                <input type="text" name="price"   lay-verify="number" placeholder="请输入账单金额"  lay-reqText="请输入账单金额"   autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">帐单备注</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入帐单备注" name="remark" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit">提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<!-- 添加和修改账单的弹出层结束-->



<script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
<script>
    // 'form','jquery'操作时以$显示,'table','laydate','layer'弹出层；这些要用到先use出来
    layui.use(['form','jquery','table','laydate','layer'],function () {
        var form = layui.form;
        var $ = layui.jquery;
        var table = layui.table;
        var laydate = layui.laydate;
        var layer = layui.layer;

       /* //渲染日期组件，不然前端点不了
        laydate.render({
            elem:"#startDate",
        });*/
        laydate.render({
            elem:"#startDate"
        });
        laydate.render({
            elem:"#endDate"
        });
        // type格式
        laydate.render({
            elem:"#billtime",
            type:"datetime"
        });

  /*      //发送Ajax请求查询账单类型
        $.get("/billType/list",function(result){
            var html = "";
            //循环遍历集合
            for (let i = 0; i < result.length; i++) {
                html +="<option value='"+result[i].id+"'>"+result[i].name+"</option>"
            }
            //将网页代码追加到下拉列表中
            $("[name='typeId']").append(html);
            //更新渲染select下拉框
            form.render("select");
        },"json");*/
        $.get("/billType/list",function(result){
            // 前端按F12看console页面打印内容
            console.log(result);
            var html="";
            for (let i=0;i<result.length;i++){
                //账单的下拉列表
                html+="<option value='"+result[i].id+"'>"+result[i].name+"<option>"
            }
            // name属性追加html弄成下拉列表
            $("[name='typeId']").append(html);
            //上面有注释，代码写完了，但下拉列表没有内容，就是要加这行才显示
            form.render("select");
        },"json");


        //渲染表格组件，tableIns接收，下面要用
        var tableIns = table.render({
            elem:"#billTable",//绑定表格元素，推荐使用ID选择器，filter里面的
            url:"/bill/list",//异步请求地址,加入分页后，默认使用page(当前页码)和limit(每页显示数量)作为参数名称
            page:true,//开启分页
            toolbar:"#billToolbar",//头部工具栏的id
            cols: [[ //表头
                //field属性：字段属性，该属性与实体类的属性名一致
                //title属性：表头文本
                {type:"checkbox",fixed:"left",width:80,align:"center"},
                {field: 'id', title: 'ID',align:"center"}
                ,{field: 'title', title: '账单标题',align:"center"}
                // 把typeId改成typeName，因为要把数字变成汉字，一目了然，后端代码有提到
                ,{field: 'typeName', title: '账单类型',align:"center"}
                ,{field: 'price', title: '账单金额',align:"center"}
                ,{field: 'billTime', title: '创建时间',align:"center"}
                ,{field: 'remark', title: '备注',align:"center"}
                // 添加一行加上编辑和删除按钮
                ,{title:"操作",toolbar: "#billRowBar",align:"center"}
            ]]
        });

     /*   //监听搜索按钮提交事件,filter里面的doSearch
        form.on("submit(doSearch)",function (data) {
            tableIns.reload({
                where:data.field,//查询条件
                page:{
                    curr:1
                }
            });
            //禁止页面刷新
            return false;
        });*/
        form.on("submit(doSearch)",function (data) {
            console.log(data);
/*
            $.get("",{},function (result) {

            },"json")

*/
            //不用get请求，下面是layui文档里面的格式
            tableIns.reload({
                where:data.field,
                page:{
                    curr:1
                }
            });
            console.log(data.field);
            //页面局部刷新return false
            return false;
        });


        // //监听表格头部工具栏事件
        // table.on("toolbar(billTable)",function (obj) {
        //     switch (obj.event) {
        //         //添加
        //         case 'add':
        //             openAddWindow();
        //             break;
        //         //批量删除
        //         case 'batchDelete':
        //             batchDelete();
        //             break;
        //     }
        // }
        // 用的id="billTable"
        table.on("toolbar(billTable)",function(obj){
            console.log(obj);
            //event就是样式里面写的layui-event
            switch (obj.event) {
                case 'add':
                    //下面写这个方法
                    openAddWindow()
                    //一定加break
                    break;
                case 'batchDelete':
                    batchDelete();
                    break;
            }
        });

        // //监听表格行工具栏事件
        // table.on("tool(billTable)",function (obj) {
        //     switch (obj.event) {
        //         //编辑
        //         case 'edit':
        //             openUpdateWindow(obj.data);
        //             break;
        //         //删除
        //         case 'delete':
        //             deleteById(obj.data);
        //             break;
        //     }
        // });
        table.on("tool(billTable)",function (obj) {
            console.log(obj);
            switch(obj.event){
                case 'edit':
                    openUpdateWindow(obj.data);
                    break;
                case "delete":
                    deleteById(obj.data);
                    break;
            }
        });


        var url;//提交地址，添加和编辑调这个url，在下面根据编辑或添加方法写了这个url的路径
        var mainIndex;//窗口索引，添加或编辑完调这个关掉弹出框

        // /**
        //  * 打开添加窗口，content根据id=addOrUpdateBillDiv
        //  */
        // function openAddWindow() {
        //     mainIndex =layer.open({
        //         type:1,//弹出层类型
        //         title:"添加账单",
        //         area: ['800px', '600px'],
        //         content:$("#addOrUpdateBillDiv"),//引用的窗口代码
        //         success:function () {
        //             //清空表单数据
        //             $("#dataFrm")[0].reset();//JavaScript中的方法
        //             url = "/bill/addBill";
        //         }
        //     });
        // }
        function openAddWindow(){
            mainIndex=layer.open({
                //1是弹出页面
                type:1,
                title:"添加账单",
                area:['800px','600px'],
                content:$("#addOrUpdateBillDiv"),
                success:function () {
                    // js方法将表单内容清空，方便填数据
                    $("#dataFrm")[0].reset();
                    url="/bill/addBill";
                }
            });
        }

     /*   /!**
         * 打开编辑窗口
         *!/
        function openUpdateWindow(data) {
            mainIndex =layer.open({
                type:1,//弹出层类型
                title:"修改账单",
                area: ['800px', '600px'],
                content:$("#addOrUpdateBillDiv"),//引用的窗口代码
                success:function () {
                    //表单数据回显
                    form.val("dataFrm",data);
                    //修改请求
                    url = "/bill/updateBill";
                }
            });
        }*/
        function openUpdateWindow(data){
            mainIndex=layer.open({
                type:1,
                title:"修改账单",
                area:['800px','600px'],
                content:$("#addOrUpdateBillDiv"),
                success:function () {
                    //回显数据，方便编辑
                    form.val("dataFrm",data);
                    url="/bill/updateBill";
                }
            });
        }


       /* //监听添加的表单提交事件
        form.on("submit(doSubmit)",function (data) {
            $.post(url,data.field,function(result){
                if(result.success){
                    layer.alert(result.message,{icon:1});
                    //关闭窗口
                    layer.close(mainIndex);
                    //刷新数据表格
                    tableIns.reload();
                }else{
                    layer.alert(result.message,{icon:2});
                }
            },"json");
            return false;
        });*/
        form.on("submit(doSubmit)",function (data) {
            //下面调用url，是添加就进添加页面，是编辑就进编辑页面，两者区别就是一个显示数据来编辑，清空数据来添加
            //data就是后端传过来的所有账单数据，post请求时用data.field来把账单数据显示在页面
            //result就是后端map集合里面的success：true、false；message：添加成功、添加失败（也适用编辑）
            $.post(url,data.field,function (result) {
               if (result.success){
                   //弹出添加成功框，icon是前面小图标
                   layer.alert(result.message,{icon:1});
                   //关闭弹出框
                   layer.close(mainIndex);
                   //编辑或添加完，刷新操作后的数据显示在页面
                   tableIns.reload();
               } else {
                   layer.alert(result.message,{icon:2});
               }
               //加上json格式
            },"json")
            return false;
        });

        // /**
        //  * 删除账单
        //  * @param data  当前行数据
        //  */
        // function deleteById(data) {
        //     //提示用户确认是否删除
        //     layer.confirm("确定要删除[<font color='red'>"+data.title+"</font>]账单吗？",{icon:3,title:"提示"},function (index) {
        //         //发送ajax请求
        //         $.post("/bill/deleteById",{"id":data.id},function(result){
        //             if(result.success){
        //                 layer.alert(result.message,{icon:1});
        //                 //刷新数据表格
        //                 tableIns.reload();
        //             }else{
        //                 layer.alert(result.message,{icon:2});
        //             }
        //         },"json");
        //
        //         //关闭提示框
        //         layer.close(index);
        //     });
        // }
        function deleteById(data){
        //index关闭弹窗用
            layer.confirm("确定要删除[<font color='red'>"+data.title+"</font>]账单么?",{icon:3,title:"提示"},function (index) {
                $.post("/bill/deleteById",{"id":data.id},function (result) {
                    if (result.success){
                        layer.alert(result.message,{icon:1});
                        tableIns.reload();
                    } else {
                        layer.alert(result.message,{icon:2});
                    }
                },"json");
                layer.close(index);
            })
        }

        // /**
        //  * 批量删除
        //  */
        // function batchDelete() {
        //     //获取表格对象
        //     var checkStatus = table.checkStatus('billTable'); //billTable 即为基础参数 id 对应的值
        //     //判断是否有选中行
        //     if(checkStatus.data.length>0){
        //         //定义数组，保存选中行的ID
        //         var idArr = [];
        //         //循环遍历获取选中行(目的是获取选中的每一行的ID值)
        //         for (let i = 0; i < checkStatus.data.length; i++) {
        //             //将选中的ID值添加到数组的末尾
        //             idArr.push(checkStatus.data[i].id);
        //         }
        //         //将数组转成字符串
        //         var ids = idArr.join(",");
        //         //提示用户是否删除
        //         layer.confirm("确定要删除这<font color='red'>"+checkStatus.data.length+"</font>条数据吗？",{icon:3,title:"提示"},function (index) {
        //             //发送ajax请求
        //             $.post("/bill/batchDelete",{"ids":ids},function(result){
        //                 if(result.success){
        //                     layer.alert(result.message,{icon:1});
        //                     //刷新数据表格
        //                     tableIns.reload();
        //                 }else{
        //                     layer.alert(result.message,{icon:2});
        //                 }
        //             },"json");
        //
        //             //关闭提示框
        //             layer.close(index);
        //         });
        //
        //
        //     }else{
        //         layer.msg("请选择要删除的数据");
        //     }
        //
        // }

        function batchDelete() {
            //获取表格对象
            var checkStatus = table.checkStatus('billTable'); //billTable 即为基础参数 id 对应的值
            //判断是否有选中行
            if (checkStatus.data.length > 0) {
                //定义数组，保存选中行的ID
                var idArr = [];
                //循环遍历获取选中行(目的是获取选中的每一行的ID值)
                for (let i = 0; i < checkStatus.data.length; i++) {
                    //将选中的ID值添加到数组的末尾
                    idArr.push(checkStatus.data[i].id);
                    console.log(idArr);
                }
                //这一行打印可以看到，idArr是保存所有选中的账单的id
                console.log(idArr);
                //这一行方便数组转成字符串，在后端调用，billController里面有与这个对应的
                var ids=idArr.join(",");
                //index对应508关掉弹出窗口
                layer.confirm("确定要删除这<font color='red'>"+checkStatus.data.length+"</font>条数据吗？",{icon:3,title:"提示"},function (index) {
                   //ids对应496行。后端：在BillController参数里面也写ids，参数类型用String
                    $.post("/bill/batchDelete",{"ids":ids},function (result) {
                        if(result.success){
                            layer.alert(result.message,{icon:1});
                            tableIns.reload();
                        }else{
                            layer.alert(result.message,{icon:2});
                        }
                    },"json");
                    layer.close(index);
                });
            }
        }


    });




</script>


</body>
</html>
