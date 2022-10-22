all:
	test -d deps || rebar3 get-deps
	rebar3 compile
	@erl -noshell -pa './_build/default/lib/bitcask/ebin' -pa './_build/default/lib/erlang_rebar_test/ebin' -s erlang_rebar_test start