-- Function: json_test.get_opt_array_should_return_default_value_for_non_existing_key()

-- DROP FUNCTION json_test.get_opt_array_should_return_default_value_for_non_existing_key();

CREATE OR REPLACE FUNCTION json_test.get_opt_array_should_return_default_value_for_non_existing_key()
  RETURNS void AS
$BODY$
declare
  v_json text := '''{"key1": "value1", "key2": 2}''';
  v_json_type text;
  v_default_value text := '''[1, "2", {"key": 3}]''';
begin
  foreach v_json_type in array array ['json', 'jsonb'] loop
    execute 'select test.assert_eq(' || v_default_value || '::' || v_json_type || ', json.get_opt_array(' || v_json || '::' || v_json_type || ', ' || v_default_value || '::' || v_json_type || ', ''key''))';
  end loop;
end;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
