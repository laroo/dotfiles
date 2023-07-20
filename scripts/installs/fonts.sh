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

    cp -f "${font}" "${usr_font_dir}"

  done

  # Reset font cache on Linux
  if [[ -n $(command -v fc-cache) ]]; then
    fc-cache -vf "${usr_font_dir}"
    case $? in
      [0-1])
        # Catch fc-cache returning 1 on a success
        exit 0
        ;;
      *)
        exit $?
        ;;
    esac
  fi
}
