<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/assets/img/favicon.ico">

    <title>CCFSXU会员管理系统</title>

    <!-- Bootstrap core CSS -->
    <link href="/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/assets/css/my/dashboard.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
	
	<jsp:include page="/all/header.jsp"></jsp:include>
	
  	<div class="container-fluid">
      <div class="row">
        <!-- start left nav -->
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li><a href="#" style="color: #000;cursor: default;">
              <h4 class="sub-header">会员信息</h4></a>
            </li>
            <li><a href="/master/selectMemberInfo" >查询会员信息</a></li>
            <li><a href="/master/insertMemberInfo">录入会员信息</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="#" style="color: #000;cursor:default;">
              <h4 class="sub-header">CSP管理</h4></a>
            </li>
            <li><a href="/master/selectCSPScore">查询CSP成绩</a></li>
            <li class="active"><a href="/master/insertCSPScore">录入CSP成绩</a></li>
            <li><a href="/master/managerCSPApplication">CSP报名管理</a></li>
            <li><a href="/master/analysisCSPScore">会员进步状况分析</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="#" style="color: #000;cursor:default;">
              <h4 class="sub-header">图书馆</h4></a>
            </li>
            <li><a href="/master/selectBookInfo">查询图书信息</a></li>
            <li><a href="/master/borrowBook">借书</a></li>
            <li><a href="/master/backBook">还书</a></li>
          </ul>
        </div>
        <!-- end left nav -->
        
        <!-- start content -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">CSP管理</h1>
          <h4 class="sub-header">录入CSP成绩</h4>

          <div>
            <b>注意事项：</b><br>
            1、导入时，请按照模板文件格式导入，否则无法导入。<a href="/excel/templateScore.xls">下载模板</a><br>
            2、上传结束后会弹窗提醒录入结果，请耐心等待。
          </div>
          <br>
          <form>
            <label>考试名称</label>
            <select id="certName" name="certNo" class="form-control"></select>
            <br>
            <label for="exampleInputFile" class="control-label">上传导入xls文件：</label>
            <div class="control-label">
              <input type="file" id="exampleInputFile">
            </div>
            <br>
            <div class="col-md-2">
              <button id="fileInput" class="btn btn-lg btn-primary btn-block" type="button" onclick="uploadCSPScore()">确认上传</button>
            </div>
          </form>
          <%--<div class="col-md-3" style="margin-top: 50px">--%>
            <%--<button class="btn btn-lg btn-primary btn-block">上传导入xls文件</button>--%>
          <%--</div>--%>


        </div>
        <!-- end content -->
        
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->
    <script type="text/javascript" src="/assets/js/vendor/jquery-3.2.1.min.js"></script>
    <!-- <script>window.jQuery || document.write('<script src="./assets/js/vendor/jquery.min.js"><\/script>')</script> -->
    <script src="/dist/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="/assets/js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/assets/js/ie10-viewport-bug-workaround.js"></script>
  <script src="/assets/js/bootbox.min.js"></script>
    
    <script type="text/javascript">
      // 获取考试集合
      function getCertSet() {
        $.ajax({
          url: "/getCertSet",
          type: "post",
          success: function (res) {
            console.log(res);
            for(var i=0; i<res.data.length; i++)
              $("#certName").append("<option value=\""+res.data[i].no+"\">"+res.data[i].name+"</option>");

          },
          error: function (res) {
            console.log(res);
          }
        });
      }
      getCertSet();
      var xhr = new XMLHttpRequest();
      // 上传文件
      function uploadCSPScore() {
        bootbox.alert({
          size: "small",
          title: "提示信息",
          message: "正在上传，请耐心等待上传结果!",
          callback: function(){  }
        });
        var fileObj = $("#exampleInputFile")[0].files[0];
        var FileController = "/receiveCSPScoreFile";
        // FormData 对象
        var form = new FormData();
        form.append("scoreFile", fileObj);// 文件对象
        form.append("certNo", $("#certName").val());
        // XMLHttpRequest 对象
        xhr.open("post", FileController, true);
        xhr.onload = function () {
//           alert("上传完成!");
        };
        xhr.send(form);
        xhr.onreadystatechange = callbackUpload;
      }
      function callbackUpload() {
        if(xhr.readyState == 4 && xhr.status == 200) {
//					var temp = xhr.responseText;
//					console.log(temp);
          var obj = jQuery.parseJSON(xhr.responseText);
					console.log(obj);
          if(obj.ret) {
            bootbox.alert({
              size: "small",
              title: "提示信息",
              message: "录入成功!",
              callback: function(){  }
            });
          } else {
            bootbox.alert({
              size: "small",
              title: "提交失败",
              message: "录入失败!",
              callback: function(){  }
            });
          }
        }
      }
    </script>
  </body>
</html>