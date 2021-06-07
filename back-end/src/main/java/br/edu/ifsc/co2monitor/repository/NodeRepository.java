package br.edu.ifsc.co2monitor.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import br.edu.ifsc.co2monitor.model.Mac;
import br.edu.ifsc.co2monitor.model.Node;

@Repository
public interface NodeRepository extends MongoRepository<Node, String> {

	Optional<Node> findByMacAndDeletedFalse(Mac mac);

	List<Node> findAllByInstitutionIdAndDeletedFalse(String institutionId);

}
