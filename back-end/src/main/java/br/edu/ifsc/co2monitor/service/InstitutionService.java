package br.edu.ifsc.co2monitor.service;

import br.edu.ifsc.co2monitor.domain.model.Response;

public interface InstitutionService {

	Response getByCnpj(String cnpj);

	Response getAllByName(String name);

	Response create(String name, String cnpj);

}
