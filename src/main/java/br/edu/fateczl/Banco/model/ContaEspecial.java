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
public class ContaEspecial extends ContaBancaria{

	private float limite;
	
	public void sacar(float quantia) {
		if ((getSaldo() + getLimite()) - quantia >= 0) {
			setSaldo(getSaldo() - quantia);
		}
	}
}
