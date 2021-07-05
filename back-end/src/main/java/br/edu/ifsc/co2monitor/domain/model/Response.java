package br.edu.ifsc.co2monitor.domain.model;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder(access = AccessLevel.PRIVATE)
public class Response {

	private Object data;
	private ResponseStatus status;
	private String message;

	public static Response of(Object data, ResponseStatus status, String message) {
		return Response.builder()
				.data(data)
				.status(status)
				.message(message)
				.build();
	}

	public static Response of(Object data, ResponseStatus status) {
		return Response.builder()
				.data(data)
				.status(status)
				.build();
	}

	public static Response of(ResponseStatus status, String message) {
		return Response.builder()
				.status(status)
				.message(message)
				.build();
	}

	public boolean wasSuccessful() {
		return status != ResponseStatus.ERROR;
	}

}
