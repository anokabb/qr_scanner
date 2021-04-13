import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Utils/Localization/app_localizations.dart';
import '../cubit/theme_cubit.dart';
import '../db/database_provider.dart';
import '../models/QR.dart';
import '../components/CustomAppBar.dart';
import '../components/txtField.dart';
import 'ResultScreen.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen();

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  ValueNotifier<String> text = ValueNotifier('');

  final TextEditingController _controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        shape: CustomAppBar(),
        title: Text(
          translate(context, 'create_qr'),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              ClayContainer(
                color: BlocProvider.of<ThemeCubit>(context).state.isDark
                    ? Colors.white
                    : Theme.of(context).canvasColor,
                borderRadius: 16,
                spread:
                    BlocProvider.of<ThemeCubit>(context).state.isDark ? 0 : 10,
                depth: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ValueListenableBuilder<String>(
                    valueListenable: text,
                    builder: (_, value, __) => QrImage(
                      data: value,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TxtField(
                        context,
                        controler: _controller,
                        focusNode: focusNode,
                        hint: translate(context, 'type_text'),
                        autofocus: false,
                        lines: 3,
                        onChanged: (s) => text.value = s,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    child: Icon(
                      Icons.done_outline_rounded,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: createQR,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createQR() {
    if (_controller.text.isNotEmpty) {
      FocusScope.of(context).requestFocus(FocusNode());

      QR Qr = QR(value: _controller.text, isScanned: false);
      DatabaseProvider.db.insert(context, Qr);

      pushNewScreen(
        context,
        screen: ResultScreen(Qr),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.slideUp,
      );
      _controller.text = '';
    }
  }
}
