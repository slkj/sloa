package cn.slkj.sloa.entity.shfw;

/**
 * 车辆回访
 * 
 * @author xiaotianliang
 *
 */
public class ReturnVist {
	private String id;// ID
	private String carNumber; // 车牌号
	private String cartype;// 车辆类型
	private String carman;// 联系人
	private String carphone;// 联系电话
	private String carcompany;// 所属公司
	private String fromphone;// 回访电话
	private String causes;// 回访原因
	private String calltime;// 回访时间
	private String callman;// 回访员
	private String carstate;// 接听状态
	private String advice;// 反馈意见
	private String operatorId;// 操作人
	private String operatorTime;// 操作时间
	private String department;// 用户权限

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCarNumber() {
		return carNumber;
	}

	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}

	public String getCartype() {
		return cartype;
	}

	public void setCartype(String cartype) {
		this.cartype = cartype;
	}

	public String getCarman() {
		return carman;
	}

	public void setCarman(String carman) {
		this.carman = carman;
	}

	public String getCarphone() {
		return carphone;
	}

	public void setCarphone(String carphone) {
		this.carphone = carphone;
	}

	public String getCarcompany() {
		return carcompany;
	}

	public void setCarcompany(String carcompany) {
		this.carcompany = carcompany;
	}

	public String getFromphone() {
		return fromphone;
	}

	public void setFromphone(String fromphone) {
		this.fromphone = fromphone;
	}

	public String getCauses() {
		return causes;
	}

	public void setCauses(String causes) {
		this.causes = causes;
	}

	public String getCalltime() {
		return calltime;
	}

	public void setCalltime(String calltime) {
		this.calltime = calltime;
	}

	public String getCallman() {
		return callman;
	}

	public void setCallman(String callman) {
		this.callman = callman;
	}

	public String getCarstate() {
		return carstate;
	}

	public void setCarstate(String carstate) {
		this.carstate = carstate;
	}

	public String getAdvice() {
		return advice;
	}

	public void setAdvice(String advice) {
		this.advice = advice;
	}

	public String getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
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

	@Override
	public String toString() {
		return "ReturnVist [id=" + id + ", carNumber=" + carNumber
				+ ", cartype=" + cartype + ", carman=" + carman + ", carphone="
				+ carphone + ", carcompany=" + carcompany + ", fromphone="
				+ fromphone + ", causes=" + causes + ", calltime=" + calltime
				+ ", callman=" + callman + ", carstate=" + carstate
				+ ", advice=" + advice + ", operatorId=" + operatorId + ""
				+ ", operatorTime=" + operatorTime + ", department=" + department + "]";
	}
}
