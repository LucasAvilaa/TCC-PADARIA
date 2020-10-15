package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the TB_ENDERECO database table.
 * 
 */
@Entity
@Table(name="TB_ENDERECO")
@NamedQuery(name="TbEndereco.findAll", query="SELECT t FROM TbEndereco t")
public class TbEndereco implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ID_END")
	private int idEnd;

	@Column(name="BAIRRO")
	private String bairro;

	@Column(name="CEP")
	private String cep;

	@Column(name="CIDADE")
	private String cidade;

	@Column(name="ESTADO")
	private String estado;

	@Column(name="NUMERO")
	private int numero;

	@Column(name="RUA")
	private String rua;

	//bi-directional many-to-one association to TbPrincipalPessoa
	@ManyToOne
	@JoinColumn(name="ID_GERAL_END")
	private TbPrincipalPessoa tbPrincipalPessoa;

	public TbEndereco() {
	}

	public int getIdEnd() {
		return this.idEnd;
	}

	public void setIdEnd(int idEnd) {
		this.idEnd = idEnd;
	}

	public String getBairro() {
		return this.bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public String getCep() {
		return this.cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getCidade() {
		return this.cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstado() {
		return this.estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getNumero() {
		return this.numero;
	}

	public void setNumero(int numero) {
		this.numero = numero;
	}

	public String getRua() {
		return this.rua;
	}

	public void setRua(String rua) {
		this.rua = rua;
	}

	public TbPrincipalPessoa getTbPrincipalPessoa() {
		return this.tbPrincipalPessoa;
	}

	public void setTbPrincipalPessoa(TbPrincipalPessoa tbPrincipalPessoa) {
		this.tbPrincipalPessoa = tbPrincipalPessoa;
	}

}