package cn.slkj.sloa.entity.shfw;

public class Weixin {
	private int id;
	private int state; // 状态
	private int type; // 订单类型
	private String carNumber; // 车牌号
	private String owner; // 所属企业
	private String purpose; // 业户名称
	private String phone; // 电话
	private int deadline; // 缴费期限
	private String prove; // 证明索取
	private String remark; // 备注
	private Double colAmounts; // 收费标准
	private String riqi; // 下单时间
	private String payee; // 审核员
	private String qr_time; // 操作时间
	private String orderNumber; // 订单号
	private String pay_time; // 支付时间

	private String openId;// 微信ID
	private int wx_type;// 微信平台类别
	private Double price;// 金额

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getCarNumber() {
		return carNumber;
	}

	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getDeadline() {
		return deadline;
	}

	public void setDeadline(int deadline) {
		this.deadline = deadline;
	}

	public String getProve() {
		return prove;
	}

	public void setProve(String prove) {
		this.prove = prove;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	 

	public Double getColAmounts() {
		return colAmounts;
	}

	public void setColAmounts(Double colAmounts) {
		this.colAmounts = colAmounts;
	}

	public String getRiqi() {
		return riqi;
	}

	public void setRiqi(String riqi) {
		this.riqi = riqi;
	}

	public String getPayee() {
		return payee;
	}

	public void setPayee(String payee) {
		this.payee = payee;
	}

	public String getQr_time() {
		return qr_time;
	}

	public void setQr_time(String qr_time) {
		this.qr_time = qr_time;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public String getPay_time() {
		return pay_time;
	}

	public void setPay_time(String pay_time) {
		this.pay_time = pay_time;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public int getWx_type() {
		return wx_type;
	}

	public void setWx_type(int wx_type) {
		this.wx_type = wx_type;
	}

	@Override
	public String toString() {
		return "Weixin [id=" + id + ", state=" + state + ", type=" + type + ", carNumber=" + carNumber + ", owner=" + owner + ", purpose=" + purpose + ", phone=" + phone + ", deadline=" + deadline + ", prove=" + prove + ", remark=" + remark + ", colAmounts=" + colAmounts + ", riqi=" + riqi + ", payee=" + payee + ", qr_time=" + qr_time + ", orderNumber=" + orderNumber + ", pay_time=" + pay_time + ", openId=" + openId + ", wx_type=" + wx_type + ", price=" + price + "]";
	}

}
