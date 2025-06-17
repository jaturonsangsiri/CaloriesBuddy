class ExerciseFormula {
  double bmrCalculate(num weight, num height, num age, String gender) {
    double bmr = 10 * weight + 6.25 * height - 5 * age;
    if (gender == "ชาย") {
      bmr += 5;
    } else {
      bmr -= 161;
    }
    return bmr;
  }

  double activiyCase(String activity) {
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
}