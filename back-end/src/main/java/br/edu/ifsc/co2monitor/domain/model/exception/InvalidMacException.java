package br.edu.ifsc.co2monitor.domain.model.exception;

public class InvalidMacException extends RuntimeException {

	private static final long serialVersionUID = 3739477525268597309L;

	public InvalidMacException(String cnpj) {
		super(String.format("MAC address %s is invalid!", cnpj));
	}

}
