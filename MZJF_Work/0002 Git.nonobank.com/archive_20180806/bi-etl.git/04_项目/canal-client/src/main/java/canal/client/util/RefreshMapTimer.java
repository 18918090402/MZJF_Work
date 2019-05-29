package canal.client.util;

import java.util.Timer;
import java.util.TimerTask;

public class RefreshMapTimer {
	public static void main(String[] args) {
		timer1();
		System.out.println("111111111111");
	}
	
	// 第一种方法：设定指定任务task在指定时间time执行 schedule(TimerTask task, Date time)
	  public static void timer1() {
	    Timer timer = new Timer();
	    timer.schedule(new TimerTask() {
	      public void run() {
	        System.out.println("-------设定要指定任务--------");
	      }
	    },0,1000);// 设定指定的时间time,此处为2000毫秒
	  }
}
