#!/bin/sh

ROOT=`pwd`

if type python3 > /dev/null 2>&1
then
  echo "Now start python."
  cd python
  python3 prime.py
  cd $ROOT
  cd multithread_python
  python3 prime.py
  cd $ROOT
  cd multiprocess_python
  python3 prime.py
  cd $ROOT
fi

if type gcc > /dev/null 2>&1
then
  echo "Now start gcc."
  cd cpp
  gcc prime.cpp
  ./a.out
  cd $ROOT
fi

if type g++ > /dev/null 2>&1
then
  echo "Now start g++."
  cd multithread_cpp
  g++ -std=c++11 -I/usr/local/lib/gcc49/include/c++/ -Wl,-rpath=/usr/local/lib/gcc49 -pthread prime.cpp
  ./a.out
  cd $ROOT
fi

if type php > /dev/null 2>&1
then
  echo "Now start php."
  cd php
  php prime.php
  cd $ROOT
fi

if type node > /dev/null 2>&1
then
  echo "No start node."
  cd node
  node prime.js
  cd $ROOT
fi

if type dotnet > /dev/null 2>&1
then
  echo "Now start dotnet."
  cd dotnet
  dotnet build -c Release
  dotnet run -c Release --project prime
  cd $ROOT
fi

if type nvcc > /dev/null 2>&1
then
  echo "Now start nvcc."
  cd nvcc
  nvcc prime.cu
  ./a.out
  cd $ROOT
fi

if type go > /dev/null 2>&1
then
  echo "Now start go."
  cd golang
  go run prime.go
  cd $ROOT
fi
