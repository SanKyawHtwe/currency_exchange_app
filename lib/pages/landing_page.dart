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
  final ValueNotifier<double> result = ValueNotifier<double>(0.00);

  void swapCurrencies() {
    tmp.value = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = tmp.value;
  }

  final Map<Currencies, Map<Currencies, double>> exchangeRates = {
    Currencies.usd: {
      Currencies.usd: 1.0,
      Currencies.mmk: 2078.61,
      Currencies.php: 58.5142,
      Currencies.thb: 34.558,
    },
    Currencies.mmk: {
      Currencies.usd: 0.00047,
      Currencies.mmk: 1.0,
      Currencies.php: 0.02761,
      Currencies.thb: 0.01631,
    },
    Currencies.php: {
      Currencies.usd: 0.01707,
      Currencies.mmk: 36.2169,
      Currencies.php: 1.0,
      Currencies.thb: 0.59125,
    },
    Currencies.thb: {
      Currencies.usd: 0.02892,
      Currencies.mmk: 60.1035,
      Currencies.php: 1.69195,
      Currencies.thb: 1.0,
    },
  };

  void calculateResult({
    required String fromValue,
    required Currencies fromCurrency,
    required Currencies toCurrency,
  }) {
    if (fromValue.isEmpty) {
      result.value = 0.0;
      return;
    }

    try {
      double amount = double.parse(fromValue);

      double exchangeRate = exchangeRates[fromCurrency]?[toCurrency] ?? 1.0;

      result.value = amount * exchangeRate;
    } catch (e) {
      result.value = 0.0;
    }
  }
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
  final model = CurrencyModel();
  final TextEditingController _fromController = TextEditingController();

  @override
  void dispose() {
    _fromController.dispose();
    super.dispose();
  }

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
                                model.calculateResult(
                                    fromValue: _fromController.text,
                                    fromCurrency: model.fromCurrency.value,
                                    toCurrency: model.toCurrency.value);
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
                        controller: _fromController,
                        onChanged: (String? value) {
                          model.calculateResult(
                              fromValue: _fromController.text,
                              fromCurrency: model.fromCurrency.value,
                              toCurrency: model.toCurrency.value);
                        },
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
                    model.swapCurrencies();
                    model.calculateResult(
                        fromValue: _fromController.text,
                        fromCurrency: model.fromCurrency.value,
                        toCurrency: model.toCurrency.value);
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
                                model.calculateResult(
                                    fromValue: _fromController.text,
                                    fromCurrency: model.fromCurrency.value,
                                    toCurrency: model.toCurrency.value);
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
                      ValueListenableBuilder(
                          valueListenable: model.result,
                          builder: (BuildContext context, double value, child) {
                            return TextField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: value.toString()),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  hintText: '$value'),
                              keyboardType: TextInputType.number,
                            );
                          }),
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
