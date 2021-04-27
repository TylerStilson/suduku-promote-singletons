Promote pencil singletons
-------------------------

In this step you will solve squares whose pencil marks indicate that
only one value is possible in the square, something we will call a
pencil mark singleton. For example, if a group looks like:

    +-----------------------+
    | . . . |       | . . . |
    | . 5 .     6     . . . |
    | 7 . . |       | 7 . . |
    | - - - + - - - + - - - |
    | 1 2 . | . . . | 1 . . |
    | . 5 .   . 5 .   . . . |
    | 7 8 9 | 7 8 9 | 7 8 9 |
    | - - - + - - - + - - - |
    | 1 2 3 | . . 3 |       |
    | . . .   . . .     4   |
    | 7 . 9 | 7 . 9 |       |
    +-----------------------+

Then you will solve the square where the pencil marks show that 7 is
the only possible solution:

    +-----------------------+
    | . . . |       |       |
    | . 5 .     6       7   |
    | 7 . . |       |       |
    | - - - + - - - + - - - |
    | 1 2 . | . . . | 1 . . |
    | . 5 .   . 5 .   . . . |
    | 7 8 9 | 7 8 9 | 7 8 9 |
    | - - - + - - - + - - - |
    | 1 2 3 | . . 3 |       |
    | . . .   . . .     4   |
    | 7 . 9 | 7 . 9 |       |
    +-----------------------+

You will not be considering rows, columns, or groups in this step,
you will just consider each pencil-mark square on the entire board
in turn.

Note that in this case the pencil marks need to be updated because
of the newly-solved square:

    +-----------------------+
    | . . . |       |       |
    | . 5 .     6       7   |
    | . . . |       |       |
    | - - - + - - - + - - - |
    | 1 2 . | . . . | 1 . . |
    | . 5 .   . 5 .   . . . |
    | . 8 9 | . 8 9 | . 8 9 |
    | - - - + - - - + - - - |
    | 1 2 3 | . . 3 |       |
    | . . .   . . .     4   |
    | . . 9 | . . 9 |       |
    +-----------------------+

This, in turn, exposes another pencil mark singleton in the top-left
corner. Solving it and re-computing the pencil marks yields:


    +-----------------------+
    |       |       |       |
    |   5       6       7   |
    |       |       |       |
    | - - - + - - - + - - - |
    | 1 2 . | . . . | 1 . . |
    | . . .   . . .   . . . |
    | . 8 9 | . 8 9 | . 8 9 |
    | - - - + - - - + - - - |
    | 1 2 3 | . . 3 |       |
    | . . .   . . .     4   |
    | . . 9 | . . 9 |       |
    +-----------------------+

At a high level, the function `promote_pencil_singletons` does the
following:

    promote_pencil_singletons(*board, *table):
        loop over all 81 positions of the board:
            if the position is a pencil mark:
                count the "possible" marks
                if there was exactly one, solve the position
        if there were any changes made:
            call calc_pencil(board, table)
            repeat the entire process
        return 1 if any changes were made, 0 otherwise

To count the possible marks in a square, you can do something like:

    count = 0
    n = 0
    for i from 1 to 9:
        if (elt & (1<<i)) != 0:
            count += 1
            n = i
    if count == 1:
        set board position to n

In this example, we count the number of possible values by trying
each one out. We also use `n` to record the most recent value we
discovered. If there was only one possible value, then `n` will
capture it.

You will also need to think about the remaining structure of the
function. Make sure you have considered all of the following:

*   You can assume `calc_pencil` was called before
    `promote_pencil_singletons`

*   If you make no changes, you should return 0. In this case the
    board should be exactly as it was when you were called. You
    should not call `calc_pencil` in this case.

*   If you make any changes, then after processing the entire board
    you should call `calc_pencil` to re-compute the pencil marks and
    then check if that opened up any new singletons. When you
    eventually return, the pencil marks should all be up-to-date as
    a result.

*   You may end up repeating this cycle many times (promote
    singletons, re-calculate pencil marks, find more singletons,
    etc.). You should return 1 at the end if you made any changes,
    regardless of how many times the cycle repeated. This can be
    implemented with another loop at the top level.

You can test your code using:

    make test

to run the unit tests as usual. You can also use:

    make run

and then type in a sample board. In this case `main` will read the
board, calculate pencil marks, call your code, and print the board
at various stages.

    make debug

This will enter the debugger using the same code path as "make run".
