import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _BodyView();
  }
}

class CurrencyModel {
  final ValueNotifier<Currencies> fromCurrency =
      ValueNotifier<Currencies>(Currencies.usd);
  final ValueNotifier<Currencies> toCurrency =
      ValueNotifier<Currencies>(Currencies.mmk);
  final ValueNotifier<Currencies> tmp =
      ValueNotifier<Currencies>(Currencies.php);
}

enum Currencies {
  usd('USD', Icons.flag),
  thb('THB', Icons.flag_circle_outlined),
  php('PHP', Icons.flag_circle_rounded),
  mmk('MMK', Icons.flag_circle);

  const Currencies(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _BodyView extends StatefulWidget {
  @override
  State<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<_BodyView> {
  Currencies selectedFromCurrency = Currencies.usd;
  Currencies selectedToCurrency = Currencies.mmk;
  final model = CurrencyModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: model.fromCurrency,
                          builder:
                              (BuildContext context, Currencies value, child) {
                            return DropdownMenu<Currencies>(
                              initialSelection: value,
                              onSelected: (Currencies? currency) {
                                if (currency != null) {
                                  model.fromCurrency.value = currency;
                                }
                              },
                              inputDecorationTheme: InputDecorationTheme(
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(16)),
                              leadingIcon: Icon(model.fromCurrency.value.icon),
                              dropdownMenuEntries: Currencies.values
                                  .map<DropdownMenuEntry<Currencies>>(
                                (Currencies currency) {
                                  return DropdownMenuEntry<Currencies>(
                                      leadingIcon: Icon(currency.icon),
                                      value: currency,
                                      label: currency.label);
                                },
                              ).toList(),
                            );
                          }),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).colorScheme.surfaceContainer,
                            filled: true,
                            hintText: "From"),
                        keyboardType: TextInputType.number,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    model.tmp.value = model.fromCurrency.value;
                    model.fromCurrency.value = model.toCurrency.value;
                    model.toCurrency.value = model.tmp.value;
                  },
                  icon: Icon(CupertinoIcons.arrow_right_arrow_left),
                  iconSize: 16,
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: model.toCurrency,
                          builder:
                              (BuildContext context, Currencies value, child) {
                            return DropdownMenu<Currencies>(
                              initialSelection: value,
                              onSelected: (Currencies? currency) {
                                if (currency != null) {
                                  model.toCurrency.value = currency;
                                }
                              },
                              inputDecorationTheme: InputDecorationTheme(
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(16)),
                              leadingIcon: Icon(model.toCurrency.value.icon),
                              dropdownMenuEntries: Currencies.values
                                  .map<DropdownMenuEntry<Currencies>>(
                                (Currencies currency) {
                                  return DropdownMenuEntry<Currencies>(
                                      leadingIcon: Icon(currency.icon),
                                      value: currency,
                                      label: currency.label);
                                },
                              ).toList(),
                            );
                          }),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.surfaceContainer,
                            hintText: "To"),
                        keyboardType: TextInputType.number,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
