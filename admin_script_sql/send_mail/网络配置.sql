SELECT * FROM dba_network_acls;
SELECT * FROM dba_network_acl_privileges;
SELECT * FROM resource_view where any_path like '/sys/acls/%.xml';
SELECT utl_http.request('http://blog.fqiyou.com') FROM dual;
-- 1.0 ACL
-- 1.1 创建
BEGIN
  dbms_network_acl_admin.create_acl(acl         => 'httprequestpermission.xml',
                                    DESCRIPTION => 'Normal Access',
                                    principal   => 'CONNECT', -- user or role
                                    is_grant    => TRUE,
                                    PRIVILEGE   => 'connect',
                                    start_date  => NULL,
                                    end_date    => NULL);
END;
-- 1.2 删除
BEGIN
  dbms_network_acl_admin.drop_acl(acl => 'httprequestpermission.xml');
END;

-- 2.0 授权用户
BEGIN
  dbms_network_acl_admin.add_privilege(acl        => 'httprequestpermission.xml',
                                       principal  => 'SYSTEM', -- user or role
                                       is_grant   => TRUE,
                                       privilege  => 'connect',
                                       start_date => null,
                                       end_date   => null);
END;
-- 3.0 ACL第三步，添加主机或域名
BEGIN
  dbms_network_acl_admin.assign_acl(acl        => 'httprequestpermission.xml',
                                    host       => 'smtp.qq.com', --smtp服务器地址
                                    lower_port => 25, --smtp端口
                                    upper_port => NULL);
END;

