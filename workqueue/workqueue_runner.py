"""Distributed work queue test harness."""

# Enqueues work items in Redis, waits N seconds, and then tries to validate
# the result.

# The work items are json blobs of the form:
# {
#     'job_id': <JOB_ID>
#     'attempt_nr': <ATTEMPT_NR>
#     'value': <VALUE>
# }

# The expected result is the sum of all the values, grouped by job_id. Note,
# each run of workqueue_runner will only generate work for a single job_id, so
# workers can safely ignore that field when pulling work.

# Results are stored in a Redis hash called "hipmunk:result", that has 1
# field per job_id, where the value is the sum of all the work items with the
# corresponding job_id.


# Note!
# The given implementation works fine for a single worker, but something isn't
# quite right when I add more workers. Maybe you can help me figure that out?

from gevent import monkey
monkey.patch_all()

import gevent
import json
import logging
import argparse
import random
import redis


def make_redis_key(key):
    return 'hipmunk:%s' % key

WORK_QUEUE = make_redis_key('queue')
RESULT_HASH = make_redis_key('result')
LOG = logging.getLogger(__name__)
REDIS = None


def worker(worker_id):
    """
    Simpler worker implementation.

    Pulls work items from the queue, and adds their values to the result hash
    """
    while True:
        # pull the first work item
        work_raw = REDIS.lindex(WORK_QUEUE, 0)
        if not work_raw:
            # no more work to do, so we're done
            return

        # delete it from the queue
        REDIS.lrem(WORK_QUEUE, 0, work_raw)

        # de-jsonify the work, and update the result hash
        work = json.loads(work_raw)
        LOG.debug('Got work! worker_id: %d, work: %r', worker_id, work)
        REDIS.hincrby(RESULT_HASH, work['job_id'], work['value'])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        '--num-work-items', '-n',
        type=int,
        help='number of work items to enqueue',
        default=10)
    parser.add_argument(
        '--num-workers', '-w',
        type=int,
        help='number of worker greenlets to spawn',
        default=1)
    parser.add_argument(
        '--timeout', '-t',
        type=int,
        help='time to wait for a result (in seconds)',
        default=5)
    parser.add_argument(
        '--loglevel', type=int, help='loglevel to use', default=20)
    parser.add_argument(
        '--host', help='Redis hostname', default='localhost')
    parser.add_argument(
        '--port', help='Redis port', type=int, default=6379)
    args = parser.parse_args()

    logging.basicConfig()
    LOG.setLevel(args.loglevel)

    REDIS = redis.StrictRedis(host=args.host, port=args.port, db=0)

    # Delete any old work keys (also serves to verify the Redis connection)
    try:
        REDIS.delete(WORK_QUEUE, RESULT_HASH)
    except redis.exceptions.ConnectionError:
        LOG.error(
            'Unable to connect to Redis at: %s:%d', args.host, args.port)
        exit(1)

    # Enqueue the work items
    job_id = random.randint(1, 100)
    expected_result = 0
    for _ in range(args.num_work_items):
        value = random.randint(1, 1000)
        w = {
            'job_id': job_id,
            'attempt_nr': 1,
            'value': value,
        }
        expected_result += value
        REDIS.lpush(WORK_QUEUE, json.dumps(w))
        LOG.debug("Enqueued work item: %r", w)

    # Spawn workers, and wait for them to finish
    workers = [gevent.spawn(worker, n) for n in range(args.num_workers)]
    gevent.joinall(workers, timeout=args.timeout)

    # Verify the result
    res = REDIS.hget(RESULT_HASH, job_id)
    if res is None:
        LOG.error("Unable to find the result in Redis")
        exit(1)

    # Compare result to the expected value
    res = int(res)

    if res == expected_result:
        LOG.info('SUCCESS!')
    else:
        LOG.warn(
            "Result doesn't match expected value: %d vs %d",
            res,
            expected_result
        )
