import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../domain/entities/cat.dart';
import '../../ui/app_colors.dart';
import '../../ui/error_screen.dart';
import '../../ui/loading_cats_screen.dart/loading_screen.dart';
import 'bloc/cats_list/cats_list_bloc.dart';
import 'widgets/cat_card.dart';

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
      result = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(),
                    color: AppColors.searchButtonColor,
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: catsList.length,
                itemBuilder: (context, index) {
                  final catito = catsList[index];
                  return CatCard(
                    catito: catito,
                  );
                },
              ),
            ),
          ],
        ),
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
