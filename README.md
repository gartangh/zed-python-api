# Stereolabs ZED - Python API

This package lets you use the ZED stereo camera in Python 3.

## Stable API notice

The ZED Python API is now stable but has some breaking changes from the previous (beta) version. The older beta version can be found in the [legacy branch](https://github.com/stereolabs/zed-python-api/tree/legacy).

The changes were made to better reflect the C++ API and ease of use. Mainly all classes have a similar name to the C++ SDK (without the "Py" prefix), and all components were migrated to a unified `sl` namespace.

## Getting started

- First, download the latest version of the ZED SDK on [stereolabs.com](https://www.stereolabs.com/developers)
- For more information, read the ZED [API documentation](https://www.stereolabs.com/developers/documentation/API/)

### Prerequisites

- [ZED SDK 2.7](https://www.stereolabs.com/developers/) and its dependency 
[CUDA](https://developer.nvidia.com/cuda-downloads)
- Python 3.5+ (x64).  ([Windows installer](https://www.python.org/ftp/python/3.6.2/python-3.6.2-amd64.exe))
-  C++ compiler (VS2015 recommended)
- [Cython 0.26](http://cython.org/#download)
- [Numpy 1.13.1](https://www.scipy.org/scipylib/download.html)

Please check your python version with the following command. The result should be 3.5 or higher.

```
python --version
```

Cython and Numpy can be installed via pip.
```
python -m pip install cython numpy
```

**Note:** On Linux, it is advised to use the `python3` command instead of `python` which by default point to python 2.7. To do so, the following packages `python3-dev` and `python3-pip` need to be installed.

```
python3 --version
pip3 install -r requirements.txt
```
  
### Build the plugin

```
python setup.py build
python setup.py install
```

or on Linux

```
python3 setup.py build
python3 setup.py install
```


If an __error__ occurs during the compilation, make sure that you're using the latest [ZED SDK](https://www.stereolabs.com/developers/) and that you installed an x64 version of python. `python -c "import platform; print(platform.architecture())"`

The packages *.pyd* for Windows or *.so* for Linux will be generated and installed.

You can use `python setup.py cleanall` to remove every cpp files generated and build directory.

> Make sure to be **out** of the plugin driectory when using it. It will prevent Python from considering the `pyzed` folder of the plugin as the **pyzed** package.

## Use the plugin

### Code

Import the packages in your Python terminal or file like this:
```
import pyzed.sl as sl
```

Vectors operations like norm, sum, square, dot, cross, distance but also simple operations can be done with
Numpy package.

### Run the tutorials

The [tutorials](tutorials) provide simple projects to show how to use each module of the ZED SDK. For a similar version using the C++ API checkout the [Cpp tutorials](https://github.com/stereolabs/zed-examples/tree/master/tutorials).

### Run the examples

Please refer to the [examples](examples) README for more informations.

## Generate the API documentation

The documentation is provided in the [doc](./doc) folder and has to be built first.

Sphinx is used to generates the html documentation.

1. The zed-python-api has to be compiled and installed
2. Make sure `sphinx` and `sphinx_rtd_theme` are installed

```bash
    cd doc
    pip3 install -r requirements.txt
```

3. Generate the documentation by running the provided [Makefile](doc/Makefile) (Linux) or [make.bat](doc/make.bat) (Windows)

```bash
    make html
```

4. The documentation can be viewed in a browser by opening the generated [index.html file](doc/build/html/index.html) located in `doc/build/html/`


## Contributing

Feel free to open an issue if you find a bug, or a pull request for bug fixes, features or other improvements.
