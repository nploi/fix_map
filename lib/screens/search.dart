import "package:cached_network_image/cached_network_image.dart";
import "package:fix_map/blocs/blocs.dart";
import "package:fix_map/generated/i18n.dart";
import "package:fix_map/screens/screens.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SearchScreen extends StatefulWidget {
  static String routeName = "search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ShopsSearchBloc bloc;
  final ScrollController scrollController = ScrollController();
  final TextEditingController _editingController = TextEditingController();
  String query = "";
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    bloc = ShopsSearchBloc();
    scrollController.addListener(() {
      if (scrollController.offset >
          scrollController.position.maxScrollExtent - 100) {
        bloc.add(ShopsSearchNextOffsetEvent(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsSearchBloc, ShopsSearchState>(
      bloc: bloc,
      builder: (BuildContext context, ShopsSearchState state) {

        Widget body = Center(
          child: Text(S.of(context).enterKeywordTitle),
        );

        if (state is ShopsSearchLoadingState) {
          body = Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShopsSearchLoadedState) {
          if (isEmpty != state.query.isEmpty) {
            isEmpty = state.query.isEmpty;
          }
          if (state.shops != null && state.shops.isNotEmpty) {
            body = ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: state.shops[index].image,
                        fit: BoxFit.contain,
                        imageBuilder: (context, provider) {
                          return CircleAvatar(
                            backgroundImage: provider,
                          );
                        },
                      ),
                      title: Text(state.shops[index].name),
                      subtitle: Text(
                        state.shops[index].address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, ShopDetailScreen.routeName,
                            arguments: state.shops[index]);
                      },
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                );
              },
              itemCount: state.shops.length,
            );
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _editingController,
              autofocus: true,
              onChanged: (value) {
                query = value;
                bloc.add(ShopsSearchByQueryEvent(query));
              },
              decoration: InputDecoration(
                hintText: S.of(context).searchHintText
              ),
            ),
            actions: _buildActions(isEmpty),
          ),
          body: body,
        );
      },
    );
  }

  List<Widget> _buildActions(bool isEmpty) {
    return <Widget>[
      isEmpty
          ? SizedBox(
              height: 48,
              width: 48,
            )
          : IconButton(
              tooltip: "Clear",
              icon: const Icon(Icons.clear),
              onPressed: () {
                _editingController.clear();
                bloc.add(ShopsSearchNextOffsetEvent(""));
              },
            ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
