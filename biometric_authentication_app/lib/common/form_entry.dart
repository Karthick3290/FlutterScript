
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loginapp/common/failure.dart';

abstract class Validator {
  Validator.create();
  Failure validate();
}
class FormEntry<T, V extends Validator> extends Equatable {
  final T _data;
  final V _validator;

  FormEntry(this._data,[this._validator]);

  Either<Failure,T> get value {
    Failure f = _validator.validate();
    if (f != null) {
      return left(f);
    }
    return right(_data);
  }

  @override
  // TODO: implement props
  List<Object> get props => [_data, _validator];
}