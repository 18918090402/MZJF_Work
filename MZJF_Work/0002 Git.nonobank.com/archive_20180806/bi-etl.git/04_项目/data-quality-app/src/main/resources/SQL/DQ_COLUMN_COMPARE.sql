CREATE TABLE `DQ_COLUMN_COMPARE` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `column_id` int(11) NOT NULL COMMENT '验证的字段ID',
  `rule_id` int(11) NOT NULL COMMENT '比较规则ID : ==、>、<=...',
  `TARGET_COLUMNS` varchar(512) NOT NULL DEFAULT '' COMMENT '目标字段的，字段用${}标示，：(${columnt1}+${columnt2})*${columnt3}-${columnt6}',
  `WARNING_ENABLE` int(11) NOT NULL COMMENT '是否报警:1 需要报警 0 不需要报警',
  `WARNING_TYPE` int(11) NOT NULL DEFAULT '1' COMMENT '报警方式：1 邮件',
  `IS_VALID` int(1) NOT NULL DEFAULT '1' COMMENT '1:有效,0:无效',
  `DESC` varchar(126) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;