import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    
    controller.addListener(scrollListener);
  }

  void scrollListener() {
   if(controller.offset > controller.position.maxScrollExtent - 300) {
     ref.read(restaurantProvide.notifier).paginate(
       fetchMore: true,
     );
   }
  }

  @override
  Widget build(BuildContext) {
    final data = ref.watch(restaurantProvide);

    if(data is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    final cp = data as CursorPagination;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if(index == cp.data.length) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is CursorPaginationFetchingMore ?
                  CircularProgressIndicator() : Text('마지막 테이터 입니다.'),
              ),
            );
          }

          final pItem = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(id: pItem.id),
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: pItem,
            ),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: 16.0);
        },
      ),
    );
  }
}
