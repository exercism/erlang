A goal of this exercise is teaching you about efficiency. There are many ways
to create a solution that produces correct results, but some solutions are more
efficient and thereby finish faster than others.

On the `Erlang` track, some of your tests may even time out if your solution is
not efficient enough.

Here are some general points to consider when it comes to optimize your algorithms:
* Some operations are cheap, others are expensive. Try to figure out which are which,
then try to find a way to perform expensive operations rarely, by executing them
only if needed, eg when a cheap operation alone is not enough.
* Skip out early. Often it is clear that, beyond a certain point, no better solution
can be found, so it makes no sense to search further.
* More generally, reduce the overall steps or iterations your algorithm has to perform.
* When generating results, it may be better to allow duplicates and weed them out
before returning the final result, instead of ensuring that duplicates never get
created in the first place along the way.

Those are only some general rules of thumb, things you might want to keep an eye out
for. They are not universally applicable to any problem, and often they come with
trade-offs.
