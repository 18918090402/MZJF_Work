1286058   12642918    7265485       7082086  




13149768  7626888     12630356      1366845     12925295       7834317      




SELECT * from msc.bo_par 
WHERE 1 = 1
and bo_id = 2734739
--and (par_user_id = '1286058' or cur_user_id = 1286058)
ORDER BY create_time;


7782175    



CREATE FUNCTION `getChildLst`(rootId INT) 
RETURNS varchar(1000) 
BEGIN 
  DECLARE sTemp VARCHAR(1000); 
  DECLARE sTempChd VARCHAR(1000); 

  SET sTemp = '$'; 
  SET sTempChd =cast(rootId as CHAR); 

  WHILE sTempChd is not null DO 
    SET sTemp = concat(sTemp,',',sTempChd); 
    SELECT group_concat(id) INTO sTempChd FROM treeNodes where FIND_IN_SET(pid,sTempChd)>0; 
  END WHILE; 
  RETURN sTemp; 
END 




--mysql 层次化查询  

CREATE TABLE table1(id int, name varchar(10), parent_id int); 
INSERT table1 VALUES 
(1, 'Home', 0), 
(2, 'About', 1), 
(3, 'Contact', 1), 
(4, 'Legal', 2), 
(5, 'Privacy', 4), 
(6, 'Products', 1), 
(7, 'Support', 2);



--查询 id = 5 的所有父级

SELECT ID.level, DATA.* 
FROM
( 
    SELECT 
    @id as _id, 
    ( 
        SELECT @id := parent_id 
        FROM table1 
        WHERE id = @id 
    ) as _pid, 
    @l := @l+1 as level 
    FROM table1, 
    (SELECT @id := 5, @l := 0 ) b 
    WHERE @id > 0 
) ID, table1 DATA 
WHERE ID._id = DATA.id 
ORDER BY level
;


--7712690的所有父级
SELECT ID.level, tab.* 
FROM
( 
    SELECT 
        @cur_user_id as cur_user_id, 
        ( 
            SELECT @cur_user_id := par_user_id 
            FROM table2 
            WHERE cur_user_id = @cur_user_id 
        ) as par_user_id, 
        @l := @l+1 as level 
    FROM table2, ( SELECT @cur_user_id := 7712690, @l := 0 ) b 
    WHERE @cur_user_id > 0 
) ID, table2 tab 
WHERE ID.cur_user_id = tab.cur_user_id 
ORDER BY level
;


--
SELECT ID.level, DATA.* 
FROM
( 
    SELECT 
        @ids as _ids, 
        ( 
            SELECT @ids := GROUP_CONCAT(id) 
            FROM table1 
            WHERE FIND_IN_SET(parent_id, @ids) 
        ) as cids, 
        @l := @l+1 as level 
    FROM table1, ( SELECT @ids :=’1’, @l := 0 ) b 
    WHERE @ids IS NOT NULL 
) id, table1 DATA 
WHERE FIND_IN_SET(DATA.id, ID._ids) 
ORDER BY level, id
;

