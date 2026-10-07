/*SizedBox(
                                  height: 200.h,
                                  child: GridView.builder(
                                      itemCount: item.imagesLinks.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.all(5.r),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: item.imagesLinks[index],
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                Container(
                                                    height: 90.h,
                                                    width: 90.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(ImageViewer(
                                                            imageProvider:
                                                                imageProvider));
                                                      },
                                                    )),
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 90.h,
                                              width: 90.h,
                                              margin: const EdgeInsets.all(10),
                                              child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: Colors.blue,
                                                strokeWidth: 1,
                                              )),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        );
                                      }),
                                )
                              : Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: SizedBox(
                                      height: 200.h,
                                      width: double.infinity,
                                      child: VideoStory(
                                        videoUrl: item.videoLink,
                                      )),
                                )*/