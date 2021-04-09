import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../bloc/qr_bloc.dart';
import '../../db/database_provider.dart';
import '../../models/QR.dart';
import '../../components/CustomAppBar.dart';
import '../../cubit/history_cubit.dart';
import '../ResultScreen/ResultScreen.dart';

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
          centerTitle: true,
          shape: CustomAppBar(),
          title: Text(
            'History',
          ),
        ),
        body:
            BlocBuilder<HistoryCubit, HistoryState>(builder: (context, state) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClayContainer(
                  color: Theme.of(context).canvasColor,
                  borderRadius: 50,
                  spread: 10,
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
                              color: Theme.of(context).accentColor.withOpacity(
                                  state is HistoryScanned ? 1 : 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 20),
                              child: Text(
                                'Scanned',
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
                              color: Theme.of(context).accentColor.withOpacity(
                                  state is HistoryScanned ? 0.5 : 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 20),
                              child: Text(
                                'Created',
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
                    return _getHistoryList(state, Qrs);
                  },
                  listener: (_, __) {},
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  ListView _getHistoryList(HistoryState state, List<QR> Qrs) {
    if (state is HistoryScanned) {
      List<QR> _qrList = Qrs.where((qr) => qr.isScanned).toList();
      return ListView.builder(
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
            child: ListTile(
              leading: ClayContainer(
                borderRadius: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.link,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              title: Text(_qrList[pos].value),
              subtitle: Text(_qrList[pos].typeToString()),
            ),
          );
        },
      );
    } else {
      List<QR> _qrList = Qrs.where((qr) => !qr.isScanned).toList();
      return ListView.builder(
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
            child: ListTile(
              leading: ClayContainer(
                borderRadius: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.link,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              title: Text(_qrList[pos].value),
              subtitle: Text(_qrList[pos].typeToString()),
            ),
          );
        },
      );
    }
  }
}
