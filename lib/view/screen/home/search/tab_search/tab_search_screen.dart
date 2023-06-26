import 'package:capstone_project/utils/state/finite_state.dart';
import 'package:capstone_project/view/screen/forum/widget/forum_item_widget.dart';
import 'package:capstone_project/view/screen/home/search/tab_search/tab_search_view_model.dart';
import 'package:capstone_project/view/screen/home/search/tab_search/widget/tab_search_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/components/empty/empty.dart';
import '../../../../../utils/my_color.dart';
import '../../../article/article_detail/article_detail_screen.dart';
import '../../../career/career_detail/career_detail_screen.dart';
import '../../../career/career_detail/career_detail_view_model.dart';
import '../../../counselor_detail/counselor_detail_screen.dart';
import '../../../forum/forum_discussion_view_model.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({super.key});

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: Provider.of<TabSearchViewModel>(context).selectedTab,
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                onTap: (value) {
                  Provider.of<TabSearchViewModel>(context, listen: false)
                      .changeSelectedTab(value);
                },
                dividerColor: Colors.transparent,
                isScrollable: true,
                indicatorWeight: 1,
                indicatorColor: MyColor.primaryMain,
                labelColor: MyColor.primaryMain,
                labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelColor: MyColor.neutralHigh,
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(
                    text: 'Article',
                  ),
                  Tab(
                    text: 'Counseling',
                  ),
                  Tab(
                    text: 'Career',
                  ),
                  Tab(
                    text: 'Forum Discussion',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Consumer<TabSearchViewModel>(
              builder: (context, value, _) {
                if (value.state == MyState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // article
                  if (value.selectedTab == 0) {
                    if (value.articles.isEmpty) {
                      return const Empty();
                    }
                    final dataArticles = value.articles;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataArticles.length,
                      itemBuilder: (context, index) {
                        return TabSearchItem(
                          imageUrl: dataArticles[index].image!,
                          isi: [
                            Text(
                              dataArticles[index].title ?? '',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              dataArticles[index].author ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralMedium,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              dataArticles[index].formattedDate,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralMedium,
                              ),
                            ),
                          ],
                          extraWidget: dataArticles[index].saved!
                              ? Icon(
                                  Icons.bookmark,
                                  color: MyColor.primaryMain,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.bookmark_border,
                                  size: 30,
                                ),
                          onTapAction: () {
                            Navigator.pushNamed(
                              context,
                              ArticleDetailsScreen.routename,
                              arguments: dataArticles[index].id ?? 0,
                            );
                          },
                        );
                      },
                    );
                  } else if (value.selectedTab == 1) {
                    if (value.counselors.isEmpty) {
                      return const Empty();
                    }
                    final dataCounselor = value.counselors;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataCounselor.length,
                      itemBuilder: (context, index) {
                        return TabSearchItem(
                          imageUrl: dataCounselor[index].profilePicture!,
                          isi: [
                            Text(
                              dataCounselor[index].name ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              dataCounselor[index].topic ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralMedium,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RatingBar(
                              ignoreGestures: true,
                              itemSize: 20,
                              initialRating:
                                  dataCounselor[index].rating!.toDouble(),
                              direction: Axis.horizontal,
                              itemCount: 5,
                              allowHalfRating: true,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star,
                                  color: MyColor.warning,
                                ),
                                empty: Icon(
                                  Icons.star,
                                  color: MyColor.neutralLow,
                                ),
                                half: Icon(
                                  Icons.star_half,
                                  color: MyColor.warning,
                                ),
                              ),
                              onRatingUpdate: (value) {},
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              dataCounselor[index].price == 0
                                  ? 'Rp 0'
                                  : NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0,
                                    ).format(dataCounselor[index].price),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: MyColor.primaryMain,
                              ),
                            ),
                          ],
                          onTapAction: () {
                            final topicId =
                                Provider.of<ForumDiscussionViewModel>(context,
                                        listen: false)
                                    .topicData
                                    .firstWhere((element) =>
                                        element.name ==
                                        dataCounselor[index].topic)
                                    .id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CounselorDetailScreen(
                                    id: dataCounselor[index].id!,
                                    topicId: topicId!,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (value.selectedTab == 2) {
                    if (value.careers.isEmpty) {
                      return const Empty();
                    }
                    final dataCareer = value.careers;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataCareer.length,
                      itemBuilder: (context, index) {
                        return TabSearchItem(
                          imageUrl: dataCareer[index].image!,
                          isi: [
                            Text(
                              dataCareer[index].jobPosition ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              dataCareer[index].companyName ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.neutralMedium,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 15,
                                  color: MyColor.neutralHigh,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  dataCareer[index].location ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.neutralHigh,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.money, size: 15),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  dataCareer[index].salary == 0
                                      ? 'Rp 0'
                                      : NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0,
                                        ).format(dataCareer[index].salary),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: MyColor.primaryMain,
                                  ),
                                ),
                              ],
                            )
                          ],
                          onTapAction: () async {
                            await Provider.of<DetailCareerViewModel>(context,
                                    listen: false)
                                .fetchCareerById(id: dataCareer[index].id!);
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CareerDetailScreen(
                                      id: dataCareer[index].id!,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  } else if (value.selectedTab == 3) {
                    if (value.forums.isEmpty) {
                      return const Empty();
                    }
                    final dataForums = value.forums;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataForums.length,
                      itemBuilder: (context, index) {
                        return ForumItem(forumData: dataForums[index]);
                      },
                    );
                  } else {
                    return const Empty();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
