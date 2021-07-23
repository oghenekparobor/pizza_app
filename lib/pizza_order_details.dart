import 'package:flutter/material.dart';
import 'package:pizza_app/ingredient.dart';

const _pizzaCartSize = 55.0;

class PizzaOrderDetails extends StatelessWidget {
  const PizzaOrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pizza',
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.brown,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            left: 10,
            right: 10,
            top: 10,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _PizzaDetails(),
                    ),
                    Expanded(
                      flex: 2,
                      child: _PizzaIngredient(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
            child: _PizzaCartButton(onTap: () {
              print('cart');
            }),
          )
        ],
      ),
    );
  }
}

class _PizzaCartButton extends StatefulWidget {
  const _PizzaCartButton({required this.onTap});
  final VoidCallback onTap;
  @override
  __PizzaCartButtonState createState() => __PizzaCartButtonState();
}

class __PizzaCartButtonState extends State<_PizzaCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      duration: Duration(milliseconds: 150),
      reverseDuration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _animateButton() async {
    await _animationController.forward(from: 0.0);
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _animateButton();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform.scale(
          scale: (2 - _animationController.value),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange.withOpacity(.5),
                    Colors.orange,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 4.0),
                      spreadRadius: 4.0)
                ]),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}

class _PizzaIngredient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ingredient.length,
      itemBuilder: (context, index) {
        return _PizzaIngredientItem(ingredient: ingredient[index]);
      },
    );
  }
}

class _PizzaIngredientItem extends StatelessWidget {
  const _PizzaIngredientItem({required this.ingredient});
  final Ingredient ingredient;
  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Color(0xFFF5EED3),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            ingredient.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    return Center(
      child: Draggable(
        feedback: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.black26,
                offset: Offset(0.0, 5.0),
                spreadRadius: 5.0,
              )
            ],
          ),
          child: child,
        ),
        data: ingredient,
        child: child,
      ),
    );
  }
}

class _PizzaDetails extends StatefulWidget {
  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with SingleTickerProviderStateMixin {
  final _listIngredient = <Ingredient>[];
  late AnimationController _animationController;
  int _total = 15;
  final _notifierFocused = ValueNotifier(false);
  List<Animation> _animationList = <Animation>[];
  late BoxConstraints _pizzaConstraint;

  Widget _buildIngredientWidget() {
    List<Widget> elements = [];
    if (_animationList.isNotEmpty) {
      for (var i = 0; i < _listIngredient.length; i++) {
        Ingredient ingredient = _listIngredient[i];
        final ingredientWidget = Image.asset(ingredient.image, height: 40);
        for (var j = 0; j < ingredient.positions.length; j++) {
          final animation = _animationList[j];
          final position = ingredient.positions[j];
          final postionX = position.dx;
          final postionY = position.dy;

          if (i == _listIngredient.length - 1) {
            double fromX = 0.0, fromY = 0.0;
            if (j < 1) {
              fromX = _pizzaConstraint.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = _pizzaConstraint.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = _pizzaConstraint.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaConstraint.maxHeight * (1 - animation.value);
            }

            final opacity = animation.value;

            if (animation.value > 0) {
              elements.add(
                Opacity(
                  opacity: opacity,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(
                        fromX + _pizzaConstraint.maxWidth * postionX,
                        fromY + _pizzaConstraint.maxHeight * postionY,
                      ),
                    child: ingredientWidget,
                  ),
                ),
              );
            }
          } else {
            elements.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                    _pizzaConstraint.maxWidth * postionX,
                    _pizzaConstraint.maxHeight * postionY,
                  ),
                child: ingredientWidget,
              ),
            );
          }
        }
      }
      return Stack(children: elements);
    }
    return SizedBox.fromSize();
  }

  void _buildIngredientAnimation() {
    _animationList.clear();
    _animationList.add(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.8, curve: Curves.decelerate),
    ));
    _animationList.add(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.2, 0.8, curve: Curves.decelerate),
    ));
    _animationList.add(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.4, 1.0, curve: Curves.decelerate),
    ));
    _animationList.add(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.1, 0.7, curve: Curves.decelerate),
    ));
    _animationList.add(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.3, 1.0, curve: Curves.decelerate),
    ));
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: DragTarget<Ingredient>(
                onAccept: (data) {
                  print('accept');
                  _notifierFocused.value = false;
                  setState(() {
                    _listIngredient.add(data);
                    _total++;
                  });
                  _buildIngredientAnimation();
                  _animationController.forward(from: 0.0);
                },
                onWillAccept: (data) {
                  print('onWillAccept');

                  _notifierFocused.value = true;

                  for (Ingredient i in _listIngredient) {
                    if (i.compare(data!)) {
                      return false;
                    }
                  }
                  return true;
                },
                onLeave: (data) {
                  print('onLeave');
                  _notifierFocused.value = false;
                },
                builder: (context, candidateData, rejectedData) =>
                    LayoutBuilder(
                  builder: (context, constraints) {
                    _pizzaConstraint = constraints;
                    return Center(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _notifierFocused,
                        builder: (context, focused, child) => AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          height: focused
                              ? constraints.maxHeight
                              : constraints.maxHeight - 10,
                          child: Stack(
                            children: [
                              Image.asset('assets/images/dish.png'),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset('assets/images/pizza-1.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: Offset(0.0, 0.0),
                        end: Offset(0.0, animation.value),
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              child: Text(
                '\$$_total',
                key: UniqueKey(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            )
          ],
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) => _buildIngredientWidget(),
        ),
      ],
    );
  }
}
