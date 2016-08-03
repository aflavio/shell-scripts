# this use high compression

ffmpeg -y -ss 10 -t 15 -i final.mp4 \
  -vf fps=5,scale=480:-1:flags=lanczos,palettegen palette.png

ffmpeg -ss 3 -t 25 -i final.mp4 -i palette.png -filter_complex \
  "fps=2,scale=480:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif
