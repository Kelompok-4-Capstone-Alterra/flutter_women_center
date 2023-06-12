import 'package:capstone_project/utils/components/appbar/custom_appbar.dart';
import 'package:capstone_project/utils/components/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:capstone_project/utils/components/buttons/primary_button.dart';
import 'package:capstone_project/utils/components/text_box/search_text_box.dart';
import 'package:capstone_project/utils/my_size.dart';
import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/article/article_list/article_list_screen.dart';
import 'package:capstone_project/view/screen/counseling_topic/counseling_topic_screen.dart';
import 'package:capstone_project/view/screen/forum/join_forum_discussion_screen.dart';
import 'package:capstone_project/view/screen/home/home_view_model.dart';
import 'package:capstone_project/view/screen/home/search/search_screen.dart';
import 'package:capstone_project/view/screen/home/widget/home_list.dart';
import 'package:capstone_project/view/screen/home/widget/home_list_item.dart';
import 'package:capstone_project/view/screen/home/widget/home_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/my_color.dart';
import '../career/career_list/career_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchHomeController = TextEditingController();
  late final HomeViewModel homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.initUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size(MySize.bodyWidth(context), double.maxFinite),
        home: true,
        searchField: true,
        tabBar: false,
        judul: 'Home',
        searchTextBox: SearchTextBox(
          textEditingController: _searchHomeController,
          onTap: () {
            Navigator.pushNamed(context, SearchScreen.routeName);
          },
          readOnly: true,
        ),
        homeText: Consumer<HomeViewModel>(
          builder: (context, value, _) {
            if (value.state == MyState.loading) {
              return Padding(
                padding: const EdgeInsets.only(left: MySize.screenPadding),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: MyColor.primaryMain,
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: MySize.screenPadding),
                child: Text(
                  'Hi, ${value.username}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyColor.secondaryMain,
                  ),
                ),
              );
            }
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: MySize.screenPadding),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              HomeMenu(
                icon: Icons.article,
                direction: ArticleListScreen.routename,
                title: 'Articles',
              ),
              HomeMenu(
                icon: Icons.supervisor_account,
                direction: CounselingTopicScreen.routeName,
                title: 'Counseling',
              ),
              HomeMenu(
                icon: Icons.home_repair_service,
                direction: CareerListScreen.routeName,
                title: 'Career',
              ),
              HomeMenu(
                icon: Icons.forum,
                direction: JoinForumDiscussionScreen.routeName,
                title: 'Forum',
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            decoration: BoxDecoration(
              gradient: MyColor.background,
              borderRadius: BorderRadius.circular(3),
            ),
            height: 100,
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Voucher',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: MyColor.neutralMediumHigh,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Find out now if there’s any voucher just for you!',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              color: MyColor.neutralMediumLow,
                            ),
                          ),
                        ],
                      ),
                      PrimaryButton(
                        teks: 'Check Now',
                        onPressed: () {},
                        customWidth: 110,
                        customBackgroundColor: MyColor.secondaryMain,
                        customTextColor: MyColor.white,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 15,
                        decoration: BoxDecoration(
                          color: MyColor.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 15,
                        decoration: BoxDecoration(
                          color: MyColor.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // article
          HomeList(
            title: 'Newest Articles',
            subtitle: 'These are our best new articles of the week!',
            direction: ArticleListScreen.routename,
            listItem: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const HomeListItem(
                  title:
                      'How art can improve your mental health wajdawjndjansjdbwhbahs dhw ah dhabwhd ',
                  subtitle: 'Mental Health',
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Example_image.svg/600px-Example_image.svg.png',
                  direction: '',
                );
              },
            ),
          ),
          // counselor
          HomeList(
            title: 'Our Best Counselors',
            subtitle: "The best counselors based on user's rate and review",
            direction: CounselingTopicScreen.routeName,
            listItem: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return HomeListItem(
                  title: 'John Doe',
                  subtitle: 'Self Development',
                  imageUrl:
                      'https://img.freepik.com/free-photo/man-wearing-t-shirt-gesturing_23-2149393645.jpg',
                  direction: '',
                  extraWidget: RatingBar(
                    itemSize: 20,
                    initialRating: 2.5,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    allowHalfRating: true,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: MyColor.warning,
                      ),
                      empty: Icon(
                        Icons.star_border,
                        color: MyColor.neutralLow,
                      ),
                      half: Icon(
                        Icons.star_half,
                        color: MyColor.warning,
                      ),
                    ),
                    onRatingUpdate: (value) {},
                  ),
                );
              },
            ),
          ),
          // career
          HomeList(
            title: 'Newest Career Information',
            subtitle: 'We have the newest career information for you!',
            direction: '',
            listItem: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return HomeListItem(
                  title: 'Human Resource',
                  subtitle: 'PT Melodi Karya',
                  imageUrl:
                      'https://assets.kpmg.com/content/dam/kpmg/xx/images/2020/10/illustration-standing-man-touching-computer-screen.jpg/jcr:content/renditions/original',
                  direction: '',
                  extraWidget: Text(
                    '${NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(10000000)} ++',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: MyColor.primaryMain,
                    ),
                  ),
                );
              },
            ),
          ),
          // forum
          HomeList(
            title: 'Newest Forum',
            subtitle: "Let's join to the newest forum discussion!",
            direction: JoinForumDiscussionScreen.routeName,
            listItem: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const HomeListItem(
                  title: 'Discrimination for being a women',
                  subtitle: 'Discrimination',
                  imageUrl:
                      'https://dl.kaskus.id/jawaban-online.s3.amazonaws.com/media/ckeditor/uploads/2020/10/09/forum.jpg?AWSAccessKeyId=AKIAR42PIJU47XZXHDHE&Signature=zzh8RE5FOMlP6BlBNTd1vbjZ7ZI%3D&Expires=2102251972',
                  direction: '',
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
