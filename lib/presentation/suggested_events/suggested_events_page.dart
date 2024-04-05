import 'package:event_mate/application/event_fetcher_bloc/event_fetcher_bloc.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/event_card.dart';
import 'package:event_mate/presentation/home/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestedEventsPage extends StatelessWidget {
  const SuggestedEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary.withOpacity(.1),
      appBar: const CustomAppBar(),
      body: BlocBuilder<EventFetcherBloc, EventFetcherState>(
        buildWhen: (previous, current) =>
            previous.eventsOrEmptyList != current.eventsOrEmptyList,
        builder: (context, state) {
          final events = state.eventsOrEmptyList;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: events.size,
                  itemBuilder: (context, index) {
                    return EventCard(event: events[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
