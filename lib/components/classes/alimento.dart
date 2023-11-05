
const String tableAlimentos = 'Alimentos';

class AlimentosFields {

  static final List<String> values = [
    nome, fotoBytes, categoria, tipo, pdfPath
  ];

  static const String nome = 'nome';
  static const String fotoBytes = 'fotoBytes';
  static const String categoria = 'categoria';
  static const String tipo = 'tipo';
  static const String pdfPath = 'pdfPath';
}



class Alimento {
  String nome;
  String fotoBytes;
  String categoria;
  String tipo;
  String pdfPath;

  Alimento(
      {
      required this.nome,
      required this.fotoBytes,
      required this.categoria,
      required this.tipo,
      required this.pdfPath
      }
  );

  Map<String, dynamic> toJson() => {
    AlimentosFields.nome: nome,
    AlimentosFields.fotoBytes: fotoBytes,
    AlimentosFields.categoria: categoria,
    AlimentosFields.tipo: tipo,
    AlimentosFields.pdfPath: pdfPath
  };

  Alimento copy({
    String? nome,
    String? fotoBytes,
    String? categoria,
    String? tipo,
    String? pdfPath,
  }) =>

  Alimento(
    nome: nome ?? this.nome,
    fotoBytes: fotoBytes ?? this.fotoBytes,
    categoria: categoria ?? this.categoria,
    tipo: tipo ?? this.tipo,
    pdfPath: pdfPath ?? this.pdfPath
  );

  static Alimento fromJson(Map<String, dynamic> json) => Alimento(
    nome: json[AlimentosFields.nome] as String, 
    fotoBytes: json[AlimentosFields.fotoBytes] as String, 
    categoria: json[AlimentosFields.categoria] as String, 
    tipo: json[AlimentosFields.tipo] as String,
    pdfPath: json[AlimentosFields.pdfPath] as String);

}

