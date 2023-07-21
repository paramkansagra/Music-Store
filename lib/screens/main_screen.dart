import 'package:flutter/material.dart';

import 'package:intership_app/bloc/songs_list_bloc.dart';
import 'package:intership_app/screens/song_details.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final songsListBloc = SongsListBloc();

  void initState() {
    songsListBloc.eventSink.add(SongsAction.fetchList);
  }

  void dispose() {
    songsListBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: songsListBloc.songsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Wait till we fetch your data"),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Text("Some error occured ");
            } else if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => InkWell(
                  child: ListTile(
                    title: Text(
                      snapshot.data![index].trackName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(snapshot.data![index].artistName),
                    trailing: SizedBox(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text("${snapshot.data![index].numFavourite}")
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SongDetails(song: snapshot.data![index]),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text("Some Error occured"),
              );
            }
          },
        ),
      ),
    );
  }
}
