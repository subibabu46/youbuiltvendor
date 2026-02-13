import 'package:design_task_1/constants/asset_names.dart';
import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class StoreProductsScreen extends StatefulWidget {
  const StoreProductsScreen({super.key});

  @override
  State<StoreProductsScreen> createState() => _StoreProductsScreenState();
}

class _StoreProductsScreenState extends State<StoreProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWIdget(),
            Divider(color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  _CountInfoWidget(),
                  SizedBox(height: 20),
                  SearchContainer(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [DropDownWidget(), IconTextButton()],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                itemCount: 3,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, index) => ItemTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarWIdget extends StatelessWidget {
  const AppBarWIdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: kTextTabBarHeight,

        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Image.asset(
                AssetNames.back,
                color: AppColors.textSecondary,
                width: 26,
                height: 26,
              ),
            ),

            Align(
              alignment: AlignmentGeometry.center,
              child: Text(
                'Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textTitlePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderDefault),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(AssetNames.cement, width: 60, height: 60),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ultratech Premium Cement',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.textTitlePrimary,
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
                Text(
                  'Brand • Category ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹1000',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.textTitleSecondary,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundPlaceholder,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Active',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  const IconTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.buttonPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.add, size: 24, color: AppColors.textButton),
          SizedBox(width: 5),
          Text(
            'Add Item',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.textButton,
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderDefault),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            AssetNames.arrowDown,
            width: 20,
            height: 20,
            color: AppColors.textSecondary,
          ),
        ),
        underline: SizedBox(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.textTitleSecondary,
        ),
        value: 'All',
        items: ['All'].map((item) {
          return DropdownMenuItem(value: 'All', child: Text('All'));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
      ),
    );
  }
}

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Row(
        children: [
          Image.asset(AssetNames.search, width: 20, height: 20),
          SizedBox(width: 20),
          Text(
            'Search project',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.textIcon,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountInfoWidget extends StatelessWidget {
  const _CountInfoWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: CountInfo(title: 'Total Products', count: 10)),
        SizedBox(width: 10),
        Expanded(child: CountInfo(title: 'Active Products', count: 2)),
        SizedBox(width: 10),
        Expanded(child: CountInfo(title: 'Categories', count: 2)),
      ],
    );
  }
}

class CountInfo extends StatelessWidget {
  final String title;
  final int count;
  const CountInfo({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 110, minHeight: 58),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundPlaceholder,
        border: Border.all(color: AppColors.borderDefault),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            '$count',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.textTitleSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
