import 'index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() => Global.init().then((e)=> runApp(MyApp()));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ChangeNotifierProvider.value(value: ThemeModel()),
          ChangeNotifierProvider.value(value: UserModel()),
          ChangeNotifierProvider.value(value: LocaleModel())
        ],
        child: Consumer2<ThemeModel,LocaleModel>(
            builder: (BuildContext context,themeModel,localeModel,Widget child){
              return MaterialApp(
                theme: ThemeData(
                  primarySwatch: themeModel.theme
                ),
                onGenerateTitle: (context){
                  return GmLocalizations.of(context).title;
                },
                home: HomeRoute(),
                locale: localeModel.getLocale(),
                supportedLocales: [
                  const Locale('en','US'),
                  const Locale('zh','CN')
                ],
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GmLocalizationsDelegate()
                ],
                localeResolutionCallback:
                    (Locale _locale, Iterable<Locale> supportedLocales) {
                  if (localeModel.getLocale() != null) {
                    //如果已经选定语言，则不跟随系统
                    return localeModel.getLocale();
                  } else {
                    //跟随系统
                    Locale locale;
                    if (supportedLocales.contains(_locale)) {
                      locale= _locale;
                    } else {
                      //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                      locale= Locale('en', 'US');
                    }
                    return locale;
                  }
                },
                routes: <String,WidgetBuilder>{
                  "login": (context) => LoginRoute(),
                  "themes": (context) => ThemeChangeRoute(),
                  "language": (context) => LanguageRoute()
                },
              );
            }),
    );
  }

}


