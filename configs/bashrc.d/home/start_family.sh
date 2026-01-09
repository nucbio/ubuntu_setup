## -- Geneology Project
start_family() {
  local lang="${1:-eng}"  # Default to 'eng' if no argument provided
  local work_dir
  local tex_file
  
  case "$lang" in
    eng)
      tex_file="$FAMILY_TREE_DIR/geneology_eng.tex"
      ;;
    rus)
      tex_file="$FAMILY_TREE_DIR/geneology_rus.tex"
      ;;
    *)
      echo "Usage: start_family [eng|rus]"
      echo "Default: eng"
      return 1
      ;;
  esac
  
  if [ -n "$TMUX" ]; then
    tmux rename-window "󱘎 Family"
  fi
  
  nvim "$tex_file" \
       -c "cd $FAMILY_TREE_DIR" \
       -c "botright split | resize 20 | lcd $work_dir | terminal"
}
