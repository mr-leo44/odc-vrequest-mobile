class ChatDetailModel {
    String avatar;
    String ticket;
    String dateDemande;
    String motif;
    String lieuDestination;
    String lieuDepart;
    String status;
    String longitude;
    String latitude;

    ChatDetailModel({
        this.avatar = "assets/images/avatar.jpeg",
        required this.ticket,
        required this.dateDemande,
        required this.motif,
        required this.lieuDestination,
        required this.lieuDepart,
        required this.status,
        this.longitude = "",
        this.latitude = "",
    });

    ChatDetailModel copyWith({
        String? avatar,
        String? ticket,
        String? dateDemande,
        String? motif,
        String? lieuDestination,
        String? lieuDepart,
        String? status,
        String? longitude,
        String? latitude,
    }) => 
        ChatDetailModel(
            avatar: avatar ?? this.avatar,
            ticket: ticket ?? this.ticket,
            dateDemande: dateDemande ?? this.dateDemande,
            motif: motif ?? this.motif,
            lieuDestination: lieuDestination ?? this.lieuDestination,
            lieuDepart: lieuDepart ?? this.lieuDepart,
            status: status ?? this.status,
            longitude: longitude ?? this.longitude,
            latitude: latitude ?? this.latitude,
        );
}
