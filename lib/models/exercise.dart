class Exercise {
  final String name;
  final String detail;
  final String muscle;
  final String image;
  final String video;
  final int? calorieBurn;
  final String difficulty; //ระดับความยาก (เช่น beginner, intermediate, advanced)
  final String equipment; //อุปกรณ์ที่ใช้ (เช่น dumbbell, barbell, bodyweight)


  Exercise({required this.name,required this.detail,required this.muscle,required this.image,required this.video,this.calorieBurn,required this.difficulty,required this.equipment});
}