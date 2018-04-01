package cn.slkj.sloa.entity.vehicle;

/**
 * 
 * @ClassName: Transfer
 * @Description: 异动
 * @author wangling
 *
 */
public class Transfer {

	private String id;
	/**
	 * 车辆ID
	 */
	private String vId;
	/**
	 * 异动类型,车辆过户，牌照变更，车辆报停
	 */
	private String transferType;
	
	/**
	 * 原车牌
	 */	
	private String oldCarNumber;
	/**
	 * 现车牌
	 */
	private String newCarNumber;
	/**
	 * 原设备号
	 */	
	private String oldDevice;
	/**
	 * 现设备号
	 */
	private String newDevice;
	/**
	 * 原卡号
	 */	
	private String oldSIM;
	/**
	 * 现卡号
	 */
	private String newSIM;
	/**
	 * 原公司
	 */	
	private String oldCompany;
	/**
	 * 现公司
	 */
	private String newCompany;
	/**
	 * 原车主
	 */	
	private String oldOwner;
	/**
	 * 现车主
	 */
	private String newOwner;
	/**
	 * 原车主电话
	 */	
	private String oldPhone;
	/**
	 * 现车主电话
	 */
	private String newPhone;
	/**
	 * 日期
	 */
	private String riqi;
	/**
	 * 原因
	 */
	private String reason;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getvId() {
		return vId;
	}
	public void setvId(String vId) {
		this.vId = vId;
	}
	public String getTransferType() {
		return transferType;
	}
	public void setTransferType(String transferType) {
		this.transferType = transferType;
	}
	public String getOldCarNumber() {
		return oldCarNumber;
	}
	public void setOldCarNumber(String oldCarNumber) {
		this.oldCarNumber = oldCarNumber;
	}
	public String getNewCarNumber() {
		return newCarNumber;
	}
	public void setNewCarNumber(String newCarNumber) {
		this.newCarNumber = newCarNumber;
	}
	public String getOldDevice() {
		return oldDevice;
	}
	public void setOldDevice(String oldDevice) {
		this.oldDevice = oldDevice;
	}
	public String getNewDevice() {
		return newDevice;
	}
	public void setNewDevice(String newDevice) {
		this.newDevice = newDevice;
	}
	public String getOldSIM() {
		return oldSIM;
	}
	public void setOldSIM(String oldSIM) {
		this.oldSIM = oldSIM;
	}
	public String getNewSIM() {
		return newSIM;
	}
	public void setNewSIM(String newSIM) {
		this.newSIM = newSIM;
	}
	public String getOldCompany() {
		return oldCompany;
	}
	public void setOldCompany(String oldCompany) {
		this.oldCompany = oldCompany;
	}
	public String getNewCompany() {
		return newCompany;
	}
	public void setNewCompany(String newCompany) {
		this.newCompany = newCompany;
	}
	public String getOldOwner() {
		return oldOwner;
	}
	public void setOldOwner(String oldOwner) {
		this.oldOwner = oldOwner;
	}
	public String getNewOwner() {
		return newOwner;
	}
	public void setNewOwner(String newOwner) {
		this.newOwner = newOwner;
	}
	public String getOldPhone() {
		return oldPhone;
	}
	public void setOldPhone(String oldPhone) {
		this.oldPhone = oldPhone;
	}
	public String getNewPhone() {
		return newPhone;
	}
	public void setNewPhone(String newPhone) {
		this.newPhone = newPhone;
	}
	public String getRiqi() {
		return riqi;
	}
	public void setRiqi(String riqi) {
		this.riqi = riqi;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
}
