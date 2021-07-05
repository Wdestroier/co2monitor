package br.edu.ifsc.co2monitor.service;

import br.edu.ifsc.co2monitor.domain.model.Response;

public interface ReportService {

	Response create(String nodeMac, int ppm);

	Response getAll();

	Response getAllByNodeMac(String nodeMac);

	Response getLastForNodeMac(String nodeMac);

}
