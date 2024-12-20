class OnboardingModel {
  final String title;
  final String description;
  final String image;

  OnboardingModel(
      {required this.title, required this.description, required this.image});
}

List<OnboardingModel> onboardingPage = [
  OnboardingModel(
    title: "بحث عن دكتور متخصص",
    description: "اكتشف مجموعة واسعة من الأطباء الخبراء والمتخصصين في مختلف المجالات.",
    image: "assets/images/on1.svg"
  ),

  //
   OnboardingModel(
    title: "سهولة الحجز",
    description: "احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان.",
    image: "assets/images/on2.svg"
  ),

  //
   OnboardingModel(
    title: 'آمن وسري',
    description: "كن مطمئنًا لأن خصوصيتك وأمانك هما أهم أولوياتنا.",
    image: "assets/images/on3.svg"
  ),
];
