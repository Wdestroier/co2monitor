package br.edu.ifsc.co2monitor.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper=true)
public class Institution extends BaseModel {

	private String name;
	private Cnpj cnpj;

}
