StreamSight
===========

StreamSight is a query-driven framework for streaming analytics
in edge computing. It supports  users  in  composing  analytic  queries
that  are  automatically  translated  and  mapped  to  streaming
operations  suitable  for  running  on  distributed  processing  engines
deployed  in  wide  areas  of  coverage. Our reference implementation
has been integrated with Apache Spark 2.1.1.

## What does StreamSight do?

Data  scientists  and  platform  operators  can compose complex
analytic queries without any knowledge of the programmable model of
the underlying distributed processing engine by solely using high-level
directives and expressions.
An example of such analytic query from the domain of intelligent
 transportation is the following:
```
COMPUTE
    ARITHMETIC_MEAN(bus_delay, 10 MINUTES)
    BY city_segment
EVERY 5 SECONDS
```
The above query computes for a  10min  sliding  window  the  average  bus
delay per city segment with new datapoints considered every 5s, which is
particularly useful for a traffic operator in detecting traffic
congestion in each city segment.
Furthermore, StreamSight gives user the ability to:
1. Prioritize query execution so results of high importance are always
output in time (e.g., high load influx),  while  low  priority
 insights  are  scheduled  when resources  are  available
2. Request  query  enforcement on  a  sample  of  the  data  stream
for  indicative  but  in time  responses
3. Define  constraints  such  as  the maximum  tolerable  upper
 error  bounds  for  approximate query responses
```
COMPUTE
    ARITHMETIC_MEAN(bus_delay, 10 MINUTES)
    BY city_segment EVERY 5 SECONDS
    WITH MAX_ERROR 0.005 AND CONFIDENCE 0.95
```
The above example extends the previous query so  that  approximate
answers  are  provided  to significantly improve response time
by executing the query on a sample of the data stream.

## Getting Started

### Build StreamSight
1. Make sure you've installed [Docker](https://www.docker.com/get-started) on your machine.
2. Configure (optionally) and submit your queries:
    * See [this](#configuration) section for configuring StreamSight.
    * See [this](#insight-declaration-examples) section for composing your queries.
3. Build the docker image using the following command:
```bash
docker build -t streamsight -f Dockerfile .
```

### Local Mode
Run StreamSight in  your local machine
```
docker run -p 4040:4040 -it streamsight
```

### Cluster Mode
If you have an existing Spark Cluster, you only have to specify the
address of the master node:
```
MASTER_NODE=spark://${spark-url}
spark-submit --master $MASTER_NODE ./StreamSight-0.0.1.jar
```


For convenience, we provide a number of scripts (located in directory **/cluster**)
to help you setup a Spark cluster via docker-compose.
The only requirement is to have [docker-compose](https://docs.docker.com/compose/install/)
installed on your system.

```bash
cd cluster/
# Create 1 Master and 4 Spark workers
./start-infra.sh

# You can scale to 8 workers with the following script:
./scale-workers.sh 8

# To submit StreamSight, just run:
./build-run-cluster.sh

```

## StreamSight Architecture

The following figure depicts a high-level and abstract overview of the StreamSight framework. Users submit ad-hoc queries following the declarative query model and the system compiles these queries into low-level streaming commands. 

![image](https://github.com/UCY-LINC-LAB/StreamSight/blob/readme-updates/img/compiling_phase.png)

Once the executable artifact is produced, users can submit it to the underlying distributed processing engine. The raw monitoring metrics are fed into the processing engine where they 
are transformed into analytic insights and streamed to a high-availability queuing system.

![image](https://github.com/UCY-LINC-LAB/StreamSight/blob/readme-updates/img/runtime_phase.png)

## Insight Declaration Examples
...

## Configuration

|Parameter|Default Value|Description|
|------|-----------|----|
|app| insights-test | The name of the StreamSight job |
|insights.file| /home/insights.ins | The file containing insights|
|dummy.input| true | When enabled a producer pushes random measurements to the system|
|dummy.interval| 100 | The periodicity  of the dummy producer in ms|
|dummy.dimensions| 5 | The number of metrics produced (e.g., m1,m2,...) |

## Reference
When using the framework please use the following reference to cite our work:

"StreamSight: A Query-Driven Framework for Streaming Analytics in Edge Computing", Z. Georgiou, M. Symeonides, D. Trihinas, G. Pallis, M. D. Dikaiakos, 11th IEEE/ACM International Conference on Utility and Cloud Computing (UCC 2018), Zurich, Switzerland, Dec 2018.

## Licence
The framework is open-sourced under the Apache 2.0 License base. The codebase of the framework is maintained by the authors for academic research and is therefore provided "as is".
