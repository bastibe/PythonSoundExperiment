import time
from sound cimport SoundBuffer, Sound, Stopped, Paused, Playing
import numpy
cimport numpy

cdef class SoundCards:
    # make sure these don't go out of scope when play exits:
    cdef Sound sound
    cdef SoundBuffer sound_buffer

    def play(self, numpy_data, channels, samplerate, blocking=True):
        # convert floating point data to int16 value range:
        if numpy.issubdtype(numpy_data.dtype, numpy.floating):
            numpy_data *= 2**15
        # TODO: do I need to scale non-16-bit integer data?
        # make sure the data is in the right format:
        cdef numpy.ndarray[signed short, ndim=1, mode="c"] data
        data = numpy.ascontiguousarray(numpy_data.ravel(), 'int16')
        # load and play the data:
        self.sound_buffer.loadFromSamples(<Int16 *>data.data, len(data)/channels, channels, samplerate)
        self.sound.setBuffer(self.sound_buffer)
        self.sound.play()

        if blocking:
            while self.sound.getStatus() == Playing:
                time.sleep(0.1)
