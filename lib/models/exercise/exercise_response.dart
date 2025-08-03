class ExerciseResponse {
  bool? success;
  String? message;
  Map<String, List<Exercise>>? exercisesData;

  ExerciseResponse({this.exercisesData});

  ExerciseResponse.fromJson(Map<String?, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      exercisesData = <String, List<Exercise>>{};
      (json['data'] as Map<String, dynamic>).forEach((key, value) {
        if (value is List) {
          exercisesData![key] = value
              .map((item) => Exercise.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (exercisesData != null) {
      data['data'] = <String, dynamic>{};
      exercisesData!.forEach((key, exerciseList) {
        data['data'][key] = exerciseList.map((exercise) => exercise.toJson()).toList();
      });
    }
    return data; 
  }
}

class Exercise {
  String? id;
  String? name;
  String? detail;
  String? muscle;
  String? image;
  String? video;
  int? calorieBurn;
  String? difficulty; // ระดับความยาก (เช่น beginner, intermediate, advanced)
  String? equipment; // อุปกรณ์ที่ใช้ (เช่น dumbbell, barbell, bodyweight)
  int? sets;
  int? reps;
  List<String>? images;

  Exercise({
    this.id,
    this.name,
    this.detail,
    this.muscle,
    this.image,
    this.video,
    this.calorieBurn,
    this.difficulty,
    this.equipment,
    this.sets,
    this.reps,
    this.images,
  });

  // เปลี่ยนเป็น static method เพื่อให้ใช้ได้ง่ายกว่า
  static String switchMuscle(String muscle) {
    switch (muscle.toUpperCase()) {
      case 'CHEST':
        return 'อก';
      case 'SHOULDER':
        return 'ไหล่';
      case 'LEG':
        return 'ขา';
      case 'TRICEP':
        return 'หลังแขน';
      case 'BICEP':
        return 'หน้าแขน';
      case 'FOREARM':
        return 'ท่อนแขน';
      case 'BACK':
        return 'หลัง';
      case 'CALF':
        return 'น่อง';
      case 'SIXPACK':
        return 'หน้าท้อง';
      default:
        return 'อื่นๆ';
    }
  }

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    detail = json['detail']?.toString() ?? '';
    muscle = switchMuscle(json['muscle']?.toString() ?? '');
    image = json['image']?.toString() ?? '';
    video = json['video']?.toString() ?? '';
    calorieBurn = _parseToInt(json['calorieBurn']);
    difficulty = json['difficulty']?.toString() ?? '';
    equipment = json['equipment']?.toString() ?? '';
    sets = _parseToInt(json['sets']);
    reps = _parseToInt(json['reps']);
    
    if (json['images'] != null && json['images'] is List) {
      images = List<String>.from(json['images'].map((x) => x.toString()));
    } else {
      images = <String>[];
    }
  }

  // Helper method สำหรับแปลงเป็น int อย่างปลอดภัย
  int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    if (value is double) return value.toInt();
    return 0;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['detail'] = detail;
    data['muscle'] = muscle;
    data['image'] = image;
    data['video'] = video;
    data['calorieBurn'] = calorieBurn;
    data['difficulty'] = difficulty;
    data['equipment'] = equipment;
    data['sets'] = sets;
    data['reps'] = reps;
    data['images'] = images;
    return data;
  }

  // เพิ่ม method สำหรับ debug
  @override
  String toString() {
    return 'Exercise{id: $id, name: $name, muscle: $muscle, calorieBurn: $calorieBurn}';
  }
}