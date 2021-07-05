package br.edu.ifsc.co2monitor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.ifsc.co2monitor.domain.model.Node;
import br.edu.ifsc.co2monitor.domain.model.Report;
import br.edu.ifsc.co2monitor.domain.model.Response;
import br.edu.ifsc.co2monitor.domain.model.ResponseStatus;
import br.edu.ifsc.co2monitor.domain.model.exception.InvalidMacException;
import br.edu.ifsc.co2monitor.domain.repository.ReportRepository;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportRepository reportRepository;
	@Autowired
	private NodeService nodeService;

	@Override
	public Response create(String nodeMac, int ppm) {
		Response response;

		try {
			var nodeResponse = nodeService.getByMac(nodeMac);

			if (nodeResponse.wasSuccessful()) {
				var node = (Node) nodeResponse.getData();
				var mac = node.getMac().getValue();

				var report = new Report(mac, ppm);

				var savedReport = reportRepository.save(report);

				response = Response.of(ResponseStatus.SUCCESS, String.format(
						"Created report with ID %s successfully!", savedReport.getId()));
			} else {
				response = nodeResponse;
			}
		} catch (InvalidMacException e) {
			response = Response.of(ResponseStatus.ERROR, e.getMessage());
		}

		return response;
	}

	@Override
	public Response getAll() {
		return Response.of(reportRepository.findAll(), ResponseStatus.SUCCESS);
	}

	@Override
	public Response getLastForNodeMac(String nodeMac) {
		Response response;

		try {
			var nodeResponse = nodeService.getByMac(nodeMac);

			if (nodeResponse.wasSuccessful()) {
				var node = (Node) nodeResponse.getData();
				var mac = node.getMac().getValue();

				var report = reportRepository
						.findTopByNodeMacAndDeletedFalseOrderByCreationDateDesc(mac);

				if (report.isPresent()) {
					response = Response.of(report.get(), ResponseStatus.SUCCESS);
				} else {
					response = Response.of(ResponseStatus.ERROR,
							"No reports found for the MAC address " + nodeMac);
				}
			} else {
				response = nodeResponse;
			}
		} catch (InvalidMacException e) {
			response = Response.of(ResponseStatus.ERROR, e.getMessage());
		}

		return response;
	}

	@Override
	public Response getAllByNodeMac(String nodeMac) {
		Response response;

		try {
			var nodeResponse = nodeService.getByMac(nodeMac);

			if (nodeResponse.wasSuccessful()) {
				var node = (Node) nodeResponse.getData();
				var mac = node.getMac().getValue();

				var reports = reportRepository.findAllByNodeMacAndDeletedFalse(mac);

				response = Response.of(reports, ResponseStatus.SUCCESS);
			} else {
				response = nodeResponse;
			}
		} catch (InvalidMacException e) {
			response = Response.of(ResponseStatus.ERROR, e.getMessage());
		}

		return response;
	}

}
