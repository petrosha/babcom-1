-- Function: json_test.get_x_array_should_throw_for_invalid_param_type()

-- DROP FUNCTION json_test.get_x_array_should_throw_for_invalid_param_type();

CREATE OR REPLACE FUNCTION json_test.get_x_array_should_throw_for_invalid_param_type()
  RETURNS void AS
$BODY$
declare
  v_json text;
  v_json_type text;
  v_opt_part text;
  v_type text;
begin
  foreach v_json_type in array array ['json', 'jsonb'] loop
    foreach v_json in array array ['''{"key": 5}''', '''{"key": "qwe"}''', '''{"key": {}}''', '''{"key": true}'''] loop
      perform test.assert_throw(
        'select json.get_array(' || v_json || '::' || v_json_type || ', ''key'')',
        '%key% is not an array');
      perform test.assert_throw(
        'select json.get_opt_array(' || v_json || '::' || v_json_type || ', ''[]''::' || v_json_type || ', ''key'')',
        '%key% is not an array');
    end loop;
  end loop;
end;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
