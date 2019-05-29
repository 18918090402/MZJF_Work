package com.nono.dq.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nono.dq.biz.MetaDataService;
import com.nono.dq.biz.sms.SmsService;
import com.nono.dq.common.Constant;
import com.nono.dq.model.ObjectId;
import com.nono.dq.model.QualityQuery;
import com.nono.dq.model.response.ResultObject;
import com.nono.dq.util.DateUtil;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

/**
 * 数据质量
 * @author zhaoyaoyuan
 *
 */
@Api(description="数据验证API",value="数据验证",protocols="http")
@RestController
@RequestMapping(value = "/api/dq")
public class DqController {

	private static final Logger logger = LoggerFactory.getLogger(DqController.class);
	@Autowired
	private MetaDataService metaDataService;

	@Autowired
	private SmsService smsService;
	/**
	 * 对计算后的结果进行验证 DQ_COLUMN_COMPARE
	 * @return
	 */
	@ApiOperation(value="数据质量验证", notes="对多数据源进行验证，验证结果会短信通知",httpMethod="GET",response=ResultObject.class)
	@ApiImplicitParams({
           @ApiImplicitParam(name = "ids", value = "数据源列表", required = true, paramType = "query"),
           @ApiImplicitParam(name = "depends", value = "是否重算依赖项", required = true, paramType = "query",dataType="Boolean")
    })
	@RequestMapping(value = "/compare", method = RequestMethod.GET)
	public ResultObject<String> compareRule(@RequestParam(value = "ids",required = true)Integer[] ids
			, @RequestParam(value = "depends",required = false,defaultValue = "false") Boolean depends) {
		QualityQuery query = new QualityQuery();
		query.setItems(ids);
		query.setDepends(depends);
		query.setStatDate(DateUtil.getStringCurrentDate());
		query.setBatchId(new ObjectId().toHexString());
		
		ResultObject<String> rs = new ResultObject<>();
		try {
			rs.setDomain(metaDataService.qualifyDatasources(query));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("{}",e);
			rs.setStatus(Constant.RES_ERROR_CODE);
			rs.setMessage(e.getMessage());
		}
		return rs;
	}
	
	/**
	 * 当天结果统计
	 * @return
	 * @throws Exception 
	 */
	@ApiOperation(value="统计验证结果", notes="统计当天的验证结果",httpMethod="GET",response=ResultObject.class)
	@RequestMapping(value="/stats",method=RequestMethod.GET)
	public ResultObject<String> stats() {
		ResultObject<String> rs = new ResultObject<>();
		QualityQuery query = new QualityQuery();
		query.setStatDate(DateUtil.getStringCurrentDate());
		try {
			rs.setDomain(metaDataService.stats(query));
		} catch (Exception e) {
			// TODO: handle exception
			rs.setStatus(Constant.RES_ERROR_CODE);
			rs.setMessage(e.getMessage());
		}
		return rs;
	}
	
	/**
	 * 当天验证结果
	 * @return
	 * @throws Exception 
	 */
	@ApiOperation(value="短信发送接口", notes="发送统计当天的验证结果",httpMethod="GET",response=ResultObject.class)
	@RequestMapping(value="/sms",method=RequestMethod.GET)
	public ResultObject<String> sms() {
		ResultObject<String> rs = new ResultObject<>();
		QualityQuery query = new QualityQuery();
		query.setStatDate(DateUtil.getStringCurrentDate());
		try {
			metaDataService.sms(query);
		} catch (Exception e) {
			// TODO: handle exception
			rs.setStatus(Constant.RES_ERROR_CODE);
			rs.setMessage(e.getMessage());
		}
		return rs;
	}
	
	/**
	 * 服务状态
	 * @return
	 */
	@ApiOperation(value="服务健康状态查看",httpMethod="GET",response=ResultObject.class)
	@RequestMapping(value="/health",method=RequestMethod.GET)
	public ResultObject<Integer> health() {
		ResultObject<Integer> rs = new ResultObject<>();
		try {
			rs.setDomain(smsService.countWaitMsm());
		} catch (Exception e) {
			// TODO: handle exception
			rs.setStatus(Constant.RES_ERROR_CODE);
			rs.setMessage(e.getMessage());
		}
		return rs;
	}
}