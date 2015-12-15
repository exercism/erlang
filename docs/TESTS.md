```bash
$ erlc bob*.erl
$ erl -noshell -eval "eunit:test(bob, [verbose])" -s init stop
```

