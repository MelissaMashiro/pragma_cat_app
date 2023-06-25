import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../domain/entities/cat.dart';
import '../../ui/error_screen.dart';
import '../../ui/loading_screen.dart';
import 'bloc/cats_list/cats_list_bloc.dart';

class CatsListScreen extends StatefulWidget {
  const CatsListScreen({super.key});

  @override
  State<CatsListScreen> createState() => _CatsListScreenState();
}

class _CatsListScreenState extends State<CatsListScreen> {
  late CatsListBloc _viewModel;
  @override
  void initState() {
    _viewModel = context.read<Injector>().catsListBloc;
    super.initState();
  }

  Widget _buildBody(List<Cat> catsList) {
    Widget result = const SizedBox();
    if (catsList.isNotEmpty) {
      result = ListView.builder(
        itemCount: catsList.length,
        itemBuilder: (context, index) {
          final catito = catsList[index];
          return InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              NamedRoute.catDetails,
              arguments: {
                'catDetails': catito,
              },
            ),
            child: Container(
              margin:const EdgeInsets.symmetric(vertical: 2.0,) ,
              child: Text('CATITO => ${catito.name}')),
          );
        },
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0.0,
        title: const Text(
          'Cat Breeds App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => _viewModel
          ..add(
            const CatsListEvent.catsListStarted(),
          ),
        child: BlocBuilder<CatsListBloc, CatsListState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const LoadingScreen(),
              completed: (catsList) => _buildBody(catsList),
              error: () => ErrorScreen(
                buttonText: 'Try Again',
                onTap: () => _viewModel.add(
                  const CatsListEvent.catsListStarted(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
