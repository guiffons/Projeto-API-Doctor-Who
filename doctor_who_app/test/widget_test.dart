import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_who_app/main.dart';

void main() {
  testWidgets('App carrega a tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const DoctorWhoApp());

    expect(find.text('Doctor Who App'), findsOneWidget);
    expect(find.text('Doctors'), findsOneWidget);
    expect(find.text('Vilões'), findsOneWidget);
  });
}
