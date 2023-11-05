const String tableCardapio = 'cardapio';

class CardapioFields {
  static const String name = 'name';
  static const String cafeId1 = 'cafeId1';
  static const String cafeId2 = 'cafeId2';
  static const String cafeId3 = 'cafeId3';
  static const String almocoId1 = 'almocoId1';
  static const String almocoId2 = 'almocoId2';
  static const String almocoId3 = 'almocoId3';
  static const String almocoId4 = 'almocoId4';
  static const String almocoId5 = 'almocoId5';
  static const String jantarId1 = 'jantarId1';
  static const String jantarId2 = 'jantarId2';
  static const String jantarId3 = 'jantarId3';
  static const String jantarId4 = 'jantarId4';
}

class Cardapio {
  String name;
  int cafeId1;
  int cafeId2;
  int cafeId3;
  int almocoId1;
  int almocoId2;
  int almocoId3;
  int almocoId4;
  int almocoId5;
  int jantarId1;
  int jantarId2;
  int jantarId3;
  int jantarId4;

  Cardapio({
    required this.name,
    required this.cafeId1,
    required this.cafeId2,
    required this.cafeId3,
    required this.almocoId1,
    required this.almocoId2,
    required this.almocoId3,
    required this.almocoId4,
    required this.almocoId5,
    required this.jantarId1,
    required this.jantarId2,
    required this.jantarId3,
    required this.jantarId4,
  });

  Map<String, dynamic> toJson() => {
        CardapioFields.name: name,
        CardapioFields.cafeId1: cafeId1,
        CardapioFields.cafeId2: cafeId2,
        CardapioFields.cafeId3: cafeId3,
        CardapioFields.almocoId1: almocoId1,
        CardapioFields.almocoId2: almocoId2,
        CardapioFields.almocoId3: almocoId3,
        CardapioFields.almocoId4: almocoId4,
        CardapioFields.almocoId5: almocoId5,
        CardapioFields.jantarId1: jantarId1,
        CardapioFields.jantarId2: jantarId2,
        CardapioFields.jantarId3: jantarId3,
        CardapioFields.jantarId4: jantarId4,
      };

  Cardapio copy({
    String? name,
  }) =>
      Cardapio(
        name: name ?? this.name,
        cafeId1: cafeId1,
        cafeId2: cafeId2,
        cafeId3: cafeId3,
        almocoId1: almocoId1,
        almocoId2: almocoId2,
        almocoId3: almocoId3,
        almocoId4: almocoId4,
        almocoId5: almocoId5,
        jantarId1: jantarId1,
        jantarId2: jantarId2,
        jantarId3: jantarId3,
        jantarId4: jantarId4,
      );

  static Cardapio fromJson(Map<String, dynamic> json) => Cardapio(
        name: json[CardapioFields.name] as String,
        cafeId1: json[CardapioFields.cafeId1] as int,
        cafeId2: json[CardapioFields.cafeId2] as int,
        cafeId3: json[CardapioFields.cafeId3] as int,
        almocoId1: json[CardapioFields.almocoId1] as int,
        almocoId2: json[CardapioFields.almocoId2] as int,
        almocoId3: json[CardapioFields.almocoId3] as int,
        almocoId4: json[CardapioFields.almocoId4] as int,
        almocoId5: json[CardapioFields.almocoId5] as int,
        jantarId1: json[CardapioFields.jantarId1] as int,
        jantarId2: json[CardapioFields.jantarId2] as int,
        jantarId3: json[CardapioFields.jantarId3] as int,
        jantarId4: json[CardapioFields.jantarId4] as int,
      );

  @override
  toString() {
    var saida = '''
      $name,
      $cafeId1,
      $cafeId2,
      $cafeId3,
      $almocoId1,
      $almocoId2,
      $almocoId3,
      $almocoId4,
      $almocoId5,
      $jantarId1,
      $jantarId2,
      $jantarId3,
      $jantarId4,
''';
    return saida;
  }
}
