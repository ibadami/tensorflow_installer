#!/usr/bin/bash
INSTALL_DIR=/usr/local

sudo rm -r ${INSTALL_DIR}/include/google/tensorflow
sudo rm ${INSTALL_DIR}/lib/libtensorflow_cc.so
sudo rm ${INSTALL_DIR}/lib/tensorflow_framework.so

# copy the library to the install directory
sudo cp bazel-bin/tensorflow/libtensorflow_cc.so ${INSTALL_DIR}/lib
sudo cp bazel-bin/tensorflow/libtensorflow_framework.so ${INSTALL_DIR}/lib

# Copy the source to $INSTALL_DIR/include/google and remove unneeded items:
mkdir -p ${INSTALL_DIR}/include/google/tensorflow
cp -r tensorflow ${INSTALL_DIR}/include/google/tensorflow/
find ${INSTALL_DIR}/include/google/tensorflow/tensorflow -type f  ! -name "*.h" -delete

# Copy all generated files from bazel-genfiles:
cp  bazel-genfiles/tensorflow/core/framework/*.h ${INSTALL_DIR}/include/google/tensorflow/tensorflow/core/framework
cp  bazel-genfiles/tensorflow/core/kernels/boosted_trees/*.h ${INSTALL_DIR}/include/google/tensorflow/tensorflow/core/kernels/boosted_trees
cp  bazel-genfiles/tensorflow/core/lib/core/*.h ${INSTALL_DIR}/include/google/tensorflow/tensorflow/core/lib/core
cp  bazel-genfiles/tensorflow/core/protobuf/*.h ${INSTALL_DIR}/include/google/tensorflow/tensorflow/core/protobuf
cp  bazel-genfiles/tensorflow/core/util/*.h ${INSTALL_DIR}/include/google/tensorflow/tensorflow/core/util
cp  bazel-genfiles/tensorflow/cc/ops/*.h ${INSTALL_DIR}/include/google/tensorflow/tensorflow/cc/ops

# Copy the third party directory:
cp -r third_party ${INSTALL_DIR}/include/google/tensorflow/
rm -r ${INSTALL_DIR}/include/google/tensorflow/third_party/py

# Note: newer versions of TensorFlow do not have the following directory
rm -rf ${INSTALL_DIR}/include/google/tensorflow/third_party/avro
