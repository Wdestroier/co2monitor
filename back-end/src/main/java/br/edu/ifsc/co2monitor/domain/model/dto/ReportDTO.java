package br.edu.ifsc.co2monitor.domain.model.dto;

import lombok.Data;

@Data
public class ReportDTO {

	private String nodeMac;
	private int ppm;

}
