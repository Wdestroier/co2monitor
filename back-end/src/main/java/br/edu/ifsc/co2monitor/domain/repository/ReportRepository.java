package br.edu.ifsc.co2monitor.domain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import br.edu.ifsc.co2monitor.domain.model.Report;

@Repository
public interface ReportRepository extends MongoRepository<Report, String> {

	Optional<Report> findByNodeMacAndDeletedFalse(String nodeMac);

	List<Report> findAllByNodeMacAndDeletedFalse(String nodeMac);

	Optional<Report> findTopByNodeMacAndDeletedFalseOrderByCreationDateDesc(String nodeMac);

}
