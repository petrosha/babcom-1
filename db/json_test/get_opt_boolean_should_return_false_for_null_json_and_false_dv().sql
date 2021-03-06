-- Function: json_test.get_opt_boolean_should_return_false_for_null_json_and_false_dv()

-- DROP FUNCTION json_test.get_opt_boolean_should_return_false_for_null_json_and_false_dv();

CREATE OR REPLACE FUNCTION json_test.get_opt_boolean_should_return_false_for_null_json_and_false_dv()
  RETURNS void AS
$BODY$
declare
  v_json_type text;
begin
  foreach v_json_type in array array ['json', 'jsonb'] loop
    execute 'select test.assert_false(json.get_opt_boolean(null::' || v_json_type || ', false))';
    execute 'select test.assert_false(json.get_opt_boolean(null::' || v_json_type || ', false, ''key''))';
  end loop;
end;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
