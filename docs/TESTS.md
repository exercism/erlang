```bash
$ erlc bob*.erl
$ erl -noshell -eval "eunit:test(bob_test, [verbose])" -s init stop
```

