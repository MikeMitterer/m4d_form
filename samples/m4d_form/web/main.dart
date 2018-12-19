import 'dart:html' as dom;
import 'package:intl/intl.dart';

import 'package:console_log_handler/console_log_handler.dart';

// For Date- and TimePicker
import 'package:l10n/l10n.dart';
import 'package:intl/intl_browser.dart';
import 'package:m4d_form_sample/_l10n/messages_all.dart';

import 'package:m4d_core/m4d_ioc.dart' as ioc;
import 'package:m4d_core/services.dart' as coreService;
import 'package:m4d_dialog/m4d_dialog.dart';
import "package:m4d_components/m4d_components.dart";

import "package:m4d_form/m4d_form.dart";
import 'package:m4d_form_sample/dialog.dart';

class Application extends MaterialApplication {
    final Logger _logger = new Logger('form_sample.Application');

    @override run() {
        Future(() {
            _bindEvents();
        });
    }

    // - private -----------------------------------------------------------------------------------

    void _bindEvents() {
        final form = MaterialFormComponent.widget(dom.querySelector("#multicontrol"));

        form.onChange.listen((final FormChangedEvent event) {
            final MaterialNotification notification = new MaterialNotification();
            notification("${event.currentTarget.runtimeType} changed!",type: NotificationType.INFO).show();
            //_logger.info("${event.currentTarget.runtimeType} changed!");
        });

        final button = MaterialButton.widget(dom.querySelector("#open-dialog"));
        button.onClick.listen((_) {
            final dialog = new TimeFrameDialog();
            dialog.show().then((final MdlDialogStatus status) {
                if(status == MdlDialogStatus.OK) {
                    final message = "${new DateFormat("dd.MM.yyyy HH:mm").format(dialog.from)}"
                                    " - "
                                    "${new DateFormat("dd.MM.yyyy HH:mm").format(dialog.to)}";

                    final MaterialNotification notification = new MaterialNotification();
                    notification(message,type: NotificationType.INFO).show();
                }
            });
        });
    }
}

main() async {
    // final Logger _logger = new Logger('mdlx_form.main');

    configLogging();

    // initLanguageSettings checks the browser url if it finds
    // a "lang" query param and sets the locale accordingly
    final String locale = await initLanguageSettings(
            () => findSystemLocale(),
            (final String locale) => initializeMessages(locale)
    );
    (dom.querySelector("head") as dom.HeadElement).lang = locale;

    // Initialize M4D
    ioc.Container.bindModules([
        DialogModule(), FormModule(), CoreComponentsModule()
    ]).bind(coreService.Application).to(Application());

    final Application app = await componentHandler().upgrade();
    app.run();
}

