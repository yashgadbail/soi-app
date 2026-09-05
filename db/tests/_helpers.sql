-- Test helpers, created inside the rolled-back test transaction only.
-- soi_test_user(email) inserts a throwaway auth user (firing the signup
-- triggers) and returns its id. soi_as(user_id) switches the session to the
-- authenticated role with that user's JWT claims; soi_as(null) becomes anon;
-- soi_reset() returns to the superuser.

create or replace function pg_temp.soi_test_user(p_email text, p_name text default null)
returns uuid language plpgsql as $$
declare v uuid := gen_random_uuid();
begin
  insert into auth.users (id, instance_id, aud, role, email, encrypted_password,
                          email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
                          created_at, updated_at)
  values (v, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated',
          p_email, 'x', now(), '{"provider":"email","providers":["email"]}'::jsonb,
          case when p_name is null then '{}'::jsonb else json_build_object('full_name', p_name)::jsonb end,
          now(), now());
  return v;
end $$;

create or replace function pg_temp.soi_as(p_user uuid)
returns void language plpgsql as $$
begin
  if p_user is null then
    perform set_config('request.jwt.claims', '{"role":"anon"}', true);
    set local role anon;
  else
    perform set_config('request.jwt.claims',
      json_build_object('sub', p_user, 'role', 'authenticated')::text, true);
    set local role authenticated;
  end if;
end $$;

create or replace function pg_temp.soi_reset()
returns void language plpgsql as $$
begin
  reset role;
  perform set_config('request.jwt.claims', '', true);
end $$;

-- Expect that running p_sql raises an exception whose message contains p_key.
create or replace function pg_temp.soi_expect_error(p_sql text, p_key text)
returns void language plpgsql as $$
begin
  begin
    execute p_sql;
  exception when others then
    if position(p_key in sqlerrm) = 0 then
      raise exception 'expected error %, got: %', p_key, sqlerrm;
    end if;
    return;
  end;
  raise exception 'expected error % but statement succeeded: %', p_key, p_sql;
end $$;

do $$ begin
  if auth.uid() is not null then raise exception 'helper sanity: expected no user'; end if;
end $$;
