from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import numpy

setup(name = 'PySound',
      ext_modules = cythonize(
          Extension('sound',
                    sources=['sound.pyx'],
                    libraries=['sfml-system', 'sfml-audio'],
                    include_dirs=[numpy.get_include()],
                    language='c++'),
          gdb_debug=False))
