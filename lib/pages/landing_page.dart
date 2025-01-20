import 'package:currency_exchange_app/models/currency_model.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("CURRENCY EXCHANGE"),
          centerTitle: false,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Colors.black),
        ),
        body: _BodyView());
  }
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
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [kCardGradient1, kCardGradient2, kCardGradient3],
              radius: 3,
              center: Alignment(-1, -1))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Input currency TextField
                  Expanded(
                    flex: 3,
                    child: TextField(
                      autofocus: true,
                      controller: _fromController,
                      maxLength: 14,
                      style: TextStyle(
                          fontSize: kCurrencyFontSize,
                          overflow: TextOverflow.visible),
                      textInputAction: TextInputAction.done,
                      onChanged: (String? value) {
                        model.calculateResult(
                            fromValue: _fromController.text,
                            fromCurrency: model.fromCurrency.value,
                            toCurrency: model.toCurrency.value);
                      },
                      decoration: InputDecoration(
                          label: Row(
                            children: [
                              Icon(size: 18, CupertinoIcons.arrow_up_right),
                              SizedBox(width: 8),
                              Text("Enter Amount"),
                            ],
                          ),
                          border: InputBorder.none,
                          filled: false,
                          counterText: "",
                          hintText: "From"),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  // Expanded(
                  //   flex: 1,
                  //   child: SizedBox(
                  //     width: 8,
                  //   ),
                  // ),
                  // Input currency DropDownMenu

                  Expanded(
                    flex: 2,
                    child: ValueListenableBuilder(
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
                                border: InputBorder.none,
                                filled: false,
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
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            // Swap currencies Button

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FilledButton.icon(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.inverseSurface)),
                onPressed: () {
                  model.swapCurrencies();
                  model.calculateResult(
                      fromValue: _fromController.text,
                      fromCurrency: model.fromCurrency.value,
                      toCurrency: model.toCurrency.value);
                },
                label: Text(''),
                icon: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 68, right: 60),
                  child: Icon(
                    CupertinoIcons.arrow_up_arrow_down,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                // iconSize: 16,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Output currency read only TextField

                  Expanded(
                    flex: 3,
                    child: ValueListenableBuilder(
                        valueListenable: model.result,
                        builder: (BuildContext context, String value, child) {
                          return TextField(
                            readOnly: true,
                            style: TextStyle(
                                fontSize: kCurrencyFontSize,
                                overflow: TextOverflow.fade),
                            controller: TextEditingController(text: value),
                            decoration: InputDecoration(
                                label: Row(
                                  children: [
                                    Icon(
                                        size: 18,
                                        CupertinoIcons.arrow_down_left),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text("You receive"),
                                  ],
                                ),
                                border: InputBorder.none,
                                filled: false,
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                                hintText: "To"),
                            keyboardType: TextInputType.number,
                          );
                        }),
                  ),
                  // Output currency DropDownMenu

                  Expanded(
                    flex: 2,
                    child: ValueListenableBuilder(
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
                                border: InputBorder.none,
                                filled: false,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
