package br.edu.ifsc.co2monitor.service;

import br.edu.ifsc.co2monitor.model.Response;

public interface NodeService {

	Response create(String name, String mac, String institutionId, String imageUrl);

	Response getByMac(String mac);

	Response getAllByInstitutionId(String institutionId);

}
