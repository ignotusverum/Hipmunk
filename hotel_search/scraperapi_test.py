from collections import Counter
import requests


EXPECTED_COUNTS = {
    "Expedia": 4,
    "Orbitz": 5,
    "Priceline": 10,
    "Travelocity": 7,
    "Hilton": 19,
}


def test_hotel_search():
    resp = requests.get("http://localhost:8000/hotels/search")
    results = resp.json()["results"]

    provider_counts = Counter()
    for result in results:
        provider_counts[result["provider"]] += 1

    for provider, count in provider_counts.most_common():
        expected = EXPECTED_COUNTS[provider]
        assert count == expected, "%s results missing for %s, expected %s, count %s" % (
            expected - count,
            provider,
            expected, count
        )

    sorted_results = sorted(results, key=lambda r: r["ecstasy"], reverse=True)
    assert results == sorted_results, "Results aren't sorted properly!"

    took = resp.elapsed.total_seconds()

    msg = "Took %.2f seconds." % took
    if took > 3:
        msg += " Kinda slow..."
    else:
        msg += " Looks good!"

    print msg


if __name__ == "__main__":
    test_hotel_search()
