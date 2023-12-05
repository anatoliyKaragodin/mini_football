class Player {
  final int imgIndex;
  final bool isWin;

//<editor-fold desc="Data Methods">
  const Player({
    required this.imgIndex,
    required this.isWin,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          runtimeType == other.runtimeType &&
          imgIndex == other.imgIndex &&
          isWin == other.isWin);

  @override
  int get hashCode => imgIndex.hashCode ^ isWin.hashCode;

  @override
  String toString() {
    return 'Player{' + ' imgIndex: $imgIndex,' + ' isWin: $isWin,' + '}';
  }

  Player copyWith({
    int? imgIndex,
    bool? isWin,
  }) {
    return Player(
      imgIndex: imgIndex ?? this.imgIndex,
      isWin: isWin ?? this.isWin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imgIndex': this.imgIndex,
      'isWin': this.isWin,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      imgIndex: map['imgIndex'] as int,
      isWin: map['isWin'] as bool,
    );
  }

//</editor-fold>
}