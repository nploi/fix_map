import 'package:cached_network_image/cached_network_image.dart';
import 'package:fix_map/blocs/shops/bloc.dart';
import 'package:fix_map/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopsSearchDelegate extends SearchDelegate<Shop> {
  // ignore: close_sinks
  final ShopsBloc bloc = ShopsBloc();

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
    bloc.add(ShopsSearchByKeywordEvent(query));

    return BlocBuilder<ShopsBloc, ShopsState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is ShopsLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShopsLoadedState) {
          var shops = bloc.shops;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Hero(
                  tag: shops[index].name,
                  child: CachedNetworkImage(
                    imageUrl: shops[index].image,
                    fit: BoxFit.contain,
                    imageBuilder: (context, provider) {
                      return CircleAvatar(
                        backgroundImage: provider,
                      );
                    },
                  ),
                ),
                title: Text(shops[index].name),
                subtitle: Text(shops[index].address, maxLines: 1, overflow: TextOverflow.ellipsis,),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
            itemCount: shops.length,
          );
        }
        return Center(child: Text("Enter keyword"),);
      },
    );
  }
}
