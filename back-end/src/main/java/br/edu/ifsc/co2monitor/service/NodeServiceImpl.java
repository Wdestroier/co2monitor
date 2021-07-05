package br.edu.ifsc.co2monitor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.edu.ifsc.co2monitor.domain.model.Mac;
import br.edu.ifsc.co2monitor.domain.model.Node;
import br.edu.ifsc.co2monitor.domain.model.Response;
import br.edu.ifsc.co2monitor.domain.model.ResponseStatus;
import br.edu.ifsc.co2monitor.domain.model.exception.InvalidMacException;
import br.edu.ifsc.co2monitor.domain.repository.InstitutionRepository;
import br.edu.ifsc.co2monitor.domain.repository.NodeRepository;

@Service
public class NodeServiceImpl implements NodeService {

	@Autowired
	private NodeRepository nodeRepository;
	@Autowired
	private InstitutionRepository institutionRepository;

	@Override
	public Response create(String name, String mac, String institutionId, String imageUrl) {
		Response response;

		var institutionExists = institutionRepository.existsById(institutionId);

		if (institutionExists) {
			try {
				Mac nodeMac = Mac.of(mac);

				var shouldCreateNode = !nodeRepository.findByMacAndDeletedFalse(nodeMac).isPresent();

				if (shouldCreateNode) {
					var node = new Node(name, nodeMac, institutionId, imageUrl);

					var savedNode = nodeRepository.save(node);

					response = Response.of(ResponseStatus.SUCCESS, String.format(
							"Created node with ID %s successfully!", savedNode.getId()));
				} else {
					response = Response.of(ResponseStatus.ERROR,
							"A node with this MAC address already exists!");
				}
			} catch (InvalidMacException e) {
				response = Response.of(ResponseStatus.ERROR, e.getMessage());
			}
		} else {
			response = Response.of(ResponseStatus.ERROR, String.format(
					"An institution with id %s doesn't exist!", institutionId));
		}

		return response;
	}

	@Override
	public Response getByMac(String mac) {
		Response response;

		try {
			var nodeMac = Mac.of(mac);

			var node = nodeRepository.findByMacAndDeletedFalse(nodeMac);

			if (node.isPresent()) {
				response = Response.of(node.get(), ResponseStatus.SUCCESS);
			} else {
				response = Response.of(ResponseStatus.ERROR, String.format(
						"A node with the MAC address %s could not be found!", mac));
			}
		} catch (InvalidMacException e) {
			response = Response.of(ResponseStatus.ERROR, e.getMessage());
		}

		return response;
	}

	@Override
	public Response getAllByInstitutionId(String institutionId) {
		Response response;

		var institutionExists = institutionRepository.existsById(institutionId);

		if (institutionExists) {
			var nodes = nodeRepository.findAllByInstitutionIdAndDeletedFalse(institutionId);

			response = Response.of(nodes, ResponseStatus.SUCCESS);
		} else {
			response = Response.of(ResponseStatus.ERROR, String.format(
					"An institution with id %s doesn't exist!", institutionId));
		}

		return response;
	}

}
