import 'dart:math';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final width = MediaQuery.of(context).size.width;
  final margin = 4.0;
  final list = <int>[];

  @override
  void initState() {
    super.initState();
    createList();
  }

  void createList() {
    final rand = Random();
    list.clear();
    for (int i = 0; i < 16; i++) {
      list.add(i);
    }
    do {
      for (int i = 0; i < 16; i++) {
        for (int j = 0; j < 16; j++) {
          int a = rand.nextInt(16);
          int b = rand.nextInt(16);
          int c = list[a];
          list[a] = list[b];
          list[b] = c;
        }
      }
    } while (isSolvable(list));
  }

  bool isSolvable(List<int> puzzle) {
    //Xato ishlayapti!
    int parity = 0;
    int gridWidth = sqrt(puzzle.length).toInt();
    int row = 0;
    int blankRow = 0;

    for (int i = 0; i < puzzle.length; i++) {
      if (i % gridWidth == 0) {
        row++;
      }
      if (puzzle[i] == 0) {
        blankRow = row;
        continue;
      }
      for (int j = i + 1; j < puzzle.length; j++) {
        if (puzzle[i] > puzzle[j] && puzzle[j] != 0) {
          parity++;
        }
      }
    }

    if (gridWidth % 2 == 0) {
      if (blankRow % 2 == 0) {
        return parity % 2 == 0;
      } else {
        return parity % 2 != 0;
      }
    } else {
      return parity % 2 == 0;
    }
  }

  void onItem(int index) {
    if (list[index] != 15) {
      int space = list.indexOf(15);
      if ((index - space).abs() == 1 || (index - space).abs() == 4) {
        int c = list[index];
        list[index] = list[space];
        list[space] = c;
      }
      if (isWin) {
        showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  width: 300,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Tabriklaymiz siz yutdingiz!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 6),
                      MaterialButton(
                        onPressed: () => Navigator.pop(context),
                        color: Colors.blueGrey,
                        textColor: Colors.white,
                        child: Text("Ok"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
        print("Yutdingiz!");
      }
    }
    setState(() {});
  }

  bool get isWin {
    for (int i = 0; i < list.length; i++) {
      if (i != list[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Game 15")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: createList,
      ),
      body: Center(
        child: Container(
          width: width,
          height: width,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 2,
              color: Colors.blueGrey.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Expanded(child: _Item(list[0], () => onItem(0))),
                  Expanded(child: _Item(list[1], () => onItem(1))),
                  Expanded(child: _Item(list[2], () => onItem(2))),
                  Expanded(child: _Item(list[3], () => onItem(3))),
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Expanded(child: _Item(list[4], () => onItem(4))),
                  Expanded(child: _Item(list[5], () => onItem(5))),
                  Expanded(child: _Item(list[6], () => onItem(6))),
                  Expanded(child: _Item(list[7], () => onItem(7))),
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Expanded(child: _Item(list[8], () => onItem(8))),
                  Expanded(child: _Item(list[9], () => onItem(9))),
                  Expanded(child: _Item(list[10], () => onItem(10))),
                  Expanded(child: _Item(list[11], () => onItem(11))),
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Expanded(child: _Item(list[12], () => onItem(12))),
                  Expanded(child: _Item(list[13], () => onItem(13))),
                  Expanded(child: _Item(list[14], () => onItem(14))),
                  Expanded(child: _Item(list[15], () => onItem(15))),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final int index;
  final Function()? onTap;

  const _Item(this.index, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: index != 15
              ? Colors.blueGrey.withOpacity(0.1)
              : Colors.orange.withOpacity(0.1),
          border:
              Border.all(width: 1.5, color: Colors.blueGrey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          index != 15 ? "${index + 1}" : "",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
