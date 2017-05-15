# Grouping digits

For ease of human comprehension, we often group digits of long numbers in
natural language. An example would be formatting the price

```
123456789
```

as

```
123,456,789
```

This is pretty easy to achieve in Python by using the standard library. However,
different (natural) languages and currencies handle the groupings differently.
One example is South-East Asian countries, which would instead group the digits as:

```
12,34,56,789
```

In Unix-like systems, the `lconv` struct contains all the information for how
this grouping must be performed. It contains a member, mon_grouping, which
points to a char array:

> Each element is the number of digits in a group; elements with higher indices
> are further left. An element with value CHAR_MAX means that no further
> grouping is done. An element with value 0 means that the previous element is
> used for all groups further left.

Of course, the complexity that mon_grouping admits is _much_ greater than what
any natural languages _I_ know of admit, but it makes for an interesting
challenge to implement.

By the time mon_grouping gets to you, it has been converted into a list of
integers. Your task is to fill in the group_digits function in the next file, so
that all the tests pass.