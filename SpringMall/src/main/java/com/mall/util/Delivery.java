package com.mall.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Delivery {
	public String dDay(String address) {
		String local = address.substring(0, 2);
		int n = 0;
		Calendar c = Calendar.getInstance();
		int w = c.get(Calendar.DAY_OF_WEEK);
		
		if(local.equals("서울")) {
			if(w>=2 && w<=5) n++;
			else if(w == 6 || w == 7) n += 3;
			else if(w == 1) n += 2;
		} else if(local.equals("경기")) {
			if(w >= 2 && w <=4) n += 2;
			else if(w == 5 && w == 7) n += 4;
			else if(w == 1) n += 3;
		} else if(local.equals("제주")) {
			n += 7;
		} else {
			if(w == 2 || w == 3) n += 3;
			else if(w >= 4 && w <= 6) n += 5;
			else if(w == 1) n += 4;
		}

		c.add(Calendar.DATE, n);
		int month = c.get(Calendar.MONTH) + 1;
		int date = c.get(Calendar.DATE);
		int week = c.get(Calendar.DAY_OF_WEEK);
		String[] weekday = {"", "일", "월", "화", "수", "목", "금", "토"};

		String d_day = month + "월 " + date + "일 (" + weekday[week] + ")";
		return d_day;
	}
}
