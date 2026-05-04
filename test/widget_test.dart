// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myapp/main.dart';

void main() {
  testWidgets('Product display smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MiTiendaDeFlores());

    // Verify that the main title is displayed.
    expect(find.text('Conoce nuestros Productos más Vendidos'), findsOneWidget);

    // pumpAndSettle waits for frames to settle, which is useful
    // for waiting for things like network images to load.
    await tester.pumpAndSettle();

    // Verify that our product cards are being displayed.
    expect(find.byType(Card), findsNWidgets(4));

    // Verify that one of the product names is visible.
    expect(find.text('Ramo Romántico'), findsOneWidget);
    
    // Verify that the "Añadir al carrito" buttons are present.
    expect(find.widgetWithText(ElevatedButton, 'Añadir al carrito'), findsNWidgets(4));
  });
}
