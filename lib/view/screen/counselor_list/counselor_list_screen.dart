import 'package:flutter/material.dart';

class CounselorListScreen extends StatefulWidget {
  static const String routeName = '/counselor-list';

  const CounselorListScreen({super.key});

  @override
  State<CounselorListScreen> createState() => _CounselorListScreenState();
}

class _CounselorListScreenState extends State<CounselorListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Counselor',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Find Something here ...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text('Higest Rating'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Self Improvement',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: const [
                                  // star icon filled
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Rp. 125,000',
                                style: TextStyle(
                                    color: Color(0xFFAF1582), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Self Improvement',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: const [
                                  // star icon filled
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Rp. 125,000',
                                style: TextStyle(
                                    color: Color(0xFFAF1582), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Self Improvement',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: const [
                                  // star icon filled
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Rp. 125,000',
                                style: TextStyle(
                                    color: Color(0xFFAF1582), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Self Improvement',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: const [
                                  // star icon filled
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Rp. 125,000',
                                style: TextStyle(
                                    color: Color(0xFFAF1582), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Self Improvement',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: const [
                                  // star icon filled
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCB14),
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Rp. 125,000',
                                style: TextStyle(
                                    color: Color(0xFFAF1582), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // make a centered floating action bottom with icon and text
      floatingActionButton: Container(
        height: 50,
        width: 130,
        margin: const EdgeInsets.only(bottom: 35, right: 125, left: 125),
        decoration: const BoxDecoration(
          color: Color(0xFFAF1582),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              // 3 bar icon
              Icons.sort,
              color: Colors.white,
            ),
            Text(
              'Sort By',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
