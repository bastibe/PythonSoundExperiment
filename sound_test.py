import time
from soundfile import SoundFile
from sound import SoundPlayer

with SoundFile("Mann_short.wav") as f:
    def callback():
        data = f.read(8096)
        return data, len(data) > 0
    player = SoundPlayer(callback, f.samplerate, f.channels)
    player.play()
    while player.playing:
        time.sleep(0.1)
