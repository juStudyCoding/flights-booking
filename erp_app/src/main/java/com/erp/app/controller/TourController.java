package com.erp.app.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.erp.app.dto.MemberDTO;
import com.erp.app.dto.TourDTO;
import com.erp.app.service.TourService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class TourController {

	@Autowired
	private TourService tourService;
	
	@RequestMapping("/tour")
	public String tour(Model model,TourDTO tour) {
		
		List<TourDTO> list = tourService.selectTourList(tour);
		model.addAttribute("list",list);
		
		return "tour";
	}
	
	@RequestMapping("/tourReservation")
	public String tourReservation(Model model,HttpServletRequest request) {
		String no = request.getParameter("no");
		model.addAttribute("no",no);
		
		return "reservation";

	}
	
	@RequestMapping("/reservation")
	public String seats(Model model,TourDTO tour) {

		return "reservation";

	}
	
	@RequestMapping("/enableDate")
	@ResponseBody
	public List<String> enableDate(Model model,TourDTO tour) {
		List<String> dateList=tourService.selectEnableDate(tour);
		for(int i=0; i<dateList.size(); i++) {
			dateList.set(i, dateList.get(i).substring(0,4)+"-"+dateList.get(i).substring(4,6)+"-"+dateList.get(i).substring(6,8));
		}
		System.out.println(dateList.get(0));
		return dateList;

	}
	//해당 날짜에 대한 가능 좌석
	@RequestMapping("/viewSeats")
	@ResponseBody
	public List<TourDTO> viewSeats(TourDTO tour) {
		List<TourDTO> list = tourService.selectViewSeats(tour);
		return list;

	}
	
	//해당 좌석 먼저 예약완료한사람있는지 확인
	@RequestMapping("/reservCheck")
	@ResponseBody
	public TourDTO reservCheck(TourDTO tour, HttpServletResponse response) throws Exception {
		TourDTO seatCheck = tourService.selectSeatCheck(tour);

		return seatCheck;	

	}
	
	////결제페이지
	@RequestMapping("/payPage")
	public String payPage(Model model,TourDTO tour) {
		TourDTO seatCheck = tourService.selectSeatCheck(tour);
		int commission=seatCheck.getPrice()/10;
		int totalPrice = seatCheck.getPrice()+commission;
		seatCheck.setCommission(commission);
		seatCheck.setTotalPrice(totalPrice);
		model.addAttribute("seatCheck",seatCheck);
		return "payPage";

	}
	//결제
	@RequestMapping("/order")
	public String order(TourDTO tour, HttpServletRequest request, Model model) {
		System.out.println(tour.getTour_no());
		tourService.insertOrder(tour);
		List<TourDTO> selectOrder = tourService.selectOwnOrder(tour);
		model.addAttribute("selectOrder",selectOrder);
		return "myTourList";

	}
	
	//여행리스트
	@RequestMapping("/myTourList")
	public String myTourList(HttpServletRequest request,TourDTO tour,Model model) {
		MemberDTO loginInfo = (MemberDTO) request.getSession().getAttribute("LoginInfo");
		tour.setMember_no(loginInfo.getNo());
		List<TourDTO> selectOrder = tourService.selectOwnOrder(tour);
		model.addAttribute("selectOrder",selectOrder);
		return "myTourList";

	}
}
