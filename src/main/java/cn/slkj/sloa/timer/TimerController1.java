package cn.slkj.sloa.timer;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimerController1 {
	public void print() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd H:m:s");
		System.out.println("timer1 : " + format.format(new Date()));
	}
}
