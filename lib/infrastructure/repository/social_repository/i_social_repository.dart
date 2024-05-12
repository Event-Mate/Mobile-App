import 'package:dartz/dartz.dart';
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/model/post_data.dart';
import 'package:kt_dart/kt.dart';

abstract class ISocialRepository {
  Future<Either<CustomFailure, KtList<PostData>>> getAll();
  Future<Either<CustomFailure, Unit>> createPost({
    required String content,
    required EventData eventData,
  });
}
