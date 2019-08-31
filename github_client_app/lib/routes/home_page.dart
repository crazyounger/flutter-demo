import '../index.dart';


class HomeRoute extends StatefulWidget {

  @override
  _HomeRouteState createState() => new _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(GmLocalizations.of(context).home)
      ),
      body:_buildBody(), //构建主页面
      drawer: MyDrawer(), //侧滑抽屉菜单
    );
  }

  Widget _buildBody(){
    UserModel userModel = Provider.of<UserModel>(context);
    if(!userModel.isLogin){
      return Center(
        child: RaisedButton(
          child: Text(GmLocalizations.of(context).login),
          onPressed: ()=> Navigator.of(context).pushNamed('login'),
        ),
      );
    }else{
      return InfiniteListView<Repo>(
          onRetrieveData:(int page,List<Repo> items,bool refresh) async{
            var data = await Git(context).getRepos(
              refresh: refresh,
              queryParameters: {
                'page':page,
                'page_size':20
              }
            );
            items.addAll(data);
            return data.length> 0 && data.length % 20 == 0;
          },
          itemBuilder: (List list,int index,BuildContext ctx){
            return RepoItem(list[index]);
          },
      );
    }
  }
}

class MyDrawer extends StatelessWidget {

  const MyDrawer({
    Key key,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              Expanded(child: _buildMenus()),
            ],
          ) ),
    );
  }

  Widget _buildHeader(){
    return Consumer<UserModel>(
      builder: (BuildContext context,UserModel userModel,Widget child){
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40,bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    child: userModel.isLogin
                        ? gmAvatar(userModel.user.avatar_url, width: 80)
                      : Image.asset("imgs/avatar-default.png",width:80),
                  ),
                ),
                Text(
                  userModel.isLogin
                      ? userModel.user.login
                      : GmLocalizations.of(context).login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:Colors.white
                  ),
                )
              ],
            ),

          ),
            onTap:(){
              if(!userModel.isLogin) Navigator.of(context).pushNamed('login');
            }
        );
      },
    );
  }

  Widget _buildMenus(){
    return Consumer<UserModel>(
      builder: (BuildContext context,UserModel value,Widget child){
        var gm = GmLocalizations.of(context);
        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(gm.theme),
              onTap: ()=> Navigator.of(context).pushNamed('themes'),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.language),
              onTap: ()=> Navigator.of(context).pushNamed('language'),
            ),
            if(value.isLogin) ListTile(
              leading: const Icon(Icons.power_settings_new),
              title:Text(gm.logout),
              onTap: (){
                showDialog(
                context: context,
                builder: (ctx){
                  return AlertDialog(
                    content:Text(gm.logoutTip),
                    actions: <Widget>[
                      FlatButton(
                        child:Text(gm.cancel),
                        onPressed: ()=> Navigator.pop(context),
                      ),
                      FlatButton(
                        child: Text(gm.yes),
                        onPressed:  (){
                          value.user = null;
                          Navigator.pop(context);
                        }
                      )
                    ],
                  );
        }
                );
              },
            )
          ],
        );
      },
    );
  }

}