import time
from sound cimport Player, Chunk, Stopped, Paused, Playing
import numpy
cimport numpy

cdef class ArrayWrapper:
    cdef Int16 *data
    cdef size_t size

    cdef set_data(self, Int16 *data, size_t size):
        self.data = data
        self.size = size

    def __array__(self):
        cdef numpy.npy_intp shape[1]
        shape[0] = <numpy.npy_intp> self.size

        ndarray = numpy.PyArray_SimpleNewFromData(1, shape, numpy.NPY_INT, self.data)
        return ndarray

cdef cbool __callback__(object self, Chunk &chunk) with gil:
        numpy_data, keep_playing = (<SoundPlayer>self).callback()
        if numpy.issubdtype(numpy_data.dtype, numpy.floating):
            numpy_data *= 2**15
        cdef numpy.ndarray[signed short, ndim=1, mode="c"] data
        data = numpy.ascontiguousarray(numpy_data.ravel(), 'int16')
        # load and play the data:
        chunk.samples = <Int16 *>data.data
        chunk.sampleCount = len(data)
        return <cbool>keep_playing

cdef class SoundPlayer:
    cdef Player *thisptr
    cdef object callback

    def __cinit__(self, callback, samplerate, channelcount):
        self.callback = callback
        self.thisptr = new Player(self, &__callback__, samplerate, channelcount)

    def __dealloc__(self):
        del self.thisptr

    def play(self):
        self.thisptr.play()

    @property
    def playing(self):
        return self.thisptr.getStatus() == Playing
