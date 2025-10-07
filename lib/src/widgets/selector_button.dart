import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/utils/selector_config.dart';
import 'package:intl_phone_number_input/src/utils/test/test_helper.dart';
import 'package:intl_phone_number_input/src/widgets/countries_search_list_widget.dart';
import 'package:intl_phone_number_input/src/widgets/input_widget.dart';
import 'package:intl_phone_number_input/src/widgets/item.dart';

/// [SelectorButton]
class SelectorButton extends StatelessWidget {
  final List<Country> countries;
  final Country? country;
  final SelectorConfig selectorConfig;
  final TextStyle? selectorTextStyle;
  final InputDecoration? searchBoxDecoration;
  final bool autoFocusSearchField;
  final String? locale;
  final bool isEnabled;
  final bool isScrollControlled;
  final ButtonStyle? buttonStyle;

  final ValueChanged<Country?> onCountryChanged;

  const SelectorButton({
    Key? key,
    required this.countries,
    required this.country,
    required this.selectorConfig,
    required this.selectorTextStyle,
    required this.searchBoxDecoration,
    required this.autoFocusSearchField,
    required this.locale,
    required this.onCountryChanged,
    required this.isEnabled,
    required this.isScrollControlled,
    this.buttonStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectorConfig.selectorType == PhoneInputSelectorType.DROPDOWN
        ? countries.isNotEmpty && countries.length > 1
            ? DropdownButtonHideUnderline(
                child: DropdownButton<Country>(
                  key: Key(TestHelper.DropdownButtonKeyValue),
                  hint: Item(
                    country: country,
                    showFlag: selectorConfig.showFlags,
                    useEmoji: selectorConfig.useEmoji,
                    leadingPadding: selectorConfig.leadingPadding,
                    trailingSpace: selectorConfig.trailingSpace,
                    textStyle: selectorTextStyle,
                    suffixIcon: selectorConfig.suffixIcon,
                    paddingSuffixIcon: selectorConfig.paddingSuffixIcon,
                  ),
                  value: country,
                  items: mapCountryToDropdownItem(countries),
                  onChanged: isEnabled ? onCountryChanged : null,
                ),
              )
            : Item(
                country: country,
                showFlag: selectorConfig.showFlags,
                useEmoji: selectorConfig.useEmoji,
                leadingPadding: selectorConfig.leadingPadding,
                trailingSpace: selectorConfig.trailingSpace,
                textStyle: selectorTextStyle,
                suffixIcon: selectorConfig.suffixIcon,
                paddingSuffixIcon: selectorConfig.paddingSuffixIcon,
              )
        : ElevatedButton(
            key: Key(TestHelper.DropdownButtonKeyValue),
            style: ButtonStyle(
              minimumSize: buttonStyle != null && buttonStyle!.minimumSize != null ? buttonStyle!.minimumSize : ButtonStyleButton.allOrNull(const Size(0, 0)),
              alignment: buttonStyle != null && buttonStyle!.alignment != null ? buttonStyle!.alignment : null,
              animationDuration: buttonStyle != null && buttonStyle!.animationDuration != null ? buttonStyle!.animationDuration : null,
              backgroundBuilder: buttonStyle != null && buttonStyle!.backgroundBuilder != null ? buttonStyle!.backgroundBuilder : null,
              backgroundColor: buttonStyle != null && buttonStyle!.backgroundColor != null ? buttonStyle!.backgroundColor : null,
              elevation: buttonStyle != null && buttonStyle!.elevation != null ? buttonStyle!.elevation : null,
              enableFeedback: buttonStyle != null && buttonStyle!.enableFeedback != null ? buttonStyle!.enableFeedback : null,
              fixedSize: buttonStyle != null && buttonStyle!.fixedSize != null ? buttonStyle!.fixedSize : null,
              foregroundBuilder: buttonStyle != null && buttonStyle!.foregroundBuilder != null ? buttonStyle!.foregroundBuilder : null,
              foregroundColor: buttonStyle != null && buttonStyle!.foregroundColor != null ? buttonStyle!.foregroundColor : null,
              iconAlignment: buttonStyle != null && buttonStyle!.iconAlignment != null ? buttonStyle!.iconAlignment : null,
              iconColor: buttonStyle != null && buttonStyle!.iconColor != null ? buttonStyle!.iconColor : null,
              iconSize: buttonStyle != null && buttonStyle!.iconSize != null ? buttonStyle!.iconSize : null,
              maximumSize: buttonStyle != null && buttonStyle!.maximumSize != null ? buttonStyle!.maximumSize : null,
              mouseCursor: buttonStyle != null && buttonStyle!.mouseCursor != null ? buttonStyle!.mouseCursor : null,
              overlayColor: buttonStyle != null && buttonStyle!.overlayColor != null ? buttonStyle!.overlayColor : null,
              padding: buttonStyle != null && buttonStyle!.padding != null ? buttonStyle!.padding : null,
              shadowColor: buttonStyle != null && buttonStyle!.shadowColor != null ? buttonStyle!.shadowColor : null,
              shape: buttonStyle != null && buttonStyle!.shape != null ? buttonStyle!.shape : null,
              side: buttonStyle != null && buttonStyle!.side != null ? buttonStyle!.side : null,
              splashFactory: buttonStyle != null && buttonStyle!.splashFactory != null ? buttonStyle!.splashFactory : null,
              surfaceTintColor: buttonStyle != null && buttonStyle!.surfaceTintColor != null ? buttonStyle!.surfaceTintColor : null,
              tapTargetSize: buttonStyle != null && buttonStyle!.tapTargetSize != null ? buttonStyle!.tapTargetSize : null,
              textStyle: buttonStyle != null && buttonStyle!.textStyle != null ? buttonStyle!.textStyle : null,
              visualDensity: buttonStyle != null && buttonStyle!.visualDensity != null ? buttonStyle!.visualDensity : null
            ),
            onPressed: countries.length > 1 && isEnabled
                ? () async {
                    Country? selected;
                    if (selectorConfig.selectorType ==
                        PhoneInputSelectorType.BOTTOM_SHEET) {
                      selected = await showCountrySelectorBottomSheet(
                          context, countries);
                    } else {
                      selected =
                          await showCountrySelectorDialog(context, countries);
                    }

                    if (selected != null) {
                      onCountryChanged(selected);
                    }
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Item(
                country: country,
                showFlag: selectorConfig.showFlags,
                useEmoji: selectorConfig.useEmoji,
                leadingPadding: selectorConfig.leadingPadding,
                trailingSpace: selectorConfig.trailingSpace,
                textStyle: selectorTextStyle,
                suffixIcon: selectorConfig.suffixIcon,
                paddingSuffixIcon: selectorConfig.paddingSuffixIcon,
              ),
            ),
          );
  }

  /// Converts the list [countries] to `DropdownMenuItem`
  List<DropdownMenuItem<Country>> mapCountryToDropdownItem(
      List<Country> countries) {
    return countries.map((country) {
      return DropdownMenuItem<Country>(
        value: country,
        child: Item(
          key: Key(TestHelper.countryItemKeyValue(country.alpha2Code)),
          country: country,
          showFlag: selectorConfig.showFlags,
          useEmoji: selectorConfig.useEmoji,
          textStyle: selectorTextStyle,
          withCountryNames: false,
          trailingSpace: selectorConfig.trailingSpace,
        ),
      );
    }).toList();
  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.DIALOG] is selected
  Future<Country?> showCountrySelectorDialog(
      BuildContext inheritedContext, List<Country> countries) {
    return showDialog(
      context: inheritedContext,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        content: Directionality(
          textDirection: Directionality.of(inheritedContext),
          child: Container(
            width: double.maxFinite,
            child: CountrySearchListWidget(
              countries,
              locale,
              searchBoxDecoration: searchBoxDecoration,
              showFlags: selectorConfig.showFlags,
              useEmoji: selectorConfig.useEmoji,
              autoFocus: autoFocusSearchField,
            ),
          ),
        ),
      ),
    );
  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.BOTTOM_SHEET] is selected
  Future<Country?> showCountrySelectorBottomSheet(
      BuildContext inheritedContext, List<Country> countries) {
    return showModalBottomSheet(
      context: inheritedContext,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      useSafeArea: selectorConfig.useBottomSheetSafeArea,
      builder: (BuildContext context) {
        return Stack(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: DraggableScrollableSheet(
              builder: (BuildContext context, ScrollController controller) {
                return Directionality(
                  textDirection: Directionality.of(inheritedContext),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: CountrySearchListWidget(
                      countries,
                      locale,
                      searchBoxDecoration: searchBoxDecoration,
                      scrollController: controller,
                      showFlags: selectorConfig.showFlags,
                      useEmoji: selectorConfig.useEmoji,
                      autoFocus: autoFocusSearchField,
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
      },
    );
  }
}
