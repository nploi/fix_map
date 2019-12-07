import 'package:cached_network_image/cached_network_image.dart';
import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopsSearchDelegate extends SearchDelegate<Shop> {
  // ignore: close_sinks
  final ShopsSearchBloc bloc = ShopsSearchBloc();
  final ScrollController scrollController = ScrollController();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: theme.primaryTextTheme.title.color)),
        primaryColor: theme.primaryColor,
        primaryIconTheme: theme.primaryIconTheme,
        primaryColorBrightness: theme.primaryColorBrightness,
        primaryTextTheme: theme.primaryTextTheme,
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title
                .copyWith(color: theme.primaryTextTheme.title.color)));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.add(ShopsSearchByQueryEvent(query));
    scrollController.addListener(() {
      if (scrollController.offset >
          scrollController.position.maxScrollExtent - 100) {
        bloc.add(ShopsSearchNextOffsetEvent(query));
      }
    });

    return BlocBuilder<ShopsSearchBloc, ShopsSearchState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is ShopsSearchLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShopsSearchLoadedState) {
          if (state.shops != null && state.shops.isNotEmpty) {
            return ListView.builder(
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
        return Center(
          child: Text("Enter keyword"),
        );
      },
    );
  }
}
