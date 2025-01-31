import 'package:currency_exchange_app/data/models/currency_model.dart';
import 'package:currency_exchange_app/ui/providers/currency_provider.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/custom_progress_indicator.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(kLandingPageTitle),
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: kTitleFontSize,
              color: Theme.of(context).colorScheme.onSurface),
        ),
        body: _BodyView());
  }
}

class _BodyView extends StatefulWidget {
  @override
  State<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<_BodyView> {
  final TextEditingController _fromController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CurrencyProvider>(context, listen: false).getExchangeRate();
    });
  }

  @override
  void dispose() {
    _fromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final lastUpdatedAt = currencyProvider.currencyData?.meta?.lastUpdatedAt;
    DateTime formattedDate =
        DateTime.parse(lastUpdatedAt ?? DateTime.now().toString());
    String lastUpdatedDate =
        DateFormat('MMM d, y – h:mm a').format(formattedDate);

    final Map<Code, String> flags = {
      Code.USD: 'US',
      Code.THB: 'TH',
      Code.MMK: 'MM',
      Code.PHP: 'PH',
      Code.KHR: 'KH',
      Code.VND: 'VN',
      Code.SGD: 'SG',
      Code.LAK: 'LA',
    };

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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    kBottomSheetTitle,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: Code.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Flag.fromString(
                                flags[Code.values[index]] ?? 'US',
                                width: 24,
                                height: 24,
                                flagSize: FlagSize.size_1x1,
                              ),
                              title: Text(Code.values[index].value),
                              onTap: () {
                                currencyProvider.fromCurrency.value =
                                    Code.values[index];
                                currencyProvider.calculateResult(
                                  inputAmount: _fromController.text,
                                  fromCurrency:
                                      currencyProvider.fromCurrency.value,
                                  toCurrency: currencyProvider.toCurrency.value,
                                );
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    kBottomSheetTitle,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: Code.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Flag.fromString(
                                flags[Code.values[index]] ?? 'US',
                                width: 24,
                                height: 24,
                                flagSize: FlagSize.size_1x1,
                              ),
                              title: Text(Code.values[index].value),
                              onTap: () {
                                currencyProvider.toCurrency.value =
                                    Code.values[index];

                                currencyProvider.calculateResult(
                                  inputAmount: _fromController.text,
                                  fromCurrency:
                                      currencyProvider.fromCurrency.value,
                                  toCurrency: currencyProvider.toCurrency.value,
                                );
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
                          kBottomSheetCancelText,
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

    // Body view

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: currencyProvider.isLoading
              ? Center(
                  child: CustomProgressIndicator(),
                )
              : SafeArea(
                  child: currencyProvider.errorMessage != null
                      ? buildErrorScreen('${currencyProvider.errorMessage}')
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            currencyProvider.calculateResult(
                                              inputAmount: _fromController.text,
                                              fromCurrency: currencyProvider
                                                  .fromCurrency.value,
                                              toCurrency: currencyProvider
                                                  .toCurrency.value,
                                            );
                                          },
                                          decoration: InputDecoration(
                                              label: Row(
                                                children: [
                                                  Icon(
                                                      size: 18,
                                                      CupertinoIcons
                                                          .arrow_up_right),
                                                  SizedBox(width: 8),
                                                  Text(kInputCurrencyText),
                                                ],
                                              ),
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                              border: InputBorder.none,
                                              filled: false,
                                              counterText: "",
                                              enabled:
                                                  !currencyProvider.isLoading,
                                              hintText: kInputCurrencyHintText),
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
                                            valueListenable:
                                                currencyProvider.fromCurrency,
                                            builder: (BuildContext context,
                                                Code code, child) {
                                              return InkWell(
                                                onTap: showFromBottomSheet,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Flag.fromString(
                                                        flags[code] ?? 'US',
                                                        width: 24,
                                                        height: 24,
                                                        flagSize:
                                                            FlagSize.size_1x1,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(code.value),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                        child: Icon(Icons
                                                            .arrow_drop_down))
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
                                            Theme.of(context)
                                                .colorScheme
                                                .inverseSurface)),
                                    onPressed: () {
                                      currencyProvider.swapCurrencies();
                                      currencyProvider.calculateResult(
                                        inputAmount: _fromController.text,
                                        fromCurrency:
                                            currencyProvider.fromCurrency.value,
                                        toCurrency:
                                            currencyProvider.toCurrency.value,
                                      );
                                    },
                                    label: Text(''),
                                    icon: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18,
                                          bottom: 18,
                                          left: 68,
                                          right: 60),
                                      child: Icon(
                                        CupertinoIcons.arrow_up_arrow_down,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
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
                                            valueListenable:
                                                currencyProvider.result,
                                            builder: (BuildContext context,
                                                String value, child) {
                                              return TextField(
                                                readOnly: true,
                                                style: TextStyle(
                                                  fontSize: kCurrencyFontSize,
                                                ),
                                                controller:
                                                    TextEditingController(
                                                        text: value),
                                                decoration: InputDecoration(
                                                    label: Row(
                                                      children: [
                                                        Icon(
                                                            size: 18,
                                                            CupertinoIcons
                                                                .arrow_down_left),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                            kOutputCurrencyText),
                                                      ],
                                                    ),
                                                    labelStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                    border: InputBorder.none,
                                                    filled: false,
                                                    fillColor: Theme.of(context)
                                                        .colorScheme
                                                        .surfaceContainer,
                                                    enabled: !currencyProvider
                                                        .isLoading,
                                                    hintText:
                                                        kOutputCurrencyHintText),
                                                keyboardType:
                                                    TextInputType.number,
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
                                            valueListenable:
                                                currencyProvider.toCurrency,
                                            builder: (BuildContext context,
                                                Code code, child) {
                                              return InkWell(
                                                onTap: showToBottomSheet,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Flag.fromString(
                                                        flags[code] ?? 'US',
                                                        width: 24,
                                                        height: 24,
                                                        flagSize:
                                                            FlagSize.size_1x1,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(code.value),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                        child: Icon(Icons
                                                            .arrow_drop_down))
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    kLastUpdatedAtText,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(lastUpdatedDate,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
                                )
                              ],
                            ),
                          ],
                        ),
                ),
        ),
      ),
    );
  }

  Widget buildErrorScreen(String message) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.inverseSurface),
            ),
            onPressed: () {
              Provider.of<CurrencyProvider>(context, listen: false)
                  .getExchangeRate();
            },
            child: Text(kRetryButtonText,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.surfaceContainer)),
          )
        ],
      ),
    );
  }
}
