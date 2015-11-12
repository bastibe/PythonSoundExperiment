import time
from soundfile import SoundFile
from sound import SoundPlayer

blocksize = 1024

player = SoundPlayer(44100, 1)
for block in SoundFile("Mann_short.wav").blocks(blocksize):
    player.play(block)
while player.isplaying:
    time.sleep(0.1)
