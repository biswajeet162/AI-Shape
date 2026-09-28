import 'package:ai_photo_studio/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home screen shows app identity and tabs', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AiPhotoStudioApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('AI Photo Studio'), findsWidgets);
    expect(find.text('Create. Transform. Share.'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Trending'), findsOneWidget);
  });
}
