package br.edu.ifsc.co2monitor.domain.model;

import java.time.Instant;

import org.springframework.data.annotation.Id;

import lombok.Data;

@Data
public abstract class BaseModel {

	@Id
	private String id;

	private Instant creationDate = Instant.now();

	private boolean deleted;

	private Instant deletionDate;

	public void setDeleted() {
		deleted = true;
		deletionDate = Instant.now();
	}

}
