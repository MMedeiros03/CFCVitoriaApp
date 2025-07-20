class ChecklistSenhaDto {
  bool minimoCaracteres;
  bool letraMaiuscula;
  bool letraMinuscula;
  bool minimoNumero;
  bool caracterEspecial;

  ChecklistSenhaDto({
    required this.minimoCaracteres,
    required this.letraMaiuscula,
    required this.letraMinuscula,
    required this.minimoNumero,
    required this.caracterEspecial,
  });
}
