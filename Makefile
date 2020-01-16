all:
	go build -o psstop main.go
	go build -o tcp-server tcp-server.go
static:
	go build -o psstop -a -ldflags '-extldflags "-static"' main.go
clean:
	rm -rf psstop tcp-server
	rm -rf *.csv

