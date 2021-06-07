package br.edu.ifsc.co2monitor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.edu.ifsc.co2monitor.model.Response;
import br.edu.ifsc.co2monitor.model.dto.NodeDTO;
import br.edu.ifsc.co2monitor.service.NodeService;

@RestController
public class NodeController {

	@Autowired
	private NodeService nodeService;

	@GetMapping("/api/v1/nodes/mac/{mac}")
	public Response getNodeByMac(@PathVariable String mac) {
		return nodeService.getByMac(mac);
	}

	@GetMapping("/api/v1/nodes/institution/{institutionId}")
	public Response getNodesByInstitutionId(@PathVariable String institutionId) {
		return nodeService.getAllByInstitutionId(institutionId);
	}

	@PostMapping("/api/v1/nodes")
	public Response createNode(@RequestBody NodeDTO dto) {
		return nodeService.create(dto.getName(), dto.getMac(), dto.getInstitutionId(),
				dto.getImageUrl());
	}

}
