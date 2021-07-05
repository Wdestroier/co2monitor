package br.edu.ifsc.co2monitor.domain.model;

import br.edu.ifsc.co2monitor.domain.model.exception.InvalidCnpjException;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Cnpj {

	private final String value;

	public static Cnpj of(String value) {
		var raw = value.replaceAll("[^0-9]", "");

		if (raw.length() != 14) {
			throw new InvalidCnpjException(value);
		}

		var arr = raw.toCharArray();

		var valueBuilder = new StringBuilder()
				.append(arr[0])
				.append(arr[1])
				.append('.')
				.append(arr[2])
				.append(arr[3])
				.append(arr[4])
				.append('.')
				.append(arr[5])
				.append(arr[6])
				.append(arr[7])
				.append('/')
				.append(arr[8])
				.append(arr[9])
				.append(arr[10])
				.append(arr[11])
				.append('-')
				.append(arr[12])
				.append(arr[13]);

		return new Cnpj(valueBuilder.toString());
	}

}
