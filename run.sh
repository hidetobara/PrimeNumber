#!/bin/sh

LIMIT=10000
if [ $# -eq 1 ];
then
  LIMIT=$1
fi
echo "What is the $LIMIT th prime number ?"
ROOT=`pwd`

if type gcc > /dev/null 2>&1
then
  echo "Now start gcc."
  cd cpp
  gcc prime.cpp
  ./a.out $LIMIT
  cd $ROOT
  cd multithread2_cpp
  gcc prime.cpp -lpthread
  ./a.out $LIMIT
  cd $ROOT
fi

if type g++ > /dev/null 2>&1
then
  echo "Now start g++."
  cd multithread_cpp
  g++ -std=c++11 -I/usr/local/lib/gcc49/include/c++/ -Wl,-rpath=/usr/local/lib/gcc49 -pthread prime.cpp
  ./a.out $LIMIT
  cd $ROOT
fi

if type python3 > /dev/null 2>&1
then
  echo "Now start python."
  cd python
  python3 prime.py $LIMIT
  cd $ROOT
  cd multithread_python
  python3 prime.py $LIMIT
  cd $ROOT
  cd multiprocess_python
  python3 prime.py $LIMIT
  cd $ROOT
fi

if type javac > /dev/null 2>&1
then
  echo "Now start java."
  cd java
  javac Prime.java
  java Prime $LIMIT
  cd $ROOT
fi

if type php > /dev/null 2>&1
then
  echo "Now start php."
  cd php
  php prime.php $LIMIT
  cd $ROOT
fi

if type ruby > /dev/null 2>&1
then
  echo "Now start ruby."
  cd ruby
  ruby prime.rb $LIMIT
  cd $ROOT
fi

if type node > /dev/null 2>&1
then
  echo "Now start node."
  cd node
  node prime.js $LIMIT
  cd $ROOT
else
  if type nodejs > /dev/null 2>&1
    echo "Now start node."
    cd node
    nodejs prime.js $LIMIT
    cd $ROOT
  fi
fi

if type dotnet > /dev/null 2>&1
then
  echo "Now start dotnet."
  cd dotnet
  dotnet build -c Release
  dotnet run -c Release --project prime $LIMIT
  cd $ROOT
fi

if type nvcc > /dev/null 2>&1
then
  echo "Now start nvcc."
  cd nvcc
  nvcc prime.cu
  ./a.out $LIMIT
  cd $ROOT
fi

if type go > /dev/null 2>&1
then
  echo "Now start go."
  cd golang
  go run prime.go $LIMIT
  cd $ROOT
fi
