all:
	go build -o psstop main.go
	go build -o tcp-server tcp-server.go
static:
	go build -o psstop -a -ldflags '-extldflags "-static"' main.go
install:
	cp -f psstop /usr/sbin/smartpsstop
	cp smartpsstop.service /etc/systemd/system/
	cp smartpsstop.conf /etc/
	systemctl daemon-reload
	systemctl start smartpsstop
clean:
	rm -rf psstop tcp-server
	rm -rf *.csv

