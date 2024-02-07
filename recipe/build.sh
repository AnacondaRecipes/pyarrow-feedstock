#!/bin/sh

set -e
set -x

# Build dependencies
export ARROW_HOME=$PREFIX
export PARQUET_HOME=$PREFIX
export SETUPTOOLS_SCM_PRETEND_VERSION=$PKG_VERSION
export PYARROW_WITH_ACERO=1
export PYARROW_BUILD_TYPE=release
export PYARROW_WITH_DATASET=1
export PYARROW_WITH_FLIGHT=1
export PYARROW_WITH_HDFS=1
export PYARROW_WITH_ORC=1
export PYARROW_WITH_PARQUET=1
export PYARROW_WITH_PARQUET_ENCRYPTION=1
export PYARROW_WITH_S3=1
export PYARROW_WITH_SUBSTRAIT=1
export PYARROW_WITH_GANDIVA=0
export PYARROW_WITH_CUDA=0

cd python

${PYTHON} -m pip install . -vv --no-deps --no-build-isolation

rm -r ${SP_DIR}/pyarrow/tests
