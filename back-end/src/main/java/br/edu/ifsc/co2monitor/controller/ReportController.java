package br.edu.ifsc.co2monitor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.edu.ifsc.co2monitor.model.Response;
import br.edu.ifsc.co2monitor.model.dto.ReportDTO;
import br.edu.ifsc.co2monitor.service.ReportService;

@RestController
public class ReportController {

	@Autowired
	private ReportService reportService;

	@PostMapping("/api/v1/reports")
	public Response createReport(@RequestBody ReportDTO dto) {
		return reportService.create(dto.getNodeMac(), dto.getPpm());
	}

	//TODO Use nodeId instead
	@GetMapping("/api/v1/report/nodeMac/{nodeMac}")
	public Response getLastNodeReport(@PathVariable String nodeMac) {
		return reportService.getLastForNodeMac(nodeMac);
	}

	@GetMapping("/api/v1/reports/nodeMac/{nodeMac}")
	public Response getAllNodeReports(@PathVariable String nodeMac) {
		return reportService.getAllByNodeMac(nodeMac);
	}

	//TODO Implement filtering, sorting and pagination?
	@GetMapping("/api/v1/reports")
	public Response getAllReports() {
		return reportService.getAll();
	}

}
