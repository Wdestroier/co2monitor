package br.edu.ifsc.co2monitor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.ifsc.co2monitor.model.Cnpj;
import br.edu.ifsc.co2monitor.model.Institution;
import br.edu.ifsc.co2monitor.model.Response;
import br.edu.ifsc.co2monitor.model.ResponseStatus;
import br.edu.ifsc.co2monitor.model.exception.InvalidCnpjException;
import br.edu.ifsc.co2monitor.repository.InstitutionRepository;

@Service
public class InstitutionServiceImpl implements InstitutionService {

	@Autowired
	private InstitutionRepository institutionRepository;

	@Override
	public Response create(String name, String cnpj) {
		Response response;

		try {
			var institutionCnpj = Cnpj.of(cnpj);

			var institutionOptional = institutionRepository.findByCnpjAndDeletedFalse(institutionCnpj);

			if (institutionOptional.isPresent()) {
				response = Response.of(ResponseStatus.ERROR, String.format(
						"An institution with the CNPJ %s already exists!", cnpj));
			} else {
				var institution = new Institution(name, institutionCnpj);

				var savedInstitution = institutionRepository.save(institution);

				response = Response.of(ResponseStatus.SUCCESS, String.format(
						"Created institution with ID %s successfully!", savedInstitution.getId()));
			}
		} catch (InvalidCnpjException e) {
			response = Response.of(ResponseStatus.ERROR, e.getMessage());
		}

		return response;
	}

	@Override
	public Response getByCnpj(String cnpj) {
		Response response;

		try {
			var institutionCnpj = Cnpj.of(cnpj);

			var	institution = institutionRepository.findByCnpjAndDeletedFalse(institutionCnpj);

			if (institution.isPresent()) {
				response = Response.of(institution.get(), ResponseStatus.SUCCESS);
			} else {
				response = Response.of(ResponseStatus.ERROR, String.format(
						"The CNPJ %s could not be found", cnpj));
			}
		} catch (InvalidCnpjException e) {
			response = Response.of(ResponseStatus.ERROR, e.getMessage());
		}

		return response;
	}

	@Override
	public Response getAllByName(String name) {
		Response response;

		var institution = institutionRepository.findAllByNameAndDeletedFalse(name);

		if (institution.isEmpty()) {
			response = Response.of(ResponseStatus.ERROR, String.format(
					"The institution %s could not be found", name));
		} else {
			response = Response.of(institution, ResponseStatus.SUCCESS);
		}

		return response;
	}

}
