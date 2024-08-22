class Operadora {
  final String sg_operadora;
  final String nm_operadora;
  final String cpf_cnpj;
  final String razao_social;
  final String nm_rep_legal;
  final String uf;
  final String tx_logradouro;
  final String tx_localidade;
  final int nr_cep;

  Operadora({
    required this.sg_operadora,
    required this.nm_operadora,
    required this.cpf_cnpj,
    required this.razao_social,
    required this.nm_rep_legal,
    required this.uf,
    required this.tx_logradouro,
    required this.tx_localidade,
    required this.nr_cep,
  });

  factory Operadora.fromJson(Map<String, dynamic> json) {
    return Operadora(
      sg_operadora: json['sg_operadora'],
      nm_operadora: json['nm_operadora'],
      cpf_cnpj: json['cpf_cnpj'],
      razao_social: json['razao_social'],
      nm_rep_legal: json['nm_rep_legal'],
      uf: json['uf'],
      tx_logradouro: json['tx_logradouro'],
      tx_localidade: json['tx_localidade'],
      nr_cep: json['nr_cep'],
    );
  }
}
