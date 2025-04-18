from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import numpy

extensions = [
    Extension(
        "im2col_cython",
        ["im2col_cython.pyx"],
        include_dirs=[numpy.get_include()]
    ),
]

setup(
    ext_modules=cythonize(
        extensions,
        compiler_directives={'language_level': 3}  # 指定 Python 3 語言等級
    ),
)
