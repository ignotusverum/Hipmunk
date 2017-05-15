# Distributed Work Queue
For this problem, we want you to build a simple distributed work queue. The system will consist of a client who enqueues some amount of work, and a number of workers who will process the work in parallel, and save the result.

# The Problem
We have provided a stub implementation, that enqueues work in Redis, spawns a number of worker greenlets who consume the work, and then write the result back to Redis. Your job is to take our basic implementation, and improve upon it. While this is a very open-ended task, here is a short list of things to consider:

* What store/data structure is being used to enqueue unprocessed work? Can you guarantee that each item is only processed by a single worker? If not, is this a problem, and if it is, how do you solve it?
* If you wanted to ensure that the same work item was only enqueue once, how would you do that?
* The current implementation doesn't support any notion of priorities. If you wanted to add this, how could that be done?
* What are the bottlenecks? How would you measure this?
* Can the system get overloaded? What happens if you queue up hundreds of thousands of work items? What are some reasonable solutions to avoid or handle this?
* Is it robust? Can work ever get lost? What happens if workers crash?
* Right now the system is "fire-and-forget". Once work is submitted, there is no way to get informed about its status. How could this be improved?


# Testing
The test harness will enqueue work and spawn workers. After a brief period of time, it will try to fetch a result from Redis, and verify that this matches the expected result. When submitting your implementation, verify that it works as expected for varying amounts of workers and work items.

Run `python -m workqueue.workqueue_runner --help` to see valid command line options.

# Important

This problem requires a [Redis](http://redis.io/) server.
