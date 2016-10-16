-- Function: json.get_opt_big_integer(json, bigint, text)

-- DROP FUNCTION json.get_opt_big_integer(json, bigint, text);

CREATE OR REPLACE FUNCTION json.get_opt_big_integer(
    in_json json,
    in_default bigint DEFAULT NULL::bigint,
    in_name text DEFAULT NULL::text)
  RETURNS bigint AS
$BODY$
declare
  v_param json;
  v_param_type text;
  v_retval bigint;
begin
  if in_name is not null then
    v_param := in_json->in_name;
  else
    v_param := in_json;
  end if;

  v_param_type := json_typeof(v_param);

  if v_param_type is null or v_param_type = 'null' then
    return in_default;
  end if;

  if v_param_type != 'number' then
    raise exception 'Attribute "%" is not a number', in_name;
  end if;

  begin
    v_retval := v_param;
  exception when others then
    raise exception 'Attribute "%" is not an big integer', in_name;
  end;

  return v_retval;
end;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;