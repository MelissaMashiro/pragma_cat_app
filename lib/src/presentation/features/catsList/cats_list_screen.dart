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
  final TextEditingController _editingController = TextEditingController();

  List<Cat> allCats = [];
  ValueNotifier<List<Cat>> filteredCats = ValueNotifier<List<Cat>>([]);

  @override
  void initState() {
    _viewModel = context.read<Injector>().catsListBloc;
    super.initState();
  }

  void _filterSearchResults(String query) {
    filteredCats.value = allCats
        .where(
          (item) => item.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  Widget _buildBody() {
    Widget result = const SizedBox();
    if (filteredCats.value.isNotEmpty) {
      result = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(),
              ),
              child: TextField(
                controller: _editingController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.primaryColor,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  _filterSearchResults(query);
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ValueListenableBuilder<List<Cat>>(
                  valueListenable: filteredCats,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: filteredCats.value.length,
                      itemBuilder: (context, index) {
                        final catito = filteredCats.value[index];
                        return CatCard(
                          catito: catito,
                        );
                      },
                    );
                  }),
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
              completed: (catsList) {
                allCats = catsList;
                filteredCats.value = catsList;
                return _buildBody();
              },
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
