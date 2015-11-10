from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(name = 'PySound',
      ext_modules = [
          Extension('sound',
                    sources=['sound.pyx'],
                    libraries=['sfml-system', 'sfml-audio'],
                    language='c++',
                    runtime_library_dirs=['/usr/local/lib/'])],
      cmdclass = {'build_ext': build_ext})
