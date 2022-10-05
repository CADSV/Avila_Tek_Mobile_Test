// Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:avila_tek_test/infraestructure/ui/components/base_ui_component.dart';
import 'package:avila_tek_test/infraestructure/ui/styles/colors.dart';


///LoadingComponent: A progress indicator widget.
class LoadingComponent extends StatelessWidget {

  const LoadingComponent({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseUIComponent(
      body: const Center(
          child: CircularProgressIndicator(
            value: null,
            strokeWidth: 4.0,
            color: colorPrimary,
          ),
      ),
    );
  }
}
