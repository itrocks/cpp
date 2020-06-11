# it.rocks

This is a simple hello world web server application.
The beginning of a huge information technology system, I bet.

## Install

This procedure is for Debian / Ubuntu systems.

### Pre-requisites

You will need g++ 10 for this. Let's learn modern C++ (C++20) !

```bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt install gcc-10 g++-10 gdb git
```

Source :\
https://askubuntu.com/questions/1192955/how-to-install-g-10-on-ubuntu-18-04

You may need to change your default gcc / g++ version :

```bash
cd /usr/bin
sudo rm gcc
sudo rm g++
sudo ln -s gcc-10 gcc
sudo ln -s g++-10 g++
gcc --version
g++ --version
```

Both version 10 ? It's alright !

### Download and initialize the project

```bash
git clone https://github.com/itrocks/cpp itrocks-cpp
cd itrocks-cpp
mkdir dist
mkdir uWebSockets
git submodule init
git submodule update
cd uWebSockets
git submodule init
git submodule update
make
```

No error ? Your libraries are ready.

### Compile the project

```bash
cd itrocks-cpp
make
```

No error ? Your executable should be into dist/main.

### Run

```bash
cd itrocks-cpp
dist/main
```

The webserver will run and wait for calls. What it says on console :

```
Thread 140135146346240 listening on port 3000
Thread 140135137953536 listening on port 3000
```

You will have one thread per logical cpu you've got into your computer :

```bash
cat /proc/cpuinfo
```

### Test

Launch your favorite web browser and :\
http://localhost:3000

- The page will display "Hello world!".
- The running web server console will display "Incoming connection !" (maybe twice if your browser wants a favicon)

### So what ?

There will probably be more to come :).
