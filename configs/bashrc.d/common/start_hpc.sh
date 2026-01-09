#!/bin/bash

## --- HPC Workflow
# Note: Host info is publically available
check_hpc_access() {
    if timeout 2 bash -c "cat < /dev/null > /dev/tcp/login1.barnard.hpc.tu-dresden.de/22" 2>/dev/null; then
        echo "✓ HPC server reachable"
        return 0
    else
        echo "✗ HPC unreachable. Is VPN active?"
        return 1
    fi
}

# Helper for mount_hpc_workspaces
mount_hpc_workspace() {
    local REMOTE_HOST="login1.barnard.hpc.tu-dresden.de"
    local REMOTE_DIR="$1"
    local MOUNT_NAME="$2"
    local MOUNT_POINT="$HOME/hpc_workspaces/${MOUNT_NAME}"
    
    echo "Processing workspace: ${MOUNT_NAME}"
    
    # Check remote directory accessibility
    if ! ssh -o ConnectTimeout=5 -o BatchMode=yes \
        ${REMOTE_USER}@${REMOTE_HOST} "test -d ${REMOTE_DIR}" 2>/dev/null; then
        echo "✗ Remote directory not accessible: ${REMOTE_DIR}"
        return 1
    fi
    
    # Create mount point if needed
    if [ ! -d "$MOUNT_POINT" ]; then
        mkdir -p "$MOUNT_POINT"
    fi
    
    # Check if already mounted
    if mountpoint -q "$MOUNT_POINT" 2>/dev/null; then
        echo "✓ Already mounted at ${MOUNT_POINT}"
        return 0
    fi
    
    # Mount
    sshfs ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR} "$MOUNT_POINT"
    if [ $? -eq 0 ]; then
        echo "✓ Mounted ${MOUNT_NAME}"
    else
        echo "✗ Mount failed for ${MOUNT_NAME}"
        return 1
    fi
}

# Helper for start_hpc_local
mount_hpc_workspaces() {
    # public info 
    local REMOTE_HOST="login1.barnard.hpc.tu-dresden.de"
    if ! check_hpc_access; then
        echo "Cannot proceed: VPN connection required"
        return 1
    fi
    
    local MOUNT_POINT="$HOME/hpc_workspaces"
    
    # Create mount point directory if it doesn't exist
    if [ ! -d "$MOUNT_POINT" ]; then
        mkdir -p "$MOUNT_POINT"
        echo "Created mount point directory: $MOUNT_POINT"
    fi
    
    # Fetch workspace list
    mapfile -t workspaces < <(
        ssh -o BatchMode=yes ${REMOTE_USER}@${REMOTE_HOST} \
        "ws_show | grep '^/data/'"
    )
    
    if [ ${#workspaces[@]} -eq 0 ]; then
        echo "No active workspaces found"
        return 0
    fi
    
    # Process each workspace
    for ws in "${workspaces[@]}"; do
        # Extract drive name (e.g., "horse" from "/data/horse/...")
        drive=$(echo "$ws" | cut -d/ -f3)
        
        # Extract basename (keeps full name with username)
        ws_name=$(basename "$ws")
        
        # Create mount name: drive-workspace
        mount_name="${drive}-${ws_name}"
        
        mount_hpc_workspace "$ws" "$mount_name"
        echo
    done
}

# Start HPC locally
# Connect hpc directories locally to ~/hpc_workspaces
start_hpc_local() {
    if ! check_hpc_access; then
        echo "Cannot proceed: VPN connection required"
        return 1
    fi
    
    local MOUNT_POINT="$HOME/hpc_workspaces"
    
    # Mount workspaces locally
    mount_hpc_workspaces
    
    # Rename tmux window if inside tmux
    if [ -n "$TMUX" ]; then
        tmux rename-window "󰒏 HPC-LOCAL"
    fi
    
    # Start nvim with working directory set to mount point
    nvim -c "cd $MOUNT_POINT" \
         -c "botright split | resize 20 | lcd $HOME | terminal"
}

# Connect to HPC
# Once connected you need to continue from the server side
# Usage:
#    start_hpc [ barnard | capella ]
start_hpc() {
  # Check VPN connection
  if ! check_hpc_access; then
    echo "Cannot proceed: VPN connection required"
    return 1
  fi
  # Define connection parameters
  local REMOTE_HOST
  
  # Determine server based on argument (default: barnard)
  local SERVER="${1:-barnard}"
  
  case "$SERVER" in
    barnard)
      # public info: gitlab.hrz.tu-chemnitz.de/zih/hpcsupport/hpc-compendium 
      REMOTE_HOST="login1.barnard.hpc.tu-dresden.de"
      echo "Connecting to Barnard..."
      ;;
    capella)
      # public info: gitlab.hrz.tu-chemnitz.de/zih/hpcsupport/hpc-compendium
      REMOTE_HOST="login1.capella.hpc.tu-dresden.de"
      echo "Connecting to Capella..."
      ;;
    *)
      echo "Unknown server: $SERVER"
      echo "Usage: start_hpc [barnard|capella]"
      return 1
      ;;
    esac

    # Check if can connect to barnard1
    echo "Checking SSH connection to ${REMOTE_HOST}..."
    if ! ssh -o ConnectTimeout=5 -o BatchMode=yes ${REMOTE_USER}@${REMOTE_HOST} "exit" 2>/dev/null; then
        echo "✗ Cannot connect to ${REMOTE_HOST}"
        echo "  Check your SSH configuration and credentials"
        return 1
    fi
    echo "✓ SSH connection successful"
    
    # Rename tmux window if inside tmux
    if [ -n "$TMUX" ]; then
        tmux rename-window "󰒋 ${SERVER^^}"
    fi
    
    # Connect via SSH with explicit PATH setting
    ssh ${REMOTE_USER}@${REMOTE_HOST}
}
