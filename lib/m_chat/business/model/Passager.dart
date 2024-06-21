class Passager {
    String initiateur;
    String chauffeur;
    int nbrEtranger;

    Passager({
        required this.initiateur,
        required this.chauffeur,
        required this.nbrEtranger,
    });

    Passager copyWith({
        String? initiateur,
        String? chauffeur,
        int? nbrEtranger,
    }) => 
        Passager(
            initiateur: initiateur ?? this.initiateur,
            chauffeur: chauffeur ?? this.chauffeur,
            nbrEtranger: nbrEtranger ?? this.nbrEtranger,
        );
}
