A proof-of-concept wrapper of SFML for playing audio in Python.

[`SoundPlayer`](https://github.com/bastibe/PythonSoundExperiment/blob/master/sound.pyx#L20) queues a list of audio signals and hands them to [`sf::SoundStream`](http://www.sfml-dev.org/documentation/2.3.2/classsf_1_1SoundStream.php) one by one. You can queue new audio signals using `SoundPlayer.play()`. Note that it is not fast enough for actual use. Audio signals shorter than 1024 samples do not playback smoothly.

`SoundPlayer` wraps `sf::SoundStream` such that it's `onGetData` callback really calls a Python function. In more detail, `sf::SoundStream` is wrapped with a C++ class `Player` in *player.hpp*, which implements the `sf::SoundStream::onGetData` with a function pointer that points to a C function `__callback__` in *sound.pyx*, which calls the Python method `SoundPlayer._callback` in *sound.pyx*. 

Since this is too slow for my use case, I will not develop this further. It is a nice experiment of using Cython, though, so I keep it around for educational purposes.
