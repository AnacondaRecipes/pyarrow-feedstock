pushd "%SRC_DIR%"\python

@rem the symlinks for cmake modules don't work here
del cmake_modules\BuildUtils.cmake
del cmake_modules\SetupCxxFlags.cmake
del cmake_modules\CompilerInfo.cmake
del cmake_modules\FindNumPy.cmake
del cmake_modules\FindPythonLibsNew.cmake
copy /Y "%SRC_DIR%\cpp\cmake_modules\BuildUtils.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\SetupCxxFlags.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\CompilerInfo.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\FindNumPy.cmake" cmake_modules\
copy /Y "%SRC_DIR%\cpp\cmake_modules\FindPythonLibsNew.cmake" cmake_modules\

SET ARROW_HOME=%LIBRARY_PREFIX%
SET SETUPTOOLS_SCM_PRETEND_VERSION=%PKG_VERSION%
SET PYARROW_BUILD_TYPE=release
SET PYARROW_WITH_S3=1
SET PYARROW_WITH_HDFS=1
SET PYARROW_WITH_DATASET=1
SET PYARROW_WITH_FLIGHT=1
SET PYARROW_WITH_GANDIVA=0
SET PYARROW_WITH_PARQUET=1
SET PYARROW_CMAKE_GENERATOR=Ninja
SET PYARROW_WITH_CUDA=0
@rem manually specify the path to the cmake config files
SET Arrow_DIR=%ARROW_HOME%\cmake\Arrow
SET ArrowFlight_DIR=%ARROW_HOME%\cmake\ArrowFlight
SET ArrowDataset_DIR=%ARROW_HOME%\cmake\ArrowDataset
SET Parquet_DIR=%ARROW_HOME%\cmake\Parquet
@rem move the arrow_python.* files to solve issue due to missing $RPATH
copy /Y "%SRC_DIR%\python\build\dist\lib\arrow_python.lib" "%PREFIX%\Lib\"
copy /Y "%SRC_DIR%\python\build\dist\lib\arrow_python.lib" "%PREFIX%\Lib\site-packages\pyarrow\"
copy /Y "%SRC_DIR%\python\build\dist\bin\arrow_python.dll" "%PREFIX%\Lib\site-packages\pyarrow\"
copy /Y "%SRC_DIR%\python\build\dist\bin\arrow_python.dll" "%PREFIX%\Library\bin\"
copy /Y "%SRC_DIR%\python\build\dist\bin\arrow_python.dll" "%PREFIX%\DLLs\"
copy /Y "%SRC_DIR%\python\build\dist\lib\arrow_python.lib" "%PREFIX%\libs\"

copy /Y "%SRC_DIR%\python\build\dist\lib\arrow_python.lib" "%BUILD_PREFIX%\Lib\"
copy /Y "%SRC_DIR%\python\build\dist\lib\arrow_python.lib" "%BUILD_PREFIX%\Lib\site-packages\"
copy /Y "%SRC_DIR%\python\build\dist\bin\arrow_python.dll" "%BUILD_PREFIX%\Lib\site-packages\"
copy /Y "%SRC_DIR%\python\build\dist\bin\arrow_python.dll" "%BUILD_PREFIX%\Library\bin\"
copy /Y "%SRC_DIR%\python\build\dist\bin\arrow_python.dll" "%BUILD_PREFIX%\DLLs\"
copy /Y "%SRC_DIR%\python\build\dist\lib\arrow_python.lib" "%BUILD_PREFIX%\libs\"

"%PYTHON%" setup.py ^
           build_ext ^
           install --single-version-externally-managed ^
                   --record=record.txt
if errorlevel 1 exit 1
popd

rd /s /q %SP_DIR%\pyarrow\tests

