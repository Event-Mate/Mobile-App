import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/model/interest_category_data.dart';
import 'package:kt_dart/kt.dart';

abstract class IEventRepository {
  Future<Either<CustomFailure, KtList<String>>> getCategories();
  Future<Either<CustomFailure, KtList<EventData>>> getAllEvents();
  Future<Either<CustomFailure, KtList<InterestCategoryData>>>
      getAllInterestCategories();
  Future<Either<CustomFailure, EventData>> attendEvent(String eventId);
}
