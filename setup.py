from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy

setup(name = 'PySound',
      ext_modules = [
          Extension('sound',
                    sources=['sound.pyx'],
                    libraries=['sfml-system', 'sfml-audio'],
                    include_dirs=[numpy.get_include()],
                    language='c++')],
      cmdclass = {'build_ext': build_ext})
