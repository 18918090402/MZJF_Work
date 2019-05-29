USE mysql;

--  创建用户
CREATE USER  R_DMT_RM   IDENTIFIED BY 'R_DMT_RM_MZ_2016';

-- 查看用户权限
SHOW GRANTS FOR R_DMT_RM;

-- 赋予权限
GRANT SELECT ON DMT_RM.* TO R_DMT_RM;

-- 权限生效
FLUSH  PRIVILEGES ; -- 注意：修改完权限以后 一定要刷新服务，或者重启服务，刷新服务用：FLUSH PRIVILEGES。