abstract class AbstractUseCase<REQ, RES> {
  const AbstractUseCase();

  Future<RES> execute(REQ params);
}