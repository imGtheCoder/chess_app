import 'package:flutter/material.dart';

class ChessBoardBuilder extends StatelessWidget {
  const ChessBoardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8),
                      itemBuilder: (ctx, i) {
                        if (i < 8) {
                          if (i % 2 == 0) {
                            return Container(
                              color: const Color.fromRGBO(233, 237, 204, 1),
                            );
                          } else {
                            return Container(
                              color: const Color.fromRGBO(119, 153, 84, 1),
                            );
                          }
                        } else if (i < 16) {
                          if (i % 2 == 0) {
                            return Container(
                              color: const Color.fromRGBO(119, 153, 84, 1),
                            );
                          } else {
                            return Container(
                              color: const Color.fromRGBO(233, 237, 204, 1),
                            );
                          }
                        } else if (i < 24) {
                          if (i % 2 == 0) {
                            return Container(
                              color: const Color.fromRGBO(233, 237, 204, 1),
                            );
                          } else {
                            return Container(
                              color:const Color.fromRGBO(119, 153, 84, 1),
                            );
                          }
                        } else if (i < 32) {
                          if (i % 2 == 0) {
                            return Container(
                              color: const Color.fromRGBO(119, 153, 84, 1),
                            );
                          } else {
                            return Container(
                              color: const Color.fromRGBO(233, 237, 204, 1),
                            );
                          }
                        } else if (i < 40) {
                          if (i % 2 == 0) {
                            return Container(
                              color: const Color.fromRGBO(233, 237, 204, 1),
                            );
                          } else {
                            return Container(
                              color: const Color.fromRGBO(119, 153, 84, 1),
                            );
                          }
                        } else if (i < 48) {
                          if (i % 2 == 0) {
                            return Container(
                              color: const Color.fromRGBO(119, 153, 84, 1),
                            );
                          } else {
                            return Container(
                              color: const Color.fromRGBO(233, 237, 204, 1),
                            );
                          }
                        } else if (i < 56) {
                          if (i % 2 == 0) {
                            return Container(
                              color: const Color.fromRGBO(233, 237, 204, 1),
                            );
                          } else {
                            return Container(
                              color: const Color.fromRGBO(119, 153, 84, 1),
                            );
                          }
                        } else {
                          if (i % 2 == 0) {
                            return Container(
                              color: const Color.fromRGBO(119, 153, 84, 1),
                            );
                          } else {
                            return Container(
                              color: const Color.fromRGBO(233, 237, 204, 1),
                            );
                          }
                        }
                      },
                      itemCount: 64,
                    );
  }
}