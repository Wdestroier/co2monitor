package br.edu.ifsc.co2monitor.domain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import br.edu.ifsc.co2monitor.domain.model.Cnpj;
import br.edu.ifsc.co2monitor.domain.model.Institution;

@Repository
public interface InstitutionRepository extends MongoRepository<Institution, String> {

	Optional<Institution> findByCnpjAndDeletedFalse(Cnpj cnpj);

	List<Institution> findAllByNameAndDeletedFalse(String name);

}
