package br.edu.ifsc.co2monitor.model.exception;

public class InvalidCnpjException extends RuntimeException {

	private static final long serialVersionUID = -3350719296165683597L;

	public InvalidCnpjException(String cnpj) {
		super(String.format("CNPJ %s is invalid!", cnpj));
	}

}
