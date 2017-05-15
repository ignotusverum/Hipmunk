"""See the attached README file for what needs to be done.
"""


def group_digits(amount, grouping, separator):
    """Formats an amount according to the grouping strategy in groupings. Groups
    are separated with a `separator` character.

    Args:
        amount: Number - The amount to be formatted.

        grouping: List[int] - Each element is the number of digits in a group;
            elements with higher indices are further left. An element with value
            -1 means that no further grouping is done. An element with value 0
            means that the previous element is used for all groups further left.
        separator: string - The string to use as a separator.

    Returns: A string, consisting of the input amount grouped and with
        separators inserted.
    """
    raise NotImplementedError("Please supply an implementation")


def run_tests(test_cases):
    """Contains all the basic tests."""
    failures = 0
    for amount, groupings, separator, expected in test_cases:
        try:
            actual = group_digits(amount, groupings, separator)
        except Exception as e:
            print "ERR : expected %20s got %r" % (expected, e)
            failures += 1
        else:
            if expected != actual:
                print "FAIL: expected %20s got %20s" % (expected, actual)
                failures += 1
            else:
                print "OK  : correct  %20s" % actual

    assert not failures, "Unexpected failures were found."

BASIC_TESTS = [
    (0, [3, 0], ",", "0"),
    (100, [3, 0], ",", "100"),
    (1000, [3, 0], ",", "1,000"),
    (1000, [3, 3, 0], ",", "1,000"),
    (1000000, [3, 3, 0], ",", "1,000,000"),
    (1000000, [3, 0], ",", "1,000,000"),
    (1000000, [3, 0], " ", "1 000 000"),
    (1000000, [3, -1], ",", "1000,000"),
    (1000000, [3, 3, -1], ",", "1,000,000"),
    (700000000, [4, 0], " ", "7 0000 0000"),
    (4154041062, [4, 3, 0], "-", "415-404-1062"),
    (4154041062, [4, 3, -1], "-", "415-404-1062"),
    (10, [1, 1, 1, 1, -1], "! ", "1! 0"),
    (2000.3, [3, 0], " ", "2 000.3"),
    (-12842.42, [3, 0], " ", "-12 842.42"),
    (56781234, [1, 0], "", "56781234"),
    (56781234, [-1], ".", "56781234"),
    (19216801, [1, 1, 3, 0], ".", "192.168.0.1"),
]


if __name__ == "__main__":
    run_tests(BASIC_TESTS)
