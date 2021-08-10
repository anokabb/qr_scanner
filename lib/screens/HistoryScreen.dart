import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../components/Ads.dart';
import '../Utils/Localization/app_localizations.dart';
import '../components/QrIconType.dart';
import '../cubit/locale_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../models/Languages.dart';
import '../bloc/qr_bloc.dart';
import '../db/database_provider.dart';
import '../models/QR.dart';
import '../components/CustomAppBar.dart';
import '../cubit/history_cubit.dart';
import 'ResultScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen();

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getQrs(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          // brightness: Brightness.light,
          centerTitle: true,
          shape: CustomAppBar(),
          title: Text(
            translate(context, 'history'),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, historyState) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClayContainer(
                        color: Theme.of(context).canvasColor,
                        borderRadius: 50,
                        spread:
                            BlocProvider.of<ThemeCubit>(context).state.isDark
                                ? 0
                                : 10,
                        depth: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<HistoryCubit>(context)
                                      .scannedHistory();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(
                                            historyState is HistoryScanned
                                                ? 1
                                                : 0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 20),
                                    child: Text(
                                      translate(context, 'scanned'),
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<HistoryCubit>(context)
                                      .createdHistory();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(
                                            historyState is HistoryScanned
                                                ? 0.5
                                                : 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 20),
                                    child: Text(
                                      translate(context, 'created'),
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocConsumer<QrBloc, List<QR>>(
                        builder: (context, Qrs) {
                          return RefreshIndicator(
                            color: Theme.of(context).primaryColor,
                            onRefresh: () {
                              return DatabaseProvider.db.getQrs(context);
                            },
                            child: _getHistoryList(
                              historyState,
                              BlocProvider.of<LocaleCubit>(context)
                                  .state
                                  .langCode,
                              Qrs,
                            ),
                          );
                        },
                        listener: (_, __) {},
                      ),
                    ),
                  ],
                );
              }),
            ),
            // MyBanner(),
          ],
        ),
      ),
    );
  }

  Widget _getHistoryList(
      HistoryState historyState, String langCode, List<QR> Qrs) {
    if (historyState is HistoryScanned) {}
    List<QR> _qrList = (historyState is HistoryScanned)
        ? Qrs.where((qr) => qr.isScanned == true).toList()
        : Qrs.where((qr) => qr.isScanned == false).toList();

    if (_qrList.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'images/noData.svg',
            width: MediaQuery.of(context).size.width / 2,
          ),
          SizedBox(height: 10),
          Text(
            translate(context, 'no_data'),
            style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 30),
          )
        ],
      );
    }
    return ListView.separated(
      separatorBuilder: separatorBuilder,
      itemCount: _qrList.length,
      itemBuilder: (_, pos) {
        return GestureDetector(
          onTap: () {
            pushNewScreen(
              context,
              screen: ResultScreen(_qrList[pos]),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.slideUp,
            );
          },
          child: Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: Align(
                alignment:
                    BlocProvider.of<LocaleCubit>(context).state.langCode ==
                            Languages.ARABIC_STR
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              print('onDismissed id : ' + _qrList[pos].id.toString());
              DatabaseProvider.db.delete(context, _qrList[pos].id!);
            },
            child: Row(
              children: [
                Container(
                  color: Colors.red,
                  height: 70,
                  width: 2,
                ),
                Expanded(
                  child: ListTile(
                    leading: ClayContainer(
                      borderRadius: 50,
                      color: Theme.of(context).canvasColor,
                      spread: BlocProvider.of<ThemeCubit>(context).state.isDark
                          ? 0
                          : 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          getIconType(_qrList[pos].type!),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    title: Text(
                      _qrList[pos].value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Theme.of(context).splashColor),
                    ),
                    subtitle: Text(
                      _qrList[pos].typeToString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Text(
                      _qrList[pos].getTime(context, langCode),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
