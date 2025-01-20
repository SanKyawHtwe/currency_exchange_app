import 'package:currency_exchange_app/models/currency_model.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:flag/flag.dart';
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
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.onSurfaceVariant),
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
    void showFromBottomSheet() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [kCardGradient1, kCardGradient2, kCardGradient3],
                    radius: 3,
                    center: Alignment(-2, -1)),
                borderRadius: BorderRadius.circular(20)),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Select currency",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: Currencies.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            final currency = Currencies.values[index];
                            return ListTile(
                              leading: Flag.fromCode(
                                currency.flag,
                                width: 24,
                                height: 24,
                                flagSize: FlagSize.size_1x1,
                              ),
                              title: Text(currency.name),
                              onTap: () {
                                model.fromCurrency.value = currency;
                                model.calculateResult(
                                    fromValue: _fromController.text,
                                    fromCurrency: model.fromCurrency.value,
                                    toCurrency: model.toCurrency.value);
                                Navigator.pop(context);
                              },
                            );
                          })),
                  Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: FilledButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.inverseSurface)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    void showToBottomSheet() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [kCardGradient1, kCardGradient2, kCardGradient3],
                    radius: 3,
                    center: Alignment(-2, -1)),
                borderRadius: BorderRadius.circular(20)),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Select currency",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: Currencies.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            final currency = Currencies.values[index];
                            return ListTile(
                              leading: Flag.fromCode(
                                currency.flag,
                                width: 24,
                                height: 24,
                                flagSize: FlagSize.size_1x1,
                              ),
                              title: Text(currency.name),
                              onTap: () {
                                model.toCurrency.value = currency;
                                model.calculateResult(
                                    fromValue: _fromController.text,
                                    fromCurrency: model.fromCurrency.value,
                                    toCurrency: model.toCurrency.value);
                                Navigator.pop(context);
                              },
                            );
                          })),
                  Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: FilledButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.inverseSurface)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Input currency TextField
                  Expanded(
                    flex: 5,
                    child: TextField(
                      autofocus: false,
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
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          border: InputBorder.none,
                          filled: false,
                          counterText: "",
                          hintText: "From"),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  SizedBox(
                    width: 8,
                  ),
                  // Input currency DropDownMenu

                  Expanded(
                    flex: 2,
                    child: ValueListenableBuilder(
                        valueListenable: model.fromCurrency,
                        builder:
                            (BuildContext context, Currencies value, child) {
                          return InkWell(
                            onTap: showFromBottomSheet,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Flag.fromCode(
                                    model.fromCurrency.value.flag,
                                    width: 24,
                                    height: 24,
                                    flagSize: FlagSize.size_1x1,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(model.fromCurrency.value.label),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(child: Icon(Icons.arrow_drop_down))
                              ],
                            ),
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

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
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
                      top: 18, bottom: 18, left: 68, right: 60),
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
                    flex: 5,
                    child: ValueListenableBuilder(
                        valueListenable: model.result,
                        builder: (BuildContext context, String value, child) {
                          return TextField(
                            readOnly: true,
                            style: TextStyle(
                              fontSize: kCurrencyFontSize,
                            ),
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
                                labelStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
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
                  const SizedBox(
                    width: 8,
                  ),
                  // Output currency DropDownMenu

                  Expanded(
                    flex: 2,
                    child: ValueListenableBuilder(
                        valueListenable: model.toCurrency,
                        builder:
                            (BuildContext context, Currencies value, child) {
                          return InkWell(
                            onTap: showToBottomSheet,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Flag.fromCode(
                                    model.toCurrency.value.flag,
                                    width: 24,
                                    height: 24,
                                    flagSize: FlagSize.size_1x1,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(model.toCurrency.value.label),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(child: Icon(Icons.arrow_drop_down))
                              ],
                            ),
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
