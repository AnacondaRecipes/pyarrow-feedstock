pushd "%SRC_DIR%"\python

@rem the symlinks for cmake modules don't work here
del cmake_modules\BuildUtils.cmake
del cmake_modules\SetupCxxFlags.cmake
del cmake_modules\CompilerInfo.cmake
del cmake_modules\FindNumPy.cmake
del cmake_modules\FindPythonLibsNew.cmake
del cmake_modules\ArrowDatasetConfig.cmake
copy /Y "%SRC_DIR%\cpp\cmake_modules\BuildUtils.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\SetupCxxFlags.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\CompilerInfo.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\FindNumPy.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\FindPythonLibsNew.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\ArrowDatasetConfig.cmake" cmake_modules\

SET ARROW_HOME=%LIBRARY_PREFIX%
SET SETUPTOOLS_SCM_PRETEND_VERSION=%PKG_VERSION%
SET PYARROW_BUILD_TYPE=release
SET PYARROW_WITH_ACERO=1
SET PYARROW_WITH_S3=1
SET PYARROW_WITH_SUBSTRAIT=1
SET PYARROW_WITH_HDFS=1
SET PYARROW_WITH_DATASET=1
SET PYARROW_WITH_FLIGHT=1
SET PYARROW_WITH_GANDIVA=0
SET PYARROW_WITH_ORC=1
SET PYARROW_WITH_PARQUET=1
SET PYARROW_WITH_PARQUET_ENCRYPTION=1
SET PYARROW_CMAKE_GENERATOR=Ninja
SET PYARROW_WITH_CUDA=0
SET PYARROW_WITH_AZURE=0
SET PYARROW_WITH_GCS=0
@rem manually specify the path to the cmake config files
SET Arrow_DIR=%ARROW_HOME%\cmake\Arrow
SET ArrowFlight_DIR=%ARROW_HOME%\cmake\ArrowFlight
SET ArrowDataset_DIR=%ARROW_HOME%\cmake\ArrowDataset
SET ArrowAcero_DIR=%ARROW_HOME%\cmake\ArrowAcero
SET Parquet_DIR=%ARROW_HOME%\cmake\Parquet
SET ArrowSubstrait_DIR=%ARROW_HOME%\cmake\ArrowSubstrait

"%PYTHON%" -m pip install . -vv --no-deps --no-build-isolation

if errorlevel 1 exit 1
popd

rd /s /q %SP_DIR%\pyarrow\tests
