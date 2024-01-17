import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/repository/event_repository_failure.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:kt_dart/kt.dart';

abstract class IEventRepository {
  Future<Either<EventRepositoryFailure, KtList<String>>> getCategories();
  Future<Either<EventRepositoryFailure, KtList<EventData>>> getAllEvents();
}
