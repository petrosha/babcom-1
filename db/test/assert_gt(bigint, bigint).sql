-- Function: test.assert_gt(bigint, bigint)

-- DROP FUNCTION test.assert_gt(bigint, bigint);

CREATE OR REPLACE FUNCTION test.assert_gt(
    in_expected bigint,
    in_actual bigint)
  RETURNS void AS
$BODY$
-- Проверяет, что ожидаемое значение больше реального
begin
  if in_expected is null or in_actual is null or in_expected <= in_actual then
    raise exception 'Assert_gt failed. Expected: %. Actual: %.', in_expected, in_actual;
  end if;
end;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
