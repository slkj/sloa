package cn.slkj.sloa.entity.shfw;

/**
 * 
 * @ClassName: Repair
 * @Description: 工单审核
 * @author xiaotianliang
 *
 */
public class Repair {
	private String id;
	private String carId;
	private String carNumber;// 车牌号
	private String equitment;// 原设备号
	private String simNumber;// 原卡号
	private String equitment1;// 现设备号
	private String simNumber1;// 现卡号
	private String repairNum; // 派工单号
	private String guy; // 维修人
	private String guyName; // 维修人
	private String wxTime; // 维修时间
	private String wxTime1; // 维修时间结束
	private String contact; // 联系方式
	private String site; // 维修地点
	private String why; // 不定位原因
	private String cost;// 费用
	private String outcome; // 处理结果
	private String operator; // 录入员
	private String operatorTime; // 录入时间
	private String department; // 所属部门
	private String isLook;// 审核状态
	private String looker; // 审核人
	private String lookTime; // 审核时间
	private String remark;
	private String wxType;// 维修类型 8条线 非8条线 自带

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCarId() {
		return carId;
	}

	public void setCarId(String carId) {
		this.carId = carId;
	}

	public String getCarNumber() {
		return carNumber;
	}

	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}

	public String getEquitment() {
		return equitment;
	}

	public void setEquitment(String equitment) {
		this.equitment = equitment;
	}

	public String getSimNumber() {
		return simNumber;
	}

	public void setSimNumber(String simNumber) {
		this.simNumber = simNumber;
	}

	public String getEquitment1() {
		return equitment1;
	}

	public void setEquitment1(String equitment1) {
		this.equitment1 = equitment1;
	}

	public String getSimNumber1() {
		return simNumber1;
	}

	public void setSimNumber1(String simNumber1) {
		this.simNumber1 = simNumber1;
	}

	public String getRepairNum() {
		return repairNum;
	}

	public void setRepairNum(String repairNum) {
		this.repairNum = repairNum;
	}

	public String getGuy() {
		return guy;
	}

	public void setGuy(String guy) {
		this.guy = guy;
	}

	public String getGuyName() {
		return guyName;
	}

	public void setGuyName(String guyName) {
		this.guyName = guyName;
	}

	public String getWxTime() {
		return wxTime;
	}

	public void setWxTime(String wxTime) {
		this.wxTime = wxTime;
	}

	public String getWxTime1() {
		return wxTime1;
	}

	public void setWxTime1(String wxTime1) {
		this.wxTime1 = wxTime1;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getSite() {
		return site;
	}

	public void setSite(String site) {
		this.site = site;
	}

	public String getWhy() {
		return why;
	}

	public void setWhy(String why) {
		this.why = why;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getOutcome() {
		return outcome;
	}

	public void setOutcome(String outcome) {
		this.outcome = outcome;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOperatorTime() {
		return operatorTime;
	}

	public void setOperatorTime(String operatorTime) {
		this.operatorTime = operatorTime;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getIsLook() {
		return isLook;
	}

	public void setIsLook(String isLook) {
		this.isLook = isLook;
	}

	public String getLooker() {
		return looker;
	}

	public void setLooker(String looker) {
		this.looker = looker;
	}

	public String getLookTime() {
		return lookTime;
	}

	public void setLookTime(String lookTime) {
		this.lookTime = lookTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getWxType() {
		return wxType;
	}

	public void setWxType(String wxType) {
		this.wxType = wxType;
	}

	@Override
	public String toString() {
		return "ReturnVist [id=" + id + ", carId=" + carId + ","
				+ " carNumber=" + carNumber + ", equitment=" + equitment + ", "
				+ "simNumber=" + simNumber + ", equitment1=" + equitment1
				+ ", " + "simNumber1=" + simNumber1 + ", repairNum="
				+ repairNum + ", " + "guy=" + guy + ", guyName=" + guyName
				+ ", " + "wxTime=" + wxTime + ", wxTime1=" + wxTime1 + ","
				+ "contact=" + contact + ",site=" + site + "," + "why=" + why
				+ ",cost=" + cost + "," + "outcome=" + outcome + ",operator="
				+ operator + "," + "operatorTime=" + operatorTime
				+ ",department=" + department + "," + "isLook=" + isLook
				+ ",looker=" + looker + "," + "lookTime=" + lookTime
				+ "remark=" + remark + "wxType=" + wxType + "]";
	}
}
