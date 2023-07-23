#!/usr/bin/env bash


installFonts() {
  for font in $SCRIPT_DIR/fonts/*.ttf; do
    echo "Installing font: ${font}"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        usr_font_dir="$HOME/.local/share/fonts"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        usr_font_dir="$HOME/Library/Fonts"
    fi
    mkdir -p "${usr_font_dir}"

    cp -f "${font}" "${usr_font_dir}"

  done

  # Reset font cache on Linux
  if [[ -n $(command -v fc-cache) ]]; then
    fc-cache -vf "${usr_font_dir}"
  fi
}
