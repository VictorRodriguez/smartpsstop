# PSSTOP

PSSTOP is a tool to detect and track process with heavy use of memory. It runs
on bare metal, virtual machines or containers.

It uses the Proportional Set Size (PSS) memory from the /proc directory to measure the memory of each process. 

In computing, proportional set size (PSS) is the portion of main memory (RAM) occupied by a process and is composed by the private memory of that process plus the proportion of shared memory with one or more other processes. Unshared memory including the proportion of shared memory is reported as the PSS.

Example:

    Process A has 50 KiB of unshared memory
    Process B has 300 KiB of unshared memory
    Both process A and process B have 100 KiB of the same shared memory region

Since the PSS is defined as the sum of the unshared memory of a process and the proportion of memory shared with other processes, the PSS for these two processes are as follows:

    PSS of process A = 50 KiB + (100 KiB / 2) = 100 KiB
    PSS of process B = 300 KiB + (100 KiB / 2) = 350 KiB

PSS solves the complications when trying to count the "real memory" used by a process. The concepts of resident set size or virtual memory size (VmSize) weren't helping developers who tried to know how much memory their programs were using.


## Architecture

PSSTOP tries to follow the philosophy of doing one thing and do it well.

* Run on all in one systems:
	```
	$ psstop
	[short example list]

	Process Name		PID	PSS Memory (Kb)
	------------		----	--------------
	vim			50300	9236 Kb
	psstop			50324	10288 Kb
	NetworkManager		238	10443 Kb

 	Total				87319	 Kb
	Total				87	 Mb
	Total number of processes: 	87
	```

* Monitor just one process:
	```
	$ psstop -p  systemd

	 Process Name	PID		PSS Memory (Kb)
	 ------------	----		--------------
	 systemd	596		2986 Kb
	 systemd	1		4642 Kb

	 Total				7628	 Kb
	 Total				7	 Mb
	 Total number of processes: 	2
	```

TODO:

* Run as a service and save the data in a time series DB (influx DB) in a
	server system

* Use statistics algorithms to detect regressions on client system under
analysis

## Getting Started

These instructions will get you a copy of the project up and running on your
local machine for development and testing purposes. See deployment for notes on
how to deploy the project on a live system.

### Prerequisites

The client binary is built statically, it should not require more than libc to
run inside the system under analysis.

### Installing


```
make static
make install
```

This will install the psstop under /usr/bin

Is also possible to create a service to track the specific process over the
time.

Create a Unit file to define a systemd service:

/lib/systemd/system/psstop.service

```
[Unit]
Description=psstop systemd service.

[Service]
Type=simple
ExecStart=/usr/bin/smartpsstop -m -p systemd
Restart=on-failure
StandardOutput=file:/var/log/logfile

[Install]
WantedBy=multi-user.target
```

## Deployment

Add additional notes about how to deploy this on a live system

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available,
see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Victor Rodriguez** - *Initial work* - [VictorRodriguez](https://github.com/VictorRodriguez)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


