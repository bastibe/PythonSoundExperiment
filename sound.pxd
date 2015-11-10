from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr

cdef extern from "SFML/Config.hpp" namespace "sf":
    ctypedef signed   char Int8
    ctypedef unsigned char Uint8
    ctypedef signed   short Int16
    ctypedef unsigned short Uint16
    # if os.name == 'nt':
    #     ctypedef signed   __int64 Int64;
    #     ctypedef unsigned __int64 Uint64;
    # else:
    ctypedef signed   int Int32
    ctypedef unsigned int Uint32
    ctypedef signed   long long Int64
    ctypedef unsigned long long Uint64

cdef extern from "SFML/Audio/SoundSource.hpp" namespace "sf":
    ctypedef enum Status "sf::SoundSource::Status":
        Stopped "sf::SoundSource::Stopped"
        Paused "sf::SoundSource::Paused"
        Playing "sf::SoundSource::Playing"

cdef extern from "SFML/Audio/SoundBuffer.hpp" namespace "sf":
    cdef cppclass SoundBuffer:
        SoundBuffer() except +
        # SoundBuffer(const SoundBuffer &) except +
        # cbool loadFromFile(const cstr &)
        # cbool loadFromStream(InputStream &)
        cbool loadFromSamples(Int16 *, Uint64, unsigned int, unsigned int)
        const Int16 *getSamples()
        Uint64 getSampleCount()
        unsigned int getSampleRate()
        unsigned int getChannelCount()

cdef extern from "SFML/Audio/Sound.hpp" namespace "sf":
    cdef cppclass Sound:
        Sound() except +
        # Sound(Sound &) except +
        # Sound(const SoundBuffer &) except +
        void play()
        Status getStatus()
        void setBuffer(const SoundBuffer &)
