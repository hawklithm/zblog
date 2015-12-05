<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<ul class="side-menu">
  <li><a class="nav-header" href="#">
        <i class="left glyphicon glyphicon-home" aria-hidden="true"></i>系统设置
        <i class="right glyphicon glyphicon-chevron-down" aria-hidden="true"></i></a>
    <ul class="sub-menu" style="display: block;">
      <li><a href="/backend/index">首页</a></li>
      <li><a href="/backend/options/general">常规选项</a></li>
      <li><a href="/backend/options/post">撰写/阅读</a></li>
      <li><a class="last" href="/backend/options/email">邮件评论</a></li>
    </ul>
   </li>
   <shiro:hasAnyRoles name="admin,editor">
   <li><a class="nav-header" href="#">
        <i class="left glyphicon glyphicon-send" aria-hidden="true"></i>文章
        <i class="right glyphicon glyphicon-chevron-up" aria-hidden="true"></i>
        </a>
     <ul class="sub-menu">
      <li><a href="/backend/posts/edit">写文章</a></li>
      <li><a href="/backend/posts">所有文章</a></li>
      <li><a class="last" href="/backend/categorys">文章分类</a></li>
    </ul>
  </li>
  <li><a class="nav-header" href="#">
        <i class="left glyphicon glyphicon-film" aria-hidden="true"></i>多媒体
        <i class="right glyphicon glyphicon-chevron-up" aria-hidden="true"></i>
        </a>
     <ul class="sub-menu">
      <li><a href="/backend/uploads">媒体库</a></li>
      <li><a class="last" href="/backend/uploads/edit">添加</a></li>
    </ul>
  </li>
  </shiro:hasAnyRoles>
  
  <shiro:hasRole name="admin">
  <li><a class="nav-header" href="#">
        <i class="icon glyphicon glyphicon-file" aria-hidden="true"></i>页面
        <i class="right glyphicon glyphicon-chevron-up" aria-hidden="true"></i>
        </a>
     <ul class="sub-menu">
      <li><a href="/backend/pages">所有页面</a></li>
      <li><a class="last" href="/backend/pages/edit">新建页面</a></li>
    </ul>
  </li>
  <li><a class="nav-header" href="/backend/comments">
      <i class="left glyphicon glyphicon-comment" aria-hidden="true"></i>评论</a></li>
  <li><a class="nav-header" href="#">
      <i class="left glyphicon glyphicon-link" aria-hidden="true"></i>链接
      <i class="right glyphicon glyphicon-chevron-up" aria-hidden="true"></i></a>
    <ul class="sub-menu">
      <li><a href="/backend/links/edit">添加</a></li>
      <li><a class="last" href="/backend/links">全部链接</a></li>
    </ul>
  </li>
  </shiro:hasRole>
  
  <shiro:authenticated>
    <li><a class="nav-header" href="#">
       <i class="left glyphicon glyphicon-user" aria-hidden="true"></i>用户
       <i class="right glyphicon glyphicon-chevron-up" aria-hidden="true"></i></a>
       <ul class="sub-menu">
        <shiro:hasRole name="admin">
          <li><a href="/backend/users">所有用户</a></li>
          <li><a href="/backend/users/edit">添加用户</a></li>
        </shiro:hasRole>
        <li><a class="last" href="/backend/users/my">我的个人资料</a></li>
      </ul>
    </li>
  </shiro:authenticated>
  
  <shiro:hasRole name="admin">
   <li><a class="nav-header" href="#">
    <i class="left glyphicon glyphicon-wrench" aria-hidden="true"></i>工具
    <i class="right glyphicon glyphicon-chevron-up" aria-hidden="true"></i></a>
    <ul class="sub-menu">
      <li><a href="/backend/tool/ehcache">缓存监控</a></li>
      <li><a href="/backend/tool/import">导入</a></li>
      <li><a class="last" href="/backend/tool/output">导出</a></li>
    </ul>
   </li>
  </shiro:hasRole>
</ul>
<script type="text/javascript" src="/resource/js/backend/sidebar.js"></script>