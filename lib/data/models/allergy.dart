enum Allergies {
  lactose,
  nuts,
  gluten,
  shellfish,
  eggs,
  soy,
  wheat,
  fish,
  peanuts,
  sesame,
}

class Allergy {
  final Allergies allergy;

  const Allergy({required this.allergy});

  String get name {
    switch (allergy) {
      case Allergies.lactose:
        return 'Lactose';
      case Allergies.nuts:
        return 'Nuts';
      case Allergies.gluten:
        return 'Gluten';
      case Allergies.shellfish:
        return 'Shellfish';
      case Allergies.eggs:
        return 'Eggs';
      case Allergies.soy:
        return 'Soy';
      case Allergies.wheat:
        return 'Wheat';
      case Allergies.fish:
        return 'Fish';
      case Allergies.peanuts:
        return 'Peanuts';
      case Allergies.sesame:
        return 'Sesame';
      default:
        return '';
    }
  }
}
