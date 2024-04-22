package br.edu.fateczl.Banco.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ContaPoupanca extends ContaBancaria {

	private int diaDeRendimento;

	public void calcularNovoSaldo(float taxaRendimento) {
		depositar(getSaldo() * taxaRendimento);
	}

}
