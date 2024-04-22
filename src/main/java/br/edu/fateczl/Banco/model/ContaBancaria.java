package br.edu.fateczl.Banco.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ContaBancaria {

	private String NomeCliente;
	private int numConta;
	private float saldo;

	public void sacar(float quantia) {
		if (getSaldo() - quantia >= 0) {
			setSaldo(getSaldo() - quantia);
		}
	}

	public void depositar(float quantia) {
		setSaldo(getSaldo() + quantia);
	}
}
