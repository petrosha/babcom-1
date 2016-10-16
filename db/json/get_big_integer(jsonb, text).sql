-- Function: json.get_big_integer(jsonb, text)

-- DROP FUNCTION json.get_big_integer(jsonb, text);

CREATE OR REPLACE FUNCTION json.get_big_integer(
    in_json jsonb,
    in_name text DEFAULT NULL::text)
  RETURNS bigint AS
$BODY$
declare
  v_param jsonb;
  v_param_type text;
  v_retval bigint;
begin
  if in_name is not null then
    v_param := in_json->in_name;
  else
    v_param := in_json;
  end if;

  v_param_type := jsonb_typeof(v_param);

  if v_param_type is null then
    raise exception 'Attribute "%" was not found', in_name;
  end if;
  if v_param_type != 'number' then
    raise exception 'Attribute "%" is not a number', in_name;
  end if;

  begin
    v_retval := v_param;
  exception when others then
    raise exception 'Attribute "%" is not an integer', in_name;
  end;

  return v_retval;
end;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;