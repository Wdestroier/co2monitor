package br.edu.ifsc.co2monitor.model;

import br.edu.ifsc.co2monitor.model.exception.InvalidMacException;
import lombok.Data;

@Data
public class Mac {

	private final String value;

	public static Mac of(String mac) {
		return new Mac(format(mac));
	}

	public static String format(String mac) {
		var raw = mac.replaceAll("[^0-9a-fA-F]", "");

		if (raw.length() != 12) {
			throw new InvalidMacException(mac);
		}

		return raw.toUpperCase();
	}

}
