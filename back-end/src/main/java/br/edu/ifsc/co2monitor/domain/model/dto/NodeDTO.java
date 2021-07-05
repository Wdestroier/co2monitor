package br.edu.ifsc.co2monitor.domain.model.dto;

import lombok.Data;

@Data
public class NodeDTO {

	private String name;
	private String mac;
	private String institutionId;
	private String imageUrl;

}
