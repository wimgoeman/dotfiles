function screen-shot
  set imageFile '/tmp/'(date "+%Y-%m-%d_%H-%M-%S")'.png'
  import $imageFile
  xclip -selection clipboard -target image/png -i $imageFile
end
