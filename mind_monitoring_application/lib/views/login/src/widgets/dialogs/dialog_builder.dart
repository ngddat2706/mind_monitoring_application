import '/views/login/animated_login.dart';
import '../../decorations/text_styles.dart';
import '../../providers/login_theme.dart';
import '../../widgets/dialogs/animated_dialog.dart';
import '../../widgets/dialogs/single_choose_dialog.dart';
import '../../widgets/texts/base_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Dialog builder for displaying dialogs.
class DialogBuilder {
  /// Dialog builder for displaying dialogs.
  const DialogBuilder(this.context);

  /// Context to customize sizes.
  final BuildContext context;

  /// Shows error dialog.
  void showErrorDialog(String text) =>
      AnimatedDialog(contentText: text).show<void>(context);

  /// Shows multiple selection dialog.
  Future<int?> showSelectDialog(
    String titleText,
    List<LanguageOption> elements,
    LanguageOption? initialValue,
  ) async =>
      AnimatedDialog(
        content: SingleChooseDialog(
          elements: elements,
          initialValue: initialValue,
          theme: context.read<LoginTheme>().dialogTheme?.languageDialogTheme,
        ),
        title: _getSelectTitle(titleText),
      ).show(context);

  Widget _getSelectTitle(String titleText) => BaseText(
        titleText,
        style: context.read<LoginTheme>().dialogTheme?.titleStyle ??
            TextStyles(context).subBodyStyle(
              color: Theme.of(context).primaryColor.withOpacity(.7),
            ),
      );
}
