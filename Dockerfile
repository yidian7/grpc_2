FROM  yidian7/opencv:latest
LABEL dlib Yin jiao<yinjiao@jcble.com>

WORKDIR /usr/local/src


#install dlib_change_save_size_to_256
RUN apt-get -y install wget
RUN apt-get update && apt-get install -y \
  build-essential autoconf libtool \
  git \
  pkg-config \
  && apt-get clean

RUN apt-get update
RUN apt-get install -y --no-install-recommends python libboost-dev cmake
RUN cd /usr/local/src
RUN git clone  --depth 1 https://github.com/davisking/dlib.git
RUN git clone  --depth 1 https://github.com/yidian7/some_file.git
RUN mv some_file/interpolation_abstract.h dlib/dlib/image_transforms/
RUN cd dlib/examples
RUN mkdir build
RUN cd build
RUN cmake ..
RUN cmake --build . --config Release
RUN cd ../
RUN wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2 && \
    bunzip2 shape_predictor_68_face_landmarks.dat.bz2



ENV GRPC_RELEASE_TAG v1.0.0

RUN git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc

# install grpc
RUN cd /var/local/git/grpc && \
    git submodule update --init && \
    make && \
    make install && make clean

#install protoc
RUN cd /var/local/git/grpc/third_party/protobuf && \
    make && make install && make clean
