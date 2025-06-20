class ExerciseFormula {
  num bmrCalculate(num weight, num height, num age, String gender) {
    double bmr = 10 * weight + 6.25 * height - 5 * age;
    if (gender == "ชาย") {
      bmr += 5;
    } else {
      bmr -= 161;
    }
    return bmr;
  }

  // activity level Table 
  double activiyCase(String activity) {
    /*
    ไม่ค่อยออกกำลังกาย Sedentary: 1.2
    ออกกำลังกายบ้าง Lightly active: 1.375
    ออกกำลังปานกลาง Moderately active: 1.55
    ออกกำลังกายบ่อย Very active: 1.725
    ออกกำลังกายบ่อยมาก Super active: 1.9
    */

    switch (activity) {
      case "Sedentary":
        return 1.2;
      case "Lightly active":
        return 1.375;
      case "Moderately active":
        return 1.55;
      case "Very active":
        return 1.725;
      default:
        return 1.9;
    }
  }

  double proteinCase(String activity) {
    switch (activity) {
      case "Sedentary":
        return 1.0;
      case "Moderately active":
        return 1.6;
      default:
        return 1.8;
    }
  } 

  // calcolate protein
  num calPotein(num weight, String activity) {
    return weight * proteinCase(activity);
  }

  // calculate fat
  num calFat(double calories) {
    return calories * 0.25 / 9;
  }

  // calculate carbohydrate
  num calCarbohydrate(double calories) {
    return calories * 0.5 / 4;
  }
}