import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar(
      {Key? key,
      required this.textController,
      required this.onChanged,
      required this.onSearch,
      required this.onCloseSearchBar})
      : super(key: key);
  final TextEditingController textController;
  final Function(String) onChanged;
  final Function(String) onSearch;
  final VoidCallback onCloseSearchBar;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.06,
      child: TextFormField(
        controller: textController,
        onFieldSubmitted: onSearch,
        onChanged: onChanged,
        style: kCaption2.copyWith(
            color: Theme.of(context).textTheme.titleMedium!.color),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).cardColor,
          hintText: 'Procure por suas receitas aqui',
          hintStyle: kCaption2.copyWith(
              color:
                  Theme.of(context).textTheme.titleMedium!.color),
          suffixIcon: IconButton(
              onPressed: onCloseSearchBar,
              icon: const Icon(Icons.close)),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: kDetailColor,
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(60),
              )),
        ),
      ),
    );
  }
}
