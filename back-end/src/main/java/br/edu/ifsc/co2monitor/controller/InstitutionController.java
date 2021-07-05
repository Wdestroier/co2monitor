package br.edu.ifsc.co2monitor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.edu.ifsc.co2monitor.domain.model.Response;
import br.edu.ifsc.co2monitor.domain.model.dto.InstitutionDTO;
import br.edu.ifsc.co2monitor.service.InstitutionService;

@RestController
public class InstitutionController {

	@Autowired
	private InstitutionService institutionService;

	@PostMapping("/api/v1/institutions")
	public Response createInstitution(@RequestBody InstitutionDTO dto) {
		return institutionService.create(dto.getName(), dto.getCnpj());
	}

	@GetMapping("/api/v1/institutions/cnpj/{cnpj}")
	public Response getInstitutionByCnpj(@PathVariable String cnpj) {
		return institutionService.getByCnpj(cnpj);
	}

	@GetMapping("/api/v1/institutions/name/{name}")
	public Response getAllInstitutionsByName(@PathVariable String name) {
		return institutionService.getAllByName(name);
	}

}
